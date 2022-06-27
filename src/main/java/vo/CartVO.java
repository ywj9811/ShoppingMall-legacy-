package vo;

public class CartVO {
	private int cart_code,p_info_dcode,user_code,cart_cnt;
	        //  장바구니 코드      상품 코드                 고객 고유번호     구매수량

	public int getCart_code() {
		return cart_code;
	}

	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}

	public int getP_info_dcode() {
		return p_info_dcode;
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

	public int getCart_cnt() {
		return cart_cnt;
	}

	public void setCart_cnt(int cart_cnt) {
		this.cart_cnt = cart_cnt;
	}
	

}
