package vo;

public class ReplyVO {
	//구매후기VO
	private int reply_code,p_info_dcode,user_code, payment_code;
	    public int getPayment_code() {
		return payment_code;
	}
	public void setPayment_code(int payment_code) {
		this.payment_code = payment_code;
	}
	//        댓글 코드              상품 상세코드          회원 코드
	private String reply_content,reply_regdate,reply_ip;
	      //           내용                   작성일                          작성자 ip
	public int getReply_code() {
		return reply_code;
	}
	public void setReply_code(int reply_code) {
		this.reply_code = reply_code;
	}
	
	public int getP_info_dcode() {
		return p_info_dcode;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public void setP_info_dcode(int p_info_dcode) {
		this.p_info_dcode = p_info_dcode;
	}
	public int getUser_code() {
		return user_code;
	}
	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	
	public String getReply_regdate() {
		return reply_regdate;
	}
	public void setReply_regdate(String reply_regdate) {
		this.reply_regdate = reply_regdate;
	}
	public String getReply_ip() {
		return reply_ip;
	}
	public void setReply_ip(String reply_ip) {
		this.reply_ip = reply_ip;
	}
}
