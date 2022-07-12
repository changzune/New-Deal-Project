package kr.happyjob.study.business.model;

public class OeManagementModel {

	/** tb_receive_info 테이블 */
	private String receive_num;			// 수주 번호
	private String estimate_no;			// 견적서 번호
	private int supply_val;				// 수주 전체 가액
	private int supply_tax;				// 수주 전체 부가세
	private int supply_cost;			// 수주 전체 단가가
	private String receive_date;		// 수주일자
	private String reg_date;			// 작성일

	/** estimate_info 테이블 */
	private String estimate_date;		// 작성일

	/** tb_erp_client 테이블 */
	private String client_cd; 			// 거래처코드
	private String client_nm; 			// 거래처명
	private String cop_no1;				// 사업자등록번호1
	private String cop_no2;				// 사업자등록번호2
	private String cop_no3;				// 사업자등록번호3
	private String emp_nm;				// 담당자
	private String emp_hp;				// 담당자 휴대전화
	private String addr;				// 주소
	private String addr_detail;			// 상세주소
	
	
	private String product_nm; 			// 제품명

	/** receive_prod 테이블 */
	private int estimate_cnt; 			// 수량
	private String product_cd; 			// 제품코드
	private String remarks;				// 비고
	private String limit_date;			// 납기일자
	
	private String name;				// 로그인 이름


	/** tb_scm_order 테이블 */
	private String order_date;			// 주문일자
	private String want_receive_date;	// 배송희망일자
	private int order_cnt;				// 주문갯수
	private String warehouse_cd;
	private String deposit_yn;			// 입금여부
	private int STTcd ;
	private String loginID;				// 로그읜 아이디
	
	private String slip_no;				// 전표번호

	public String getReceive_num() {
		return receive_num;
	}

	public void setReceive_num(String receive_num) {
		this.receive_num = receive_num;
	}

	public String getEstimate_no() {
		return estimate_no;
	}

	public void setEstimate_no(String estimate_no) {
		this.estimate_no = estimate_no;
	}

	public int getSupply_val() {
		return supply_val;
	}

	public void setSupply_val(int supply_val) {
		this.supply_val = supply_val;
	}

	public int getSupply_tax() {
		return supply_tax;
	}

	public void setSupply_tax(int supply_tax) {
		this.supply_tax = supply_tax;
	}

	public int getSupply_cost() {
		return supply_cost;
	}

	public void setSupply_cost(int supply_cost) {
		this.supply_cost = supply_cost;
	}

	public String getReceive_date() {
		return receive_date;
	}

	public void setReceive_date(String receive_date) {
		this.receive_date = receive_date;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getEstimate_date() {
		return estimate_date;
	}

	public void setEstimate_date(String estimate_date) {
		this.estimate_date = estimate_date;
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

	public String getCop_no1() {
		return cop_no1;
	}

	public void setCop_no1(String cop_no1) {
		this.cop_no1 = cop_no1;
	}

	public String getCop_no2() {
		return cop_no2;
	}

	public void setCop_no2(String cop_no2) {
		this.cop_no2 = cop_no2;
	}

	public String getCop_no3() {
		return cop_no3;
	}

	public void setCop_no3(String cop_no3) {
		this.cop_no3 = cop_no3;
	}

	public String getEmp_nm() {
		return emp_nm;
	}

	public void setEmp_nm(String emp_nm) {
		this.emp_nm = emp_nm;
	}

	public String getEmp_hp() {
		return emp_hp;
	}

	public void setEmp_hp(String emp_hp) {
		this.emp_hp = emp_hp;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddr_detail() {
		return addr_detail;
	}

	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}

	public String getProduct_nm() {
		return product_nm;
	}

	public void setProduct_nm(String product_nm) {
		this.product_nm = product_nm;
	}

	public int getEstimate_cnt() {
		return estimate_cnt;
	}

	public void setEstimate_cnt(int estimate_cnt) {
		this.estimate_cnt = estimate_cnt;
	}

	public String getProduct_cd() {
		return product_cd;
	}

	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getLimit_date() {
		return limit_date;
	}

	public void setLimit_date(String limit_date) {
		this.limit_date = limit_date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getWant_receive_date() {
		return want_receive_date;
	}

	public void setWant_receive_date(String want_receive_date) {
		this.want_receive_date = want_receive_date;
	}

	public int getOrder_cnt() {
		return order_cnt;
	}

	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}

	public String getWarehouse_cd() {
		return warehouse_cd;
	}

	public void setWarehouse_cd(String warehouse_cd) {
		this.warehouse_cd = warehouse_cd;
	}

	public String getDeposit_yn() {
		return deposit_yn;
	}

	public void setDeposit_yn(String deposit_yn) {
		this.deposit_yn = deposit_yn;
	}

	public int getSTTcd() {
		return STTcd;
	}

	public void setSTTcd(int sTTcd) {
		STTcd = sTTcd;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getSlip_no() {
		return slip_no;
	}

	public void setSlip_no(String slip_no) {
		this.slip_no = slip_no;
	}

	@Override
	public String toString() {
		return "OeManagementModel [receive_num=" + receive_num + ", estimate_no=" + estimate_no + ", supply_val="
				+ supply_val + ", supply_tax=" + supply_tax + ", supply_cost=" + supply_cost + ", receive_date="
				+ receive_date + ", reg_date=" + reg_date + ", estimate_date=" + estimate_date + ", client_cd="
				+ client_cd + ", client_nm=" + client_nm + ", cop_no1=" + cop_no1 + ", cop_no2=" + cop_no2
				+ ", cop_no3=" + cop_no3 + ", emp_nm=" + emp_nm + ", emp_hp=" + emp_hp + ", addr=" + addr
				+ ", addr_detail=" + addr_detail + ", product_nm=" + product_nm + ", estimate_cnt=" + estimate_cnt
				+ ", product_cd=" + product_cd + ", remarks=" + remarks + ", limit_date=" + limit_date + ", name="
				+ name + ", order_date=" + order_date + ", want_receive_date=" + want_receive_date + ", order_cnt="
				+ order_cnt + ", warehouse_cd=" + warehouse_cd + ", deposit_yn=" + deposit_yn + ", STTcd=" + STTcd
				+ ", loginID=" + loginID + ", slip_no=" + slip_no + "]";
	}
}
