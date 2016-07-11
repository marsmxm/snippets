package lab;

import com.google.common.collect.Lists;

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
        Person p = ps.get(0);
        System.out.println(p);
    }

    private static void g(List<? super Staff> ss) {
        ss.add(new Staff());
        System.out.println(ss);
    }

    public static void main(String[] args) throws URISyntaxException, CloneNotSupportedException {
        Person p = new Person();
        System.out.println(p);
        System.out.println(p.clone());


        LocalDate today = LocalDate.now();

        System.out.println(String.format("%d%tm", today.getYear(), today.getMonth()));
        System.out.println(Instant.ofEpochMilli(1464624000000L));
    }
}

class Person implements Cloneable {

    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}

class Staff extends Person {
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}