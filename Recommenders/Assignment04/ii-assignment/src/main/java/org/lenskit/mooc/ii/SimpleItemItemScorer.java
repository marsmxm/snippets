package org.lenskit.mooc.ii;

import it.unimi.dsi.fastutil.longs.Long2DoubleMap;
import it.unimi.dsi.fastutil.longs.Long2DoubleOpenHashMap;
import org.lenskit.api.Result;
import org.lenskit.api.ResultMap;
import org.lenskit.basic.AbstractItemScorer;
import org.lenskit.data.dao.DataAccessObject;
import org.lenskit.data.entities.CommonAttributes;
import org.lenskit.data.ratings.Rating;
import org.lenskit.results.Results;
import org.lenskit.util.math.Vectors;

import javax.annotation.Nonnull;
import javax.inject.Inject;
import java.util.*;

/**
 * @author <a href="http://www.grouplens.org">GroupLens Research</a>
 */
public class SimpleItemItemScorer extends AbstractItemScorer {
    private final SimpleItemItemModel model;
    private final DataAccessObject dao;
    private final int neighborhoodSize;

    @Inject
    public SimpleItemItemScorer(SimpleItemItemModel m, DataAccessObject dao) {
        model = m;
        this.dao = dao;
        neighborhoodSize = 20;
    }

    /**
     * Score items for a user.
     * @param user The user ID.
     * @param items The score vector.  Its key domain is the items to score, and the scores
     *               (rating predictions) should be written back to this vector.
     */
    @Override
    public ResultMap scoreWithDetails(long user, @Nonnull Collection<Long> items) {
        Long2DoubleMap itemMeans = model.getItemMeans();
        Long2DoubleMap ratings = getUserRatingVector(user);

        // TODO Normalize the user's ratings by subtracting the item mean from each one.
        for (Map.Entry<Long, Double> entry : ratings.entrySet()) {
            entry.setValue(entry.getValue() - itemMeans.get(entry.getKey()));
        }

        List<Result> results = new ArrayList<>();

        for (long item: items) {
            // TODO Compute the user's score for each item, add it to results
            Long2DoubleMap neighbors20 = get20NeighborsInOrder(model.getNeighbors(item), ratings);

            double score = itemMeans.get(item)
                    + Vectors.dotProduct(neighbors20, ratings) / neighbors20.values().stream().mapToDouble(d -> d).sum();
            results.add(Results.create(item, score));
        }

        return Results.newResultMap(results);
    }

    /**
     * Get a user's ratings.
     * @param user The user ID.
     * @return The ratings to retrieve.
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

    private Long2DoubleMap get20NeighborsInOrder(Long2DoubleMap neighbors, Long2DoubleMap ratings) {
        Long2DoubleMap result = new Long2DoubleOpenHashMap();
        // to sort items by similarities in desc order
        TreeSet<Long> items = new TreeSet<>(Comparator.comparingDouble(o -> -neighbors.get(o)));
        items.addAll(neighbors.keySet());

        int counter = 0;
        for (Long item : items) {
            if (counter >= neighborhoodSize) {
                return result;
            } else if (ratings.containsKey(item)) {
                result.put(item, neighbors.get(item));
                counter++;
            }
        }

        return result;
    }

}
