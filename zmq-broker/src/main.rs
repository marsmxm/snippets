fn main() {
    let context = zmq::Context::new();
    let xpub = context.socket(zmq::XPUB).unwrap();
    let xsub = context.socket(zmq::XSUB).unwrap();

    xpub
        .bind("tcp://*:5559")
        .expect("failed binding frontend");
    xsub
        .bind("tcp://*:5560")
        .expect("failed binding backend");

    zmq::proxy(&xpub, &xsub).expect("failed to proxy");
}
