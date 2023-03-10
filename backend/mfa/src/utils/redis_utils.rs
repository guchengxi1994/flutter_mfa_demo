use std::sync::Mutex;

use lazy_static::lazy_static;
use redis::Connection;

lazy_static! {
    pub static ref REDIS_CLIENT_CONNECTION: Mutex<Connection> = {
        let client = redis::Client::open("redis://127.0.0.1/").unwrap();
        let con = client.get_connection().unwrap();
        Mutex::new(con)
    };
}
