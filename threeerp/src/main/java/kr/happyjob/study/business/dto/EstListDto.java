package kr.happyjob.study.business.dto;

public class EstListDto {
    private String estimateNo;		// 견적서번호
    private String estimateDate;	// 생성일
    private int supplyVal;			// 총 공급가액
    private int supplyTax;			// 총 부가세
    private int supplyCost;			// 총 단가
	private int supplyAmount;		// 총 합계
    private String clientCd;		// 거래처코드
    private String clientNm;		// 거래처명
    private String productCd;		// 제품코드
    private String productNm;		// 제품명
	private String name;			// 이름
	private String mail;			// 이메일
	private int sumTotal;			// 총 갯수
	private String loginId;			// 아이디
	private String remarks;			// 비고
    
	public String getEstimateNo() {
		return estimateNo;
	}
	public void setEstimateNo(String estimateNo) {
		this.estimateNo = estimateNo;
	}
	public String getEstimateDate() {
		return estimateDate;
	}
	public void setEstimateDate(String estimateDate) {
		this.estimateDate = estimateDate;
	}
	public int getSupplyVal() {
		return supplyVal;
	}
	public void setSupplyVal(int supplyVal) {
		this.supplyVal = supplyVal;
	}
	public int getSupplyTax() {
		return supplyTax;
	}
	public void setSupplyTax(int supplyTax) {
		this.supplyTax = supplyTax;
	}
	public int getSupplyCost() {
		return supplyCost;
	}
	public void setSupplyCost(int supplyCost) {
		this.supplyCost = supplyCost;
	}
	public String getClientCd() {
		return clientCd;
	}
	public void setClientCd(String clientCd) {
		this.clientCd = clientCd;
	}
	public String getClientNm() {
		return clientNm;
	}
	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}
	public String getProductCd() {
		return productCd;
	}
	public void setProductCd(String productCd) {
		this.productCd = productCd;
	}
	public String getProductNm() {
		return productNm;
	}
	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public int getSumTotal() {
		return sumTotal;
	}
	public void setSumTotal(int sumTotal) {
		this.sumTotal = sumTotal;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getSupplyAmount() {
		return supplyAmount;
	}
	public void setSupplyAmount(int supplyAmount) {
		this.supplyAmount = supplyAmount;
	}

	@Override
	public String toString() {
		return "EstListDto{" +
				"estimateNo='" + estimateNo + '\'' +
				", estimateDate='" + estimateDate + '\'' +
				", supplyVal=" + supplyVal +
				", supplyTax=" + supplyTax +
				", supplyCost=" + supplyCost +
				", supplyAmount=" + supplyAmount +
				", clientCd='" + clientCd + '\'' +
				", clientNm='" + clientNm + '\'' +
				", productCd='" + productCd + '\'' +
				", productNm='" + productNm + '\'' +
				", name='" + name + '\'' +
				", mail='" + mail + '\'' +
				", sumTotal=" + sumTotal +
				", loginId='" + loginId + '\'' +
				", remarks='" + remarks + '\'' +
				'}';
	}
}
