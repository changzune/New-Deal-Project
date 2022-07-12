package kr.happyjob.study.accounting.model;

public class AcctitleModel {
	
	//콤보 계정대분류(계정대분류명,계정대분류코드)
	private String bigSelect;
	//콤보 계정 세부목록(계정세부명,계정세분류코드)
	private String accSmall;
	//구분
	private String payment;
	//상세내용
	private String note;
	//사용여부
	private String useYn;
	//비고
	private String etc;
	//상세코드 명
	private String detail_name;
	
	private String account_cd;
	private String detail_account_cd;
	private String detail_account_nm;
	
	
	
	//콤보박스 관련
	private String cd;	
	private String name;
	
	
	
	public String getBigSelect() {
		return bigSelect;
	}
	public void setBigSelect(String bigSelect) {
		this.bigSelect = bigSelect;
	}
	public String getAccSmall() {
		return accSmall;
	}
	public void setAccSmall(String accSmall) {
		this.accSmall = accSmall;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	public String getAccount_cd() {
		return account_cd;
	}
	public void setAccount_cd(String account_cd) {
		this.account_cd = account_cd;
	}
	public String getDetail_account_cd() {
		return detail_account_cd;
	}
	public void setDetail_account_cd(String detail_account_cd) {
		this.detail_account_cd = detail_account_cd;
	}
	public String getDetail_account_nm() {
		return detail_account_nm;
	}
	public void setDetail_account_nm(String detail_account_nm) {
		this.detail_account_nm = detail_account_nm;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}