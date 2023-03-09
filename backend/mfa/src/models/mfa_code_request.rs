use serde::Deserialize;

#[derive(Deserialize)]
pub struct MfaCodeRequest{
    pub userinfo:String,
    pub code:String
}