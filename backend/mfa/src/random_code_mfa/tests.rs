#[test]
fn generate_code_test(){
    let r = super::algorithm::Algorithm::generate(String::from("xiaoshuyui"));
    println!("{:?}",r)
}