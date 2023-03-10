use crate::models::mfa_one_click_request::MfaOneClickRequest;
use actix_web::web;
use redis::Commands;

const DURATION: i64 = 60;

pub async fn request_before_login_confirm(request: web::Json<MfaOneClickRequest>) {
    let mut key: String = String::new();
    key = key + &request.userinfo;
    key = key + &String::from("_need_login");
    let mut r = crate::utils::redis_utils::REDIS_CLIENT_CONNECTION
        .lock()
        .unwrap();
    let _: () = r.set(key, request.login_time).unwrap();
}

pub async fn request_login_confirm(request: web::Json<MfaOneClickRequest>) -> String {
    let mut key: String = String::new();
    key = key + &request.userinfo;
    key = key + &String::from("_need_login");
    let mut r = crate::utils::redis_utils::REDIS_CLIENT_CONNECTION
        .lock()
        .unwrap();
    let d: i64 = r.get(key.clone()).unwrap_or(-1);
    let _: () = r.set(format!("{}_can_login",request.userinfo), true).unwrap();
    let _: () = r.del(key).unwrap();
    if d == -1 {
        return String::from("no login request");
    } else {
        if request.login_time - d >= 0 && request.login_time - d <= DURATION {
            return String::from("ok");
        } else {
            return String::from("out of time");
        }
    }
}
