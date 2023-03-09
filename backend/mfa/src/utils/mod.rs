pub struct CommonUtils;

impl CommonUtils {
    pub fn md5_(s:String)->String{
        let digest = md5::compute(s);

        return format!("{:?}",digest);
    }
}