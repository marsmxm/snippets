package lab;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.Instant;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author sam
 * @date 6/7/16
 */
public class Lab {
    private static void f(List<? extends Person> ps) {

    }

    public static void main(String[] args) throws URISyntaxException {
        LocalDate today = LocalDate.now();

        System.out.println(String.format("%d%tm", today.getYear(), today.getMonth()));
        System.out.println(Instant.ofEpochMilli(1464624000000L));
    }
}

class Person {}

class Staff extends Person {}