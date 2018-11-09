fn main() {
    use_struct();
}

fn concret_lifetime_same() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}

fn concret_lifetime_different() {
    let string1 = String::from("long string is long");

    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("The longest string is {}", result);
    }
}

// fn concret_lifetime_different_wrong() {
//     let string1 = String::from("long string is long");

//     let result;
//     {
//         let string2 = String::from("xyz");
//         result = longest(string1.as_str(), string2.as_str());
//     }
//     println!("The longest string is {}", result);
// }

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

#[derive(Debug)]
struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn use_struct() {
    let novel;
    let first_sentence;
    {
        novel = String::from("Call me Ishmael. Some years ago...");
        first_sentence = novel.split('.')
            .next()
            .expect("Could not find a '.'");
    }
    println!("The novel is {}", novel);
    let i = ImportantExcerpt { part: novel };
    println!("{:?}", i);
}

