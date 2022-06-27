package vo;

public class PaymentVO {
	private int payment_code,order_code,payment_pay;
	//   			결제코드                  오더코드              결제금액                     결제수단
	private String payment_regdate, payment_type;
	//                결제일

	public int getPayment_code() {
		return payment_code;
	}
	public void setPayment_code(int payment_code) {
		this.payment_code = payment_code;
	}
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	public int getPayment_pay() {
		return payment_pay;
	}
	public void setPayment_pay(int payment_pay) {
		this.payment_pay = payment_pay;
	}
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public String getPayment_regdate() {
		return payment_regdate;
	}
	public void setPayment_regdate(String payment_regdate) {
		this.payment_regdate = payment_regdate;
	}


}
