pub mod controllers;
pub mod models;
pub mod random_code_mfa;
pub mod route;
pub mod utils;

use actix_cors::Cors;
use actix_web::{App, HttpServer};
use route::{match_code, one_click, one_click_canlogin, one_click_query};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(move || {
        App::new()
            .wrap(Cors::default().allow_any_origin().send_wildcard())
            .service(match_code)
            .service(one_click_query)
            .service(one_click_canlogin)
            .configure(one_click)
    })
    .bind(("0.0.0.0", 15285))?
    .run()
    .await
}
