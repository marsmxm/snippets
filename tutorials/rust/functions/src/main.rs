fn main() {
    println!("Hello, world!");

    another_function(6);
    condition();
}

fn another_function(x: i32) {
    let y = five();
    println!("The value of x is: {}, y is {}", x, y);
}

fn five() -> i32 {
    5
}

fn condition() {
    let number = 3;

    if number < 5 {
        println!("condition was true");
    } else {
        println!("condition was false");
    }
}

