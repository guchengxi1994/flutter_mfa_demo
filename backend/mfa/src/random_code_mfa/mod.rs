pub mod algorithm;
pub mod tests;

pub fn mfa_match_code(userinfo: String, code: String) -> bool {
    let generated = algorithm::Algorithm::generate(userinfo);
    return code == generated;
}
