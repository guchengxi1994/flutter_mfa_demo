pub mod controllers;
pub mod models;
pub mod random_code_mfa;
pub mod route;
pub mod utils;

use actix_cors::Cors;
use actix_web::{App, HttpServer};
use route::match_code;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(move || {
        App::new()
            .wrap(Cors::default().allow_any_origin().send_wildcard())
            .service(match_code)
    })
    .bind(("0.0.0.0", 15285))?
    .run()
    .await
}
