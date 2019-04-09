package host.mxm.sample;

import java.util.Arrays;

public class ThisEscape {

    public ThisEscape(EventSource source) throws NoSuchFieldException, IllegalAccessException {
        source.registerListener(new EventListener() {
            @Override
            public void onEvent() {

            }
        });
    }

    public static void main(String[] args) throws NoSuchFieldException, IllegalAccessException {
        new ThisEscape(new EventSource());
    }

    static class EventSource {
        void registerListener(EventListener listener) throws NoSuchFieldException, IllegalAccessException {
            System.out.println(listener.getClass().getField("this$0").get(listener));
        }
    }

    interface EventListener {
        void onEvent();
    }
}
