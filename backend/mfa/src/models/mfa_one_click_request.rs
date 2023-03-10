use serde::Deserialize;

#[derive(Deserialize)]
pub struct MfaOneClickRequest{
    pub userinfo:String,
    pub login_time:i64
}