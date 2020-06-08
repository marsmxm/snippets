use std::collections::HashSet;
use std::iter::FromIterator;
use std::collections::hash_map::RandomState;


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
    let chars: HashSet<&u8, RandomState> = HashSet::from_iter(s.as_bytes().iter());
    chars.len() < s.len()
}

fn main() {
    println!("Hello, world!");
}
