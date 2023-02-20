FROM rust:1.67

WORKDIR /usr/src/zmq-broker
COPY . .

RUN cargo install --path .

CMD ["zmq-broker"]