use std::collections::HashSet;

fn length_of_longest_substring(s: String) -> i32 {
    // brute force
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        for j in i..s.len() {

        }
    }

    1
}

fn has_repeated(s: &str) -> bool {
    let mut chars = HashSet::new();
    for (i, &char) in s.chars().enumerate() {
        chars.insert(char);
    }
    false
}

fn main() {
    println!("Hello, world!");
}
