package kr.happyjob.study.business.dto;

public class SelectClientListDto {
    private String estimateNo;     // 견적서번호
    private String clientCd;       // 거래처코드
    private String clientNm;       // 거래처명
    
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
	public String getClientNm() {
		return clientNm;
	}
	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}

	@Override
	public String toString() {
		return "SelectClientListDto{" +
				"estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", clientNm='" + clientNm + '\'' +
				'}';
	}
}
