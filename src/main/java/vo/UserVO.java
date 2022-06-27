package vo;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {

	private int  user_code, user_status, user_total, user_class, user_gender, user_birth;
	//          고객고유번호         회원 상태                  누적 결제금액         회원등급               성별                    생년월일  
	private String user_id, user_pw, user_name, user_tel, user_logdate;
	//       	   회원 아이디          회원 비번         회원 이름              회원 전화번호
	private String user_email, user_addr, user_daddr, user_regdate,user_profile,user_nick;
	//               회원 이메일         회원 주소             				가입일                      프로필 사진               닉네임
	private MultipartFile user_photo;
	//        프로필 사진의 저장을 위한 객체 (실제 DB에 없는 컬럼)
	
	public String getUser_logdate() {
		return user_logdate;
	}

	public MultipartFile getUser_photo() {
		return user_photo;
	}

	public void setUser_photo(MultipartFile user_photo) {
		this.user_photo = user_photo;
	}

	public void setUser_logdate(String user_logdate) {
		this.user_logdate = user_logdate;
	}

	public String getUser_daddr() {
		return user_daddr;
	}

	public void setUser_daddr(String user_daddr) {
		this.user_daddr = user_daddr;
	}

	public String getUser_profile() {
		return user_profile;
	}

	public void setUser_profile(String user_profile) {
		this.user_profile = user_profile;
	}

	public String getUser_nick() {
		return user_nick;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}

	public int getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(int user_gender) {
		this.user_gender = user_gender;
	}

	public int getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(int user_birth) {
		this.user_birth = user_birth;
	}

	
	public int getUser_code() {
		return user_code;
	}

	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}

	public int getUser_status() {
		return user_status;
	}

	public void setUser_status(int user_status) {
		this.user_status = user_status;
	}

	public int getUser_total() {
		return user_total;
	}

	public void setUser_total(int user_total) {
		this.user_total = user_total;
	}

	public int getUser_class() {
		return user_class;
	}

	public void setUser_class(int user_class) {
		this.user_class = user_class;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(String user_regdate) {
		this.user_regdate = user_regdate;
	}

}
