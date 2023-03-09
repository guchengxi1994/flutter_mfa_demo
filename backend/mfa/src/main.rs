pub mod random_code_mfa;
pub mod route;
pub mod utils;
pub mod models;
pub mod controllers;

use actix_web::{App, HttpServer};
use route::match_code;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(match_code))
        .bind(("0.0.0.0", 15285))?
        .run()
        .await
}
