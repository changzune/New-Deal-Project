package kr.happyjob.study.business.dto;


public class ReceiveListDetailDto {
	private String receiveNo;		// 수주번호
	private String estimateNo;      // 견적서번호
	private String clientCd;        // 거래처코드
	private int price;              // 개별 공급가액
	private int tax;                // 개별 부가세
	private int unitCost;           // 개별 단가
	private int sumAmount;          // 개별 총합계
	private String productCd;       // 제품코드
	private int estimateCnt;  		// 갯수
	private String receiveDate;    	// 견적서 생성일
	private String clientNm;        // 거래처명
	private String productNm;       // 제품명
	private String ourDeadline;     // 납기일자

	public String getEstimateNo() {
		return estimateNo;
	}
	public void setEstimateNo(String estimateNo) {
		this.estimateNo = estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public void setClientCd(String clientCd) {
		this.clientCd = clientCd;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public int getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(int unitCost) {
		this.unitCost = unitCost;
	}
	public int getSumAmount() {
		return sumAmount;
	}
	public void setSumAmount(int sumAmount) {
		this.sumAmount = sumAmount;
	}
	public String getProductCd() {
		return productCd;
	}
	public void setProductCd(String productCd) {
		this.productCd = productCd;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getClientNm() {
		return clientNm;
	}
	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}
	public String getProductNm() {
		return productNm;
	}
	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}
	public String getOurDeadline() {
		return ourDeadline;
	}
	public void setOurDeadline(String ourDeadline) {
		this.ourDeadline = ourDeadline;
	}
	public String getReceiveNo() {
		return receiveNo;
	}
	public void setReceiveNo(String receiveNo) {
		this.receiveNo = receiveNo;
	}
	public int getEstimateCnt() {
		return estimateCnt;
	}
	public void setEstimateCnt(int estimateCnt) {
		this.estimateCnt = estimateCnt;
	}

	@Override
	public String toString() {
		return "ReceiveListDetailDto{" +
				"receiveNo='" + receiveNo + '\'' +
				", estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", price=" + price +
				", tax=" + tax +
				", unitCost=" + unitCost +
				", sumAmount=" + sumAmount +
				", productCd='" + productCd + '\'' +
				", estimateCnt=" + estimateCnt +
				", receiveDate='" + receiveDate + '\'' +
				", clientNm='" + clientNm + '\'' +
				", productNm='" + productNm + '\'' +
				", ourDeadline='" + ourDeadline + '\'' +
				'}';
	}
}
