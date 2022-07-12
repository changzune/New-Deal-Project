package kr.happyjob.study.business.model;

public class EmpSalePlanModel {

	//
	private int sales_pro_seq;
	
	//거래처 코드
	private String client_cd;
	
	private String client_nm;
	
	//목표수량
	private int goal_amt;
	
	//제품 대분류코드
	private String l_ct_cd;
	
	//제품 중분류 코드
	private String m_ct_cd;
	
	//로그인 아이디 우리사용자.
	private String loginID;
	
	private String memo;
	
	private String product_cd;
	
	//계획등록일
	private String sales_reg_date;
	
	//제품명
	private String product_nm;
	
	private String estimate_cnt;

	public int getSales_pro_seq() {
		return sales_pro_seq;
	}

	public void setSales_pro_seq(int sales_pro_seq) {
		this.sales_pro_seq = sales_pro_seq;
	}

	public String getClient_cd() {
		return client_cd;
	}

	public void setClient_cd(String client_cd) {
		this.client_cd = client_cd;
	}

	public String getClient_nm() {
		return client_nm;
	}

	public void setClient_nm(String client_nm) {
		this.client_nm = client_nm;
	}

	public int getGoal_amt() {
		return goal_amt;
	}

	public void setGoal_amt(int goal_amt) {
		this.goal_amt = goal_amt;
	}

	public String getL_ct_cd() {
		return l_ct_cd;
	}

	public void setL_ct_cd(String l_ct_cd) {
		this.l_ct_cd = l_ct_cd;
	}

	public String getM_ct_cd() {
		return m_ct_cd;
	}

	public void setM_ct_cd(String m_ct_cd) {
		this.m_ct_cd = m_ct_cd;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getProduct_cd() {
		return product_cd;
	}

	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}

	public String getSales_reg_date() {
		return sales_reg_date;
	}

	public void setSales_reg_date(String sales_reg_date) {
		this.sales_reg_date = sales_reg_date;
	}

	public String getProduct_nm() {
		return product_nm;
	}

	public void setProduct_nm(String product_nm) {
		this.product_nm = product_nm;
	}

	public String getEstimate_cnt() {
		return estimate_cnt;
	}

	public void setEstimate_cnt(String estimate_cnt) {
		this.estimate_cnt = estimate_cnt;
	}

	@Override
	public String toString() {
		return "EmpSalePlanModel [sales_pro_seq=" + sales_pro_seq + ", client_cd=" + client_cd + ", client_nm="
				+ client_nm + ", goal_amt=" + goal_amt + ", l_ct_cd=" + l_ct_cd + ", m_ct_cd=" + m_ct_cd + ", loginID="
				+ loginID + ", memo=" + memo + ", product_cd=" + product_cd + ", sales_reg_date=" + sales_reg_date
				+ ", product_nm=" + product_nm + ", estimate_cnt=" + estimate_cnt + "]";
	}
	
	

}
