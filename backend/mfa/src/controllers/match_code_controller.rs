use actix_web::{web, Result};

use crate::{models::mfa_code_request::MfaCodeRequest, random_code_mfa::mfa_match_code};

pub async fn exec_match_code(request: web::Json<MfaCodeRequest>) -> Result<bool> {
    let r = mfa_match_code(request.userinfo.clone(), request.code.clone());
    Ok(r)
}
