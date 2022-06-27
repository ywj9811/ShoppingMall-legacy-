package vo;

public class OrderListVO {
	private int orderList_code,p_info_dcode,order_code,payment_code, orderList_cnt, user_code;
	//       오더상세코드             상품상세코드                  오더코드             결제코드                    상품구매수량			고객코드
	//오더상세코드, 고객코드, 오더코드, 결제코드, 상품 상세코드, 상품구매수량 
	public int getUser_code() {
		return user_code;
	}

	public void setUser_code(int user_code) {
		this.user_code = user_code;
	}
	public int getOrderList_code() {
		return orderList_code;
	}

	public void setOrderList_code(int orderList_code) {
		this.orderList_code = orderList_code;
	}

	public int getP_info_dcode() {
		return p_info_dcode;
	}

	public void setP_info_dcode(int p_info_dcode) {
		this.p_info_dcode = p_info_dcode;
	}

	public int getOrder_code() {
		return order_code;
	}

	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}

	public int getPayment_code() {
		return payment_code;
	}

	public void setPayment_code(int payment_code) {
		this.payment_code = payment_code;
	}

	public int getOrderList_cnt() {
		return orderList_cnt;
	}

	public void setOrderList_cnt(int orderList_cnt) {
		this.orderList_cnt = orderList_cnt;
	}
	

}
