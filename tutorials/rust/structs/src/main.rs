fn main() {
    struct Point(i32, i32, i32);

    let origin = Point(0, 0, 0);
    let Point(x, y, z) = origin;
    println!("{}, {}, {}", x, y, z);
}
