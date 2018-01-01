package org.lenskit.mooc.uu;

import it.unimi.dsi.fastutil.longs.Long2DoubleOpenHashMap;

import java.util.Comparator;

/**
 * @author mxm
 */
class Neighbor {
    final long user;
    final Long2DoubleOpenHashMap normalizedRatings;
    final double similarity;

    Neighbor(long user, Long2DoubleOpenHashMap ratings, double similarity) {
        this.user = user;
        this.normalizedRatings = ratings;
        this.similarity = similarity;
    }

    static final Comparator<Neighbor> SIMILARITY_COMPARATOR = new Comparator<Neighbor>() {
        @Override
        public int compare(Neighbor n1, Neighbor n2) {
            return Double.compare(-n1.similarity, -n2.similarity);
        }
    };

}
