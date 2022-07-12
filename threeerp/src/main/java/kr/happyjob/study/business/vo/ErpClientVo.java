package kr.happyjob.study.business.vo;

public class ErpClientVo {
    private String clientCd;		// 거래처코드
    private String clientNm;		// 거래처명
    private String tel;				// 회사전화
    private String empNm;			// 담당자
    private String empHp;			// 담당자 휴대전화
    private String zipCode;			// 우편번호
    private String bank;			// 은행
    private String account;			// 계좌번호
    private String addr;			// 주소
    private String addrDetail;		// 상세주소
    private String jobType;			// 업종
    private String copNo1;			// 사업자 등록번호1
    private String copNo2;			// 사업자 등록번호2
    private String copNo3;			// 사업자 등록번호3
    private String memo;			// 비고
    private String email;			// 회사 이메일
    private String regDate;			// 등록날짜
    
    public String getClientCd() {
		return clientCd;
	}

	public String getClientNm() {
		return clientNm;
	}

	public String getTel() {
		return tel;
	}

	public String getEmpNm() {
		return empNm;
	}

	public String getEmpHp() {
		return empHp;
	}

	public String getZipCode() {
		return zipCode;
	}

	public String getBank() {
		return bank;
	}

	public String getAccount() {
		return account;
	}

	public String getAddr() {
		return addr;
	}

	public String getAddrDetail() {
		return addrDetail;
	}

	public String getJobType() {
		return jobType;
	}

	public String getCopNo1() {
		return copNo1;
	}

	public String getCopNo2() {
		return copNo2;
	}

	public String getCopNo3() {
		return copNo3;
	}

	public String getMemo() {
		return memo;
	}

	public String getEmail() {
		return email;
	}

	public String getRegDate() {
		return regDate;
	}

	@Override
    public String toString() {
        return "ErpClientVo{" +
                "clientCd='" + clientCd + '\'' +
                ", clientNm='" + clientNm + '\'' +
                ", tel='" + tel + '\'' +
                ", empNm='" + empNm + '\'' +
                ", empHp='" + empHp + '\'' +
                ", zipCode='" + zipCode + '\'' +
                ", bank='" + bank + '\'' +
                ", account='" + account + '\'' +
                ", addr='" + addr + '\'' +
                ", addrDetail='" + addrDetail + '\'' +
                ", jobType='" + jobType + '\'' +
                ", copNo1='" + copNo1 + '\'' +
                ", copNo2='" + copNo2 + '\'' +
                ", copNo3='" + copNo3 + '\'' +
                ", memo='" + memo + '\'' +
                ", email='" + email + '\'' +
                ", regDate='" + regDate + '\'' +
                '}';
    }
}
