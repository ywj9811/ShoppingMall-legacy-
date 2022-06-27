package vo;

public class P_infoVO {
private int p_info_code,p_info_price,p_info_hit;
	//        상품 코드             가격                   조회수
private String p_info_name,p_info_img1,p_info_img2,p_info_img3,p_info_detail,p_info_mdate;
//              상품 이름               대표이미지              추가이미지1     추가 이미지2     상세 설명                      상품 수정날짜
private String p_info_regdate,p_info_lType, p_info_mType, p_info_sType, search;
//                등록일                       상품 대분류           상품 소분류

public String getSearch() {
	return search;
}

public void setSearch(String search) {
	this.search = search;
}

public int getP_info_hit() {
	return p_info_hit;
}

public String getP_info_lType() {
	return p_info_lType;
}

public void setP_info_lType(String p_info_lType) {
	this.p_info_lType = p_info_lType;
}

public String getP_info_mType() {
	return p_info_mType;
}

public void setP_info_mType(String p_info_mType) {
	this.p_info_mType = p_info_mType;
}

public String getP_info_sType() {
	return p_info_sType;
}

public void setP_info_sType(String p_info_sType) {
	this.p_info_sType = p_info_sType;
}

public void setP_info_hit(int p_info_hit) {
	this.p_info_hit = p_info_hit;
}

public String getP_info_mdate() {
	return p_info_mdate;
}

public void setP_info_mdate(String p_info_mdate) {
	this.p_info_mdate = p_info_mdate;
}

public int getP_info_code() {
	return p_info_code;
}

public void setP_info_code(int p_info_code) {
	this.p_info_code = p_info_code;
}

public int getP_info_price() {
	return p_info_price;
}
public void setP_info_price(int p_info_price) {
	this.p_info_price = p_info_price;
}

public String getP_info_name() {
	return p_info_name;
}
public void setP_info_name(String p_info_name) {
	this.p_info_name = p_info_name;
}
public String getP_info_img1() {
	return p_info_img1;
}
public void setP_info_img1(String p_info_img1) {
	this.p_info_img1 = p_info_img1;
}
public String getP_info_img2() {
	return p_info_img2;
}
public void setP_info_img2(String p_info_img2) {
	this.p_info_img2 = p_info_img2;
}
public String getP_info_img3() {
	return p_info_img3;
}
public void setP_info_img3(String p_info_img3) {
	this.p_info_img3 = p_info_img3;
}
public String getP_info_detail() {
	return p_info_detail;
}
public void setP_info_detail(String p_info_detail) {
	this.p_info_detail = p_info_detail;
}
public String getP_info_regdate() {
	return p_info_regdate;
}
public void setP_info_regdate(String p_info_regdate) {
	this.p_info_regdate = p_info_regdate;
}

}
