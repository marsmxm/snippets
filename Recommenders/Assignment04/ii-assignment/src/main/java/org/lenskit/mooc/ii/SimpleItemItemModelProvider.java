package org.lenskit.mooc.ii;

import com.google.common.collect.Maps;
import it.unimi.dsi.fastutil.longs.Long2DoubleMap;
import it.unimi.dsi.fastutil.longs.Long2DoubleOpenHashMap;
import org.lenskit.data.dao.DataAccessObject;
import org.lenskit.data.entities.CommonAttributes;
import org.lenskit.data.ratings.Rating;
import org.lenskit.data.ratings.Ratings;
import org.lenskit.inject.Transient;
import org.lenskit.util.IdBox;
import org.lenskit.util.collections.LongUtils;
import org.lenskit.util.io.ObjectStream;
import org.lenskit.util.math.Vectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.inject.Provider;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @author <a href="http://www.grouplens.org">GroupLens Research</a>
 */
public class SimpleItemItemModelProvider implements Provider<SimpleItemItemModel> {
    private static final Logger logger = LoggerFactory.getLogger(SimpleItemItemModelProvider.class);

    private final DataAccessObject dao;

    /**
     * Construct the model provider.
     * @param dao The data access object.
     */
    @Inject
    public SimpleItemItemModelProvider(@Transient DataAccessObject dao) {
        this.dao = dao;
    }

    /**
     * Construct the item-item model.
     * @return The item-item model.
     */
    @Override
    public SimpleItemItemModel get() {
        Map<Long,Long2DoubleMap> itemVectors = Maps.newHashMap();
        Long2DoubleMap itemMeans = new Long2DoubleOpenHashMap();

        try (ObjectStream<IdBox<List<Rating>>> stream = dao.query(Rating.class)
                                                           .groupBy(CommonAttributes.ITEM_ID)
                                                           .stream()) {
            for (IdBox<List<Rating>> item : stream) {
                long itemId = item.getId();
                List<Rating> itemRatings = item.getValue();
                Long2DoubleOpenHashMap ratings = new Long2DoubleOpenHashMap(Ratings.itemRatingVector(itemRatings));

                // Compute and store the item's mean.
                double mean = Vectors.mean(ratings);
                itemMeans.put(itemId, mean);

                // Mean center the ratings.
                for (Map.Entry<Long, Double> entry : ratings.entrySet()) {
                    entry.setValue(entry.getValue() - mean);
                }

                itemVectors.put(itemId, LongUtils.frozenMap(ratings));
            }
        }

        // Map items to vectors (maps) of item similarities.
        Map<Long,Long2DoubleMap> itemSimilarities = Maps.newHashMap();

        // TODO Compute the similarities between each pair of items
        // Ignore non-positive similarities
        for (Map.Entry<Long, Long2DoubleMap> entryI : itemVectors.entrySet()) {
            Long keyI = entryI.getKey();
            Long2DoubleMap similarities = new Long2DoubleOpenHashMap();

            for (Map.Entry<Long, Long2DoubleMap> entryJ : itemVectors.entrySet()) {
                Long keyJ = entryJ.getKey();
                if (!Objects.equals(keyI, keyJ)) {
                    // check if i exits in j's similarities map
                    if (itemSimilarities.containsKey(keyJ) && itemSimilarities.get(keyJ).containsKey(keyI)) {
                        similarities.put(keyJ, itemSimilarities.get(keyJ).get(keyI));
                    } else {
                        Long2DoubleMap valueI = entryI.getValue();
                        Long2DoubleMap valueJ = entryJ.getValue();
                        Double similarity = Vectors.dotProduct(valueI, valueJ)
                                / (Vectors.euclideanNorm(valueI) * Vectors.euclideanNorm(valueJ));

                        if (similarity > 0) {
                            similarities.put(keyJ, similarity);
                        }
                    }
                }
            }

            itemSimilarities.put(keyI, similarities);
        }

        return new SimpleItemItemModel(LongUtils.frozenMap(itemMeans), itemSimilarities);
    }
}
