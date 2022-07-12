package kr.happyjob.study.business.dto;

public class ReceiveListDto {
	private String name;			// 내 회사 담당자
	private String clientCd;		// 거래처코드
	private String clientNm;		// 거래처명
	private String empNm;			// 거래처 담당자
	private String receiveNo;		// 수주번호
	private String receiveDate;		// 수주일자
	private int sumTotal;			// 총 갯수
	private int supplyAmount;		// 총 합계
	private String loginId;			// 아이디
	private String estimateNo;		// 견적서번호
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getEmpNm() {
		return empNm;
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	public int getSumTotal() {
		return sumTotal;
	}
	public void setSumTotal(int sumTotal) {
		this.sumTotal = sumTotal;
	}
	public int getSupplyAmount() {
		return supplyAmount;
	}
	public void setSupplyAmount(int supplyAmount) {
		this.supplyAmount = supplyAmount;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getEstimateNo() {
		return estimateNo;
	}
	public void setEstimateNo(String estimateNo) {
		this.estimateNo = estimateNo;
	}
	public String getReceiveNo() {
		return receiveNo;
	}
	public void setReceiveNo(String receiveNo) {
		this.receiveNo = receiveNo;
	}

	@Override
	public String toString() {
		return "ReceiveListDto{" +
				"name='" + name + '\'' +
				", clientCd='" + clientCd + '\'' +
				", clientNm='" + clientNm + '\'' +
				", empNm='" + empNm + '\'' +
				", receiveNo='" + receiveNo + '\'' +
				", receiveDate='" + receiveDate + '\'' +
				", sumTotal=" + sumTotal +
				", supplyAmount=" + supplyAmount +
				", loginId='" + loginId + '\'' +
				", estimateNo='" + estimateNo + '\'' +
				'}';
	}
}
