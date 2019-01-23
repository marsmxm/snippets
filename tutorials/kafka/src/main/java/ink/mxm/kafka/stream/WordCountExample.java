package ink.mxm.kafka.stream;

import java.util.Arrays;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;
import java.util.regex.Pattern;

import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.Materialized;

/**
 *
 * @author Mu Xian Ming (Sam)
 */
public final class WordCountExample {

    public static void main(String[] args) throws Exception {
        Properties props = new Properties();
        props.setProperty(StreamsConfig.APPLICATION_ID_CONFIG, "wordcount");
        props.setProperty(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        props.setProperty(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
        props.setProperty(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());

        StreamsBuilder builder = new StreamsBuilder();
        final Pattern pattern = Pattern.compile("\\W+");
        KStream<String, String> counts =
                builder.<String, String>stream("wordcount-input")
                       .flatMapValues(value -> Arrays.asList(pattern.split(value.toLowerCase())))
                       .map((key, value) -> new KeyValue<>(value, value))
                       .filter((key, value) -> !"the".equals(value))
                       .groupByKey()
                       .count(Materialized.as("CountStore"))
                       .mapValues(value -> Long.toString(value))
                       .toStream();
        counts.to("wordcount-output");
        KafkaStreams streams = new KafkaStreams(builder.build(), props);

        final CountDownLatch latch = new CountDownLatch(1);

        Runtime.getRuntime().addShutdownHook(new Thread("streams-wordcount-shutdown-hook") {
            @Override
            public void run() {
                streams.close();
                latch.countDown();
            }
        });

        try {
            streams.start();
            latch.await();
        } catch (final Throwable e) {
            System.exit(1);
        }
        System.exit(0);
    }
}

