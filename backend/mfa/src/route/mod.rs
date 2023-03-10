use actix_web::{get, post, web, HttpResponse, Responder};
use redis::Commands;

use crate::{
    controllers::{
        match_code_controller::exec_match_code,
        one_click_controller::{request_before_login_confirm, request_login_confirm},
    },
    models::{mfa_code_request::MfaCodeRequest, mfa_one_click_request::MfaOneClickRequest},
};

#[post("/codeMatch")]
pub async fn match_code(request: web::Json<MfaCodeRequest>) -> impl Responder {
    let r = exec_match_code(request).await;
    match r {
        Ok(r0) => HttpResponse::Ok().body(r0.to_string()),
        Err(_) => HttpResponse::Ok().body("error"),
    }
}

async fn one_click_first(request: web::Json<MfaOneClickRequest>) -> impl Responder {
    request_before_login_confirm(request).await;
    HttpResponse::Ok().body("ok")
}

async fn one_click_second(request: web::Json<MfaOneClickRequest>) -> impl Responder {
    let r = request_login_confirm(request).await;
    HttpResponse::Ok().body(r)
}

#[get("/oneClick/{userinfo}")]
async fn one_click_query(info: web::Path<String>) -> impl Responder {
    let mut key: String = String::new();
    key = key + &info;
    key = key + &String::from("_need_login");
    let mut r = crate::utils::redis_utils::REDIS_CLIENT_CONNECTION
        .lock()
        .unwrap();
    let d: i64 = r.get(key.clone()).unwrap_or(-1);
    HttpResponse::Ok().body(d.to_string())
}

#[get("/oneClick/{userinfo}/canLogin")]
async fn one_click_canlogin(info: web::Path<String>) -> impl Responder {
    let mut r = crate::utils::redis_utils::REDIS_CLIENT_CONNECTION
        .lock()
        .unwrap();
    let d: bool = r.get(format!("{}_can_login", info)).unwrap_or(false);
    if d {
        let _: () = r.del(format!("{}_can_login", info)).unwrap();
    }
    HttpResponse::Ok().body(d.to_string())
}

pub fn one_click(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/oneClick")
            .route("/second", web::post().to(one_click_second))
            .route("/first", web::post().to(one_click_first)),
    );
}
