package vo;

public class P_detailVO {
	private int p_info_dcode, p_detail_cell, p_info_code, user_code; //user_code 필요에 의해 여기만 추가
	public int getUser_code() {
		return user_code;
	}
	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	private String p_detail_size, p_detail_color;
	public int getP_detail_cell() {
		return p_detail_cell;
	}
	public void setP_detail_cell(int p_detail_cell) {
		this.p_detail_cell = p_detail_cell;
	}
	public String getP_detail_size() {
		return p_detail_size;
	}
	public void setP_detail_size(String p_detail_size) {
		this.p_detail_size = p_detail_size;
	}
	public String getP_detail_color() {
		return p_detail_color;
	}
	public void setP_detail_color(String p_detail_color) {
		this.p_detail_color = p_detail_color;
	}
	public int getP_info_dcode() {
		return p_info_dcode;
	}
	public void setP_info_dcode(int p_info_dcode) {
		this.p_info_dcode = p_info_dcode;
	}
	public int getP_info_code() {
		return p_info_code;
	}
	public void setP_info_code(int p_info_code) {
		this.p_info_code = p_info_code;
	}
	
}
