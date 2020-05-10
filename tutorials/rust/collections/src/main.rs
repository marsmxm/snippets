fn main() {
    for number in (1..4).rev() {
        println!("{}!", number);
    }
    println!("LIFTOFF!!!");
    
    let mut a = [1, 2, 3, 4, 5];
    a[0] = 0;
    println!("a is: {:?}", a);

    let v = vec![1, 2, 3, 4, 5];

    for (i, e1) in v.iter().enumerate() {
        for (j, e2) in v.iter().enumerate() {
            if i != j && e1 + e2 == 6 {
                println!("i:{}, j:{}", i as i32, j as i32);
            }
        }
    }

    // let does_not_exist = &v[100];
    // println!("{:?}", does_not_exist);
    let does_not_exist = v.get(101);
    println!("{:?}", does_not_exist);
}
