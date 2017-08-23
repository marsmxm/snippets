package edu.coursera.parallel;

import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

/**
 * Class wrapping methods for implementing reciprocal array sum in parallel.
 */
public final class ReciprocalArraySum {
    static {
        int cores = Runtime.getRuntime().availableProcessors();
        System.out.println("cores: " + cores);
        System.setProperty("java.util.concurrent.ForkJoinPool.common.parallelism",
                Integer.toString(cores));
    }

    /**
     * Default constructor.
     */
    private ReciprocalArraySum() {
    }

    /**
     * Sequentially compute the sum of the reciprocal values for a given array.
     *
     * @param input Input array
     * @return The sum of the reciprocals of the array input
     */
    protected static double seqArraySum(final double[] input) {
        double sum = 0;

        // Compute sum of reciprocals of array elements
        for (int i = 0; i < input.length; i++) {
            sum += 1 / input[i];
        }

        return sum;
    }

    /**
     * Computes the size of each chunk, given the number of chunks to create
     * across a given number of elements.
     *
     * @param nChunks The number of chunks to create
     * @param nElements The number of elements to chunk across
     * @return The default chunk size
     */
    private static int getChunkSize(final int nChunks, final int nElements) {
        // Integer ceil
        return (nElements + nChunks - 1) / nChunks;
    }

    /**
     * Computes the inclusive element index that the provided chunk starts at,
     * given there are a certain number of chunks.
     *
     * @param chunk The chunk to compute the start of
     * @param nChunks The number of chunks created
     * @param nElements The number of elements to chunk across
     * @return The inclusive index that this chunk starts at in the set of
     *         nElements
     */
    private static int getChunkStartInclusive(final int chunk,
            final int nChunks, final int nElements) {
        final int chunkSize = getChunkSize(nChunks, nElements);
        return chunk * chunkSize;
    }

    /**
     * Computes the exclusive element index that the provided chunk ends at,
     * given there are a certain number of chunks.
     *
     * @param chunk The chunk to compute the end of
     * @param nChunks The number of chunks created
     * @param nElements The number of elements to chunk across
     * @return The exclusive end index for this chunk
     */
    private static int getChunkEndExclusive(final int chunk, final int nChunks,
            final int nElements) {
        final int chunkSize = getChunkSize(nChunks, nElements);
        final int end = (chunk + 1) * chunkSize;
        if (end > nElements) {
            return nElements;
        } else {
            return end;
        }
    }

    /**
     * This class stub can be filled in to implement the body of each task
     * created to perform reciprocal array sum in parallel.
     */
    private static class ReciprocalArraySumTask extends RecursiveAction {
        /**
         * Starting index for traversal done by this task.
         */
        private final int startIndexInclusive;
        /**
         * Ending index for traversal done by this task.
         */
        private final int endIndexExclusive;
        /**
         * Input array to reciprocal sum.
         */
        private final double[] input;

        private final int seqThreshold;
        /**
         * Intermediate value produced by this task.
         */
        private double value;

        /**
         * Constructor.
         * @param setStartIndexInclusive Set the starting index to begin
         *        parallel traversal at.
         * @param setEndIndexExclusive Set ending index for parallel traversal.
         * @param setInput Input values
         */
        ReciprocalArraySumTask(final int setStartIndexInclusive,
                final int setEndIndexExclusive, final double[] setInput, int seqThreshold) {
            this.startIndexInclusive = setStartIndexInclusive;
            this.endIndexExclusive = setEndIndexExclusive;
            this.input = setInput;
            this.seqThreshold = seqThreshold;
        }

        /**
         * Getter for the value produced by this task.
         * @return Value produced by this task
         */
        public double getValue() {
            return value;
        }

        @Override
        protected void compute() {
//            if (numTasks > 1) {
//                ReciprocalArraySumTask[] tasks = new ReciprocalArraySumTask[numTasks];
//                for (int i = 0; i < numTasks; i++) {
//                    int startInclusive = getChunkStartInclusive(i, numTasks, input.length);
//                    int endExclusive = getChunkEndExclusive(i, numTasks, input.length);
//                    tasks[i] = new ReciprocalArraySumTask(startInclusive, endExclusive, input, 1);
//                }
//                invokeAll(tasks);
//                for (ReciprocalArraySumTask task : tasks) {
//                    value += task.getValue();
//                }
//            } else {
//                computeDirectly();
//            }

//            if (numTasks > 1) {
//                int halfNum = numTasks / 2;
//                int mid = getChunkEndExclusive(halfNum - 1, numTasks, endIndexExclusive - startIndexInclusive);
//                ReciprocalArraySumTask t1 = new ReciprocalArraySumTask(startIndexInclusive, mid, input, halfNum);
//                ReciprocalArraySumTask t2 = new ReciprocalArraySumTask(mid, endIndexExclusive, input, numTasks - halfNum);
//                invokeAll(t1, t2);
//                value = t1.getValue() + t2.getValue();
//            } else {
//                computeDirectly();
//            }

            if (endIndexExclusive - startIndexInclusive <= seqThreshold) {
                computeDirectly();
            } else {
                int mid = (startIndexInclusive + endIndexExclusive) / 2;
                ReciprocalArraySumTask t1 = new ReciprocalArraySumTask(startIndexInclusive, mid, input, seqThreshold);
                ReciprocalArraySumTask t2 = new ReciprocalArraySumTask(mid, endIndexExclusive, input, seqThreshold);
                t1.fork();
                t2.compute();
                t1.join();
                value = t1.getValue() + t2.getValue();
            }
        }

        private void computeDirectly() {
            double sum = 0;

            // Compute sum of reciprocals of array elements
            for (int i = startIndexInclusive; i < endIndexExclusive; i++) {
                sum += 1 / input[i];
            }

            value = sum;
        }
    }

    /**
     * Modify this method to compute the same reciprocal sum as
     * seqArraySum, but use two tasks running in parallel under the Java Fork
     * Join framework. You may assume that the length of the input array is
     * evenly divisible by 2.
     *
     * @param input Input array
     * @return The sum of the reciprocals of the array input
     */
    protected static double parArraySum(final double[] input) {
        assert input.length % 2 == 0;

        return parManyTaskArraySum(input, 2);
    }

    /**
     * Extend the work you did to implement parArraySum to use a set
     * number of tasks to compute the reciprocal array sum. You may find the
     * above utilities getChunkStartInclusive and getChunkEndExclusive helpful
     * in computing the range of element indices that belong to each chunk.
     *
     * @param input Input array
     * @param numTasks The number of tasks to create
     * @return The sum of the reciprocals of the array input
     */
    protected static double parManyTaskArraySum(final double[] input,
            final int numTasks) {
        ReciprocalArraySumTask task = new ReciprocalArraySumTask(0, input.length, input, input.length / numTasks + 1);
        ForkJoinPool.commonPool().invoke(task);
        return task.getValue();
    }
}
