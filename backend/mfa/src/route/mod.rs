use actix_web::{post, web, HttpResponse, Responder};

use crate::{
    controllers::match_code_controller::exec_match_code, models::mfa_code_request::MfaCodeRequest,
};

#[post("/codeMatch")]
pub async fn match_code(request: web::Json<MfaCodeRequest>) -> impl Responder {
    let r = exec_match_code(request).await;
    match r {
        Ok(r0) => HttpResponse::Ok().body(r0.to_string()),
        Err(_) => HttpResponse::Ok().body("error"),
    }
}
