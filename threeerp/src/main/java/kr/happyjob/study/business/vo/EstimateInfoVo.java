package kr.happyjob.study.business.vo;

public class EstimateInfoVo {
    private String estimateNo;      // 견적서번호
    private String clientCd;        // 거래처코드
    private String estimateDate;    // 작성일
    private int supplyVal;          // 전체 공급가액
    private int supplyTax;          // 부가세
    private int supplyCost;         // 단가
	private int supplyAmount;		// 총합계
	private int sumTotal;			// 총 갯수
	private String remarks;			// 비고
	private String receiveNo;		// 수주번호
	private String receiveRemarks;	// 수주_비고
	private String receiveDate;		// 수주일자
	private String receiveYN;		// 수주서 작성여부
	private String depositYN;		// 입금완료여부
	private String loginId;			// 로그인 아이디
    
	public String getEstimateNo() {
		return estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public String getEstimateDate() {
		return estimateDate;
	}
	public int getSupplyVal() {
		return supplyVal;
	}
	public int getSupplyTax() {
		return supplyTax;
	}
	public int getSupplyCost() {
		return supplyCost;
	}
	public int getSumTotal() {
		return sumTotal;
	}
	public String getRemarks() {
		return remarks;
	}
	public int getSupplyAmount() {
		return supplyAmount;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public String getDepositYN() {
		return depositYN;
	}
	public String getReceiveNo() {
		return receiveNo;
	}
	public String getReceiveRemarks() {
		return receiveRemarks;
	}
	public String getReceiveYN() {
		return receiveYN;
	}
	public String getLoginId() {
		return loginId;
	}
}
