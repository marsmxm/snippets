package lab;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author sam
 * @date 6/7/16
 */
public class Lab {
    private static void f(List<? extends Person> ps) {

    }

    public static void main(String[] args) throws URISyntaxException {
        List<Staff> ss = new ArrayList<>();
        List<Person> ps = new ArrayList<>();
        f(ss);
    }
}

class Person {}

class Staff extends Person {}