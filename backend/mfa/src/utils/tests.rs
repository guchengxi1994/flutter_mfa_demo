#[allow(unused_imports)]
use redis::Commands;

#[test]
fn redis_test() {
    let mut r = super::redis_utils::REDIS_CLIENT_CONNECTION.lock().unwrap();
    let res = r.get(String::from("name")).unwrap_or(String::new());
    println!("{:?}",res)
}
