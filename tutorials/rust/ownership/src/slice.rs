fn main() {
    let s = String::from("hello world");
    println!("{}", first_word(&s));
    println!("{}", first_word("hello world"));
    println!("{}", first_word_slice(&s));
    println!("{}", first_word_slice("hello world"));
}

fn first_word(s: &str) -> usize {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return i;
        }
    }

    s.len()
}

fn first_word_slice(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}