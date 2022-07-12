package kr.happyjob.study.business.vo;

public class EstimateProdVo {
    private String estimateNo;      // 견적서번호
    private String clientCd;        // 거래처코드
    private String productCd;       // 제품코드
    private int estimateCnt;        // 갯수
    private int unitCost;           // 단가
    private int price;              // 공급가액
    private int tax;                // 부가세
	private int sumAmount;			// 합계
	private String ourDeadline;		// 납기일자
	private String receiveNo;		// 수주번호
    
	public String getEstimateNo() {
		return estimateNo;
	}
	public String getClientCd() {
		return clientCd;
	}
	public String getProductCd() {
		return productCd;
	}
	public int getEstimateCnt() {
		return estimateCnt;
	}
	public int getUnitCost() {
		return unitCost;
	}
	public int getPrice() {
		return price;
	}
	public int getTax() {
		return tax;
	}
	public String getOurDeadline() {
		return ourDeadline;
	}
	public int getSumAmount() {
		return sumAmount;
	}
	public String getReceiveNo() {
		return receiveNo;
	}
}
