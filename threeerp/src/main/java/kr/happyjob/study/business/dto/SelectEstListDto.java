package kr.happyjob.study.business.dto;

public class SelectEstListDto {
    private String estimateNo;     // 견적서번호
    private String clientCd;       // 거래처코드
    private String estimateDate;   // 견적서생성일
    private int supplyVal;         // 총 공급가액
    private int supplyTax;         // 총 부가세
    private int supplyCost;        // 총 단가
    private String copNo1;         // 사업자등록번호1
    private String copNo2;         // 사업자등록번호2
    private String copNo3;         // 사업자등록번호3
    private String clientNm;       // 거래처명
    private String empNm;          // 거래처담당자
    private String empHp;          // 거래처담당자 휴대전화
    private String addr;           // 주소
    private String addrDetail;     // 상세주소
	private int sumTotal;		   // 총 갯수
	private String remarks;		   // 비고
	private String name;		   // 담당자
	private String tel;			   // 담당자 휴대전화
	private String loginId;		   // 담당자 아이디
    
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
	public String getCopNo1() {
		return copNo1;
	}
	public void setCopNo1(String copNo1) {
		this.copNo1 = copNo1;
	}
	public String getCopNo2() {
		return copNo2;
	}
	public void setCopNo2(String copNo2) {
		this.copNo2 = copNo2;
	}
	public String getCopNo3() {
		return copNo3;
	}
	public void setCopNo3(String copNo3) {
		this.copNo3 = copNo3;
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
	public String getEmpHp() {
		return empHp;
	}
	public void setEmpHp(String empHp) {
		this.empHp = empHp;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public int getSumTotal() {
		return sumTotal;
	}
	public void setSumTotal(int sumTotal) {
		this.sumTotal = sumTotal;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	@Override
	public String toString() {
		return "SelectEstListDto{" +
				"estimateNo='" + estimateNo + '\'' +
				", clientCd='" + clientCd + '\'' +
				", estimateDate='" + estimateDate + '\'' +
				", supplyVal=" + supplyVal +
				", supplyTax=" + supplyTax +
				", supplyCost=" + supplyCost +
				", copNo1='" + copNo1 + '\'' +
				", copNo2='" + copNo2 + '\'' +
				", copNo3='" + copNo3 + '\'' +
				", clientNm='" + clientNm + '\'' +
				", empNm='" + empNm + '\'' +
				", empHp='" + empHp + '\'' +
				", addr='" + addr + '\'' +
				", addrDetail='" + addrDetail + '\'' +
				", sumTotal=" + sumTotal +
				", remarks='" + remarks + '\'' +
				", name='" + name + '\'' +
				", tel='" + tel + '\'' +
				", loginId='" + loginId + '\'' +
				'}';
	}
}
