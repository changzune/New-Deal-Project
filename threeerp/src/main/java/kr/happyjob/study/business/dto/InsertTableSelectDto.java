package kr.happyjob.study.business.dto;

public class InsertTableSelectDto {
	private String receiveNo;		// 수주번호
	private String estimateNo;      // 견적서번호
	private String clientCd;        // 거래처코드
	private String estimateDate;    // 작성일
	private String receiveDate;		// 수주일
	private String receiveRemarks;	// 비고
	private String clientNm;		// 거래처명
	private String empNm;			// 거래처담당자
	private String tel;				// 거래처담당자 휴대전화
	
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
	public String getEstimateDate() {
		return estimateDate;
	}
	public void setEstimateDate(String estimateDate) {
		this.estimateDate = estimateDate;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getReceiveRemarks() {
		return receiveRemarks;
	}
	public String getReceiveNo() {
		return receiveNo;
	}
	public void setReceiveRemarks(String receiveRemarks) {
		this.receiveRemarks = receiveRemarks;
	}
	public void setReceiveNo(String receiveNo) {
		this.receiveNo = receiveNo;
	}

	@Override
	public String toString() {
		return "InsertTableSelectDto{" +
				"receiveNo='" + receiveNo + '\'' +
				", estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", estimateDate='" + estimateDate + '\'' +
				", receiveDate='" + receiveDate + '\'' +
				", receiveRemarks='" + receiveRemarks + '\'' +
				", clientNm='" + clientNm + '\'' +
				", empNm='" + empNm + '\'' +
				", tel='" + tel + '\'' +
				'}';
	}
}
