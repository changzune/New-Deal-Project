package kr.happyjob.study.business.dto;

public class ReceiveOrderDetailDto {
	private String receiveNo;		// 수주번호
	private String estimateNo;      // 견적서번호
	private String clientCd;        // 거래처코드
	private String productCd;		// 제품코드
	private int sumAmount;			// 주문합계
	private int estimateCnt;		// 주문갯수
	private int unitCost;			// 제품단가
	private String ourDeadline;		// 납기일자
	private String orderCd;			// 주문코드
	private String loginId;			// 관리 ID
	
	public String getReceiveNo() {
		return receiveNo;
	}
	public void setReceiveNo(String receiveNo) {
		this.receiveNo = receiveNo;
	}
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
	public String getProductCd() {
		return productCd;
	}
	public void setProductCd(String productCd) {
		this.productCd = productCd;
	}
	public int getSumAmount() {
		return sumAmount;
	}
	public void setSumAmount(int sumAmount) {
		this.sumAmount = sumAmount;
	}
	public int getEstimateCnt() {
		return estimateCnt;
	}
	public void setEstimateCnt(int estimateCnt) {
		this.estimateCnt = estimateCnt;
	}
	public String getOurDeadline() {
		return ourDeadline;
	}
	public void setOurDeadline(String ourDeadline) {
		this.ourDeadline = ourDeadline;
	}
	public String getOrderCd() {
		return orderCd;
	}
	public void setOrderCd(String orderCd) {
		this.orderCd = orderCd;
	}
	public int getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(int unitCost) {
		this.unitCost = unitCost;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	@Override
	public String toString() {
		return "ReceiveOrderDetailDto{" +
				"receiveNo='" + receiveNo + '\'' +
				", estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", productCd='" + productCd + '\'' +
				", sumAmount=" + sumAmount +
				", estimateCnt=" + estimateCnt +
				", unitCost=" + unitCost +
				", ourDeadline='" + ourDeadline + '\'' +
				", orderCd='" + orderCd + '\'' +
				", loginId='" + loginId + '\'' +
				'}';
	}
}
