package vo;

public class Sale_Status_ViewVO {
				//    상품코드              판매량            수익금액
	private int p_info_code,view_cell,profit;
				//  상품 이름             대분류                         중분류                   소분류			판매금액 회계형
	private String p_info_name,p_info_lType,p_info_mType,P_info_sType, view_profit;
	public String getView_profit() {
		return view_profit;
	}
	
	public void setView_profit(String view_profit) {
		this.view_profit = view_profit;
	}
	public int getP_info_code() {
		return p_info_code;
	}
	public String getP_info_sType() {
		return P_info_sType;
	}
	public void setP_info_sType(String p_info_sType) {
		P_info_sType = p_info_sType;
	}
	public void setP_info_code(int p_info_code) {
		this.p_info_code = p_info_code;
	}
	public int getView_cell() {
		return view_cell;
	}
	public void setView_cell(int view_cell) {
		this.view_cell = view_cell;
	}
	public int getProfit() {
		return profit;
	}
	public void setProfit(int profit) {
		this.profit = profit;
	}
	public String getP_info_name() {
		return p_info_name;
	}
	public void setP_info_name(String p_info_name) {
		this.p_info_name = p_info_name;
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
	
	
}
