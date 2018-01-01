package org.lenskit.mooc.uu;

import it.unimi.dsi.fastutil.longs.Long2DoubleOpenHashMap;
import org.lenskit.api.Result;
import org.lenskit.api.ResultMap;
import org.lenskit.basic.AbstractItemScorer;
import org.lenskit.data.dao.DataAccessObject;
import org.lenskit.data.entities.CommonAttributes;
import org.lenskit.data.ratings.Rating;
import org.lenskit.results.Results;
import org.lenskit.util.IdBox;
import org.lenskit.util.math.Vectors;

import javax.annotation.Nonnull;
import javax.inject.Inject;
import java.util.*;

/**
 * User-user item scorer.
 * @author <a href="http://www.grouplens.org">GroupLens Research</a>
 */
public class SimpleUserUserItemScorer extends AbstractItemScorer {
    private final DataAccessObject dao;
    private final int neighborhoodSize;

    /**
     * Instantiate a new user-user item scorer.
     * @param dao The data access object.
     */
    @Inject
    public SimpleUserUserItemScorer(DataAccessObject dao) {
        this.dao = dao;
        neighborhoodSize = 30;
    }

    @Nonnull
    @Override
    public ResultMap scoreWithDetails(long user, @Nonnull Collection<Long> items) {
        List<Result> results = new ArrayList<>();

        // get target user's mean and normalized ratings
        Long2DoubleOpenHashMap targetUserRatings = getUserRatingVector(user);
        double targetUserMean = Vectors.mean(targetUserRatings);
        // normalize
        for (Map.Entry<Long, Double> entry : targetUserRatings.entrySet()) {
            entry.setValue(entry.getValue() - targetUserMean);
        }

        List<Neighbor> neighbors = getSortedNeighbors(targetUserRatings);

        for (long item : items) {
            List<Neighbor> neighborsOfItem = findNeighborsOfItem(neighbors, item);
            if (neighborsOfItem.size() >= 2) {
                double numerator = 0;
                double denominator = 0;
                for (Neighbor neighbor : neighborsOfItem) {
                    numerator += neighbor.similarity * neighbor.normalizedRatings.get(item);
                    denominator += Math.abs(neighbor.similarity);
                }

                double score = targetUserMean + numerator / denominator;
                results.add(Results.create(item, score));
            }
        }

        return Results.newResultMap(results);
    }

    /**
     * Get a user's rating vector.
     * @param user The user ID.
     * @return The rating vector, mapping item IDs to the user's rating
     *         for that item.
     */
    private Long2DoubleOpenHashMap getUserRatingVector(long user) {
        List<Rating> history = dao.query(Rating.class)
                                  .withAttribute(CommonAttributes.USER_ID, user)
                                  .get();

        Long2DoubleOpenHashMap ratings = new Long2DoubleOpenHashMap();
        for (Rating r: history) {
            ratings.put(r.getItemId(), r.getValue());
        }

        return ratings;
    }

    private List<Neighbor> getSortedNeighbors(Long2DoubleOpenHashMap targetUserRatings) {
        List<Neighbor> neighbors = new ArrayList<>();

        List<IdBox<List<Rating>>> allRatings = dao.query(Rating.class)
                .groupBy(CommonAttributes.USER_ID)
                .get();

        for (IdBox<List<Rating>> userBox : allRatings) {
            long user = userBox.getId();
            double mean = getMeanScore(userBox.getValue());
            Long2DoubleOpenHashMap normalized = new Long2DoubleOpenHashMap();
            for (Rating rating : userBox.getValue()) {
                normalized.put(rating.getItemId(), rating.getValue() - mean);
            }

            double similarity = getSimilarity(targetUserRatings, normalized);
            neighbors.add(new Neighbor(user, normalized, similarity));
        }

        Collections.sort(neighbors, Neighbor.SIMILARITY_COMPARATOR);

        return neighbors;
    }

    private List<Neighbor> findNeighborsOfItem(List<Neighbor> sortedNeighbors, long item) {
        List<Neighbor> result = new ArrayList<>();

        for (Neighbor neighbor : sortedNeighbors) {
            if (result.size() == neighborhoodSize) {
                return result;
            } else {
                if (neighbor.normalizedRatings.containsKey(item)) {
                    result.add(neighbor);
                }
            }
        }

        return result;
    }

    private double getMeanScore(List<Rating> ratings) {
        if (ratings.size() == 0) {
            return 0;
        } else {
            double sum = 0;
            for (Rating rating : ratings) {
                sum += rating.getValue();
            }
            return sum / ratings.size();
        }
    }

    private double getSimilarity(Long2DoubleOpenHashMap ratings1, Long2DoubleOpenHashMap ratings2) {
        return Vectors.dotProduct(ratings1, ratings2)
                / (Vectors.euclideanNorm(ratings1) * Vectors.euclideanNorm(ratings2));
    }
}
