use crate::utils::CommonUtils;
use chrono::{DateTime, Duration, Local, Timelike};

const PERIOD_DURATION: u32 = 15;
const CODE_LENGTH: usize = 5;

pub struct Algorithm;

impl Algorithm {
    fn get_rest_time(current: DateTime<Local>) -> u32 {
        let current_second = current.second();
        return PERIOD_DURATION - current_second % PERIOD_DURATION;
    }

    fn generate_code(userinfo: String, current: DateTime<Local>) -> String {
        let mut s: String = String::new();
        s = s + &userinfo;
        s = s + &(current.timestamp_millis() / 1000).to_string();
        return CommonUtils::md5_(s)[0..CODE_LENGTH].to_string().to_uppercase();
    }

    pub fn generate(userinfo: String) -> String {
        let current = Local::now();
        let rest_time = Self::get_rest_time(current);
        let code: String;
        if rest_time == 0 {
            code = Self::generate_code(userinfo, current);
        } else {
            let before = current - Duration::seconds((PERIOD_DURATION - rest_time).into());
            code = Self::generate_code(userinfo, before);
        }
        return code;
    }
}
