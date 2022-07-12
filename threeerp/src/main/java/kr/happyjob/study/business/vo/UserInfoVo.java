package kr.happyjob.study.business.vo;

public class UserInfoVo {
    private String loginId;         // 로그인 ID
    private String userType;        // 사용자구분
    private String name;            // 이름
    private String password;        // 비밀번호
    private String tel;             // 연락처
    private String mail;            // 이메일
    private String zipCode;         // 우편번호
    private String addr;            // 주소
    private String addrDetail;      // 상세주소
    private String leaveYN;         // 탈퇴여부
    private String leaveDate;       // 탈퇴일자
    private String sex;             // 성
    private String approvalCd;      // 승인여부
    private String bank;            // 은행명
    private String account;         // 계좌번호
    private String joinDate;        // 가입일자
    
	public String getLoginId() {
		return loginId;
	}
	public String getUserType() {
		return userType;
	}
	public String getName() {
		return name;
	}
	public String getPassword() {
		return password;
	}
	public String getTel() {
		return tel;
	}
	public String getMail() {
		return mail;
	}
	public String getZipCode() {
		return zipCode;
	}
	public String getAddr() {
		return addr;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public String getLeaveYN() {
		return leaveYN;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public String getSex() {
		return sex;
	}
	public String getApprovalCd() {
		return approvalCd;
	}
	public String getBank() {
		return bank;
	}
	public String getAccount() {
		return account;
	}
	public String getJoinDate() {
		return joinDate;
	}
	
	@Override
	public String toString() {
		return "UserInfo [loginId=" + loginId + ", userType=" + userType + ", name=" + name + ", password=" + password
				+ ", tel=" + tel + ", mail=" + mail + ", zipCode=" + zipCode + ", addr=" + addr + ", addrDetail="
				+ addrDetail + ", leaveYN=" + leaveYN + ", leaveDate=" + leaveDate + ", sex=" + sex + ", approvalCd="
				+ approvalCd + ", bank=" + bank + ", account=" + account + ", joinDate=" + joinDate + "]";
	}
}
