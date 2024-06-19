package kr.co.symphony.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.co.symphony.lessonreg.RegDTO;
import kr.co.symphony.notice.NoticeDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.MyAuthenticator;

public class MemberDAO { // Data Access Object. DB접근 객체
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public MemberDAO() {
		dbopen=new DBOpen();
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 비지니스 로직 구현
		public String loginProc(MemberDTO dto) {
			String mlevel=null;

			try {
				con=dbopen.getConnection();
				
				sql = new StringBuilder();
				sql.append(" SELECT ulevel FROM user_tb ");
				sql.append(" WHERE id=? AND passwd=? AND ulevel in ('S', 'T', 'M') ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, dto.getId());
				pstmt.setString(2, dto.getPasswd());
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					mlevel=rs.getString("ulevel");

				}
				
				
			}catch (Exception e) {
				System.out.println("로그인 실패 : " + e);
			} finally {
				DBClose.close(con, pstmt, rs);
			}
			return mlevel;
		}
		
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			

	
	
	// 아이디 중복확인
	public int duplecateID(String id) { 
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT COUNT(id) as cnt ");
			sql.append(" FROM user_tb ");
			sql.append(" WHERE id=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			
			
		}catch (Exception e) {
			System.out.println("아이디 중복 확인 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return cnt;
	}
	//아이디중복확인 end
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	public int create(MemberDTO dto) {
		System.out.println("signin.do >>>>>> createForm >>>>>> create");
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append("INSERT INTO user_tb(id, passwd, uname, gender, email, tel, zipcode, address1, address2, udate, ulevel) ");
	        sql.append("VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?) ");
	        
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getUname());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getTel());
			pstmt.setString(7, dto.getZipcode());
			pstmt.setString(8, dto.getAddress1());
			pstmt.setString(9, dto.getAddress2());
			pstmt.setString(10, dto.getUlevel());
			
			cnt=pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			System.out.println("회원가입 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt);
		}
		
		return cnt;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//이메일 중복확인
	public int duplecateEmail(String email) { //1
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT COUNT(email) as cnt ");
			sql.append(" FROM user_tb ");
			sql.append(" WHERE email=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			
			
		}catch (Exception e) {
			System.out.println("이메일 중복 확인 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return cnt;
	}
	// 이메일 중복확인 끝
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	public boolean findID(MemberDTO dto) {
		boolean flag=false;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			
			// 이름과 이메일이 일치하는 id 가져오지
			sql.append(" SELECT id ");
			sql.append(" FROM user_tb ");
			sql.append(" WHERE uname=? AND email=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getUname());
			pstmt.setString(2, dto.getEmail());
			rs=pstmt.executeQuery();
			if(rs.next()) { // 이름과 이메일 일치한다면
				String id=rs.getString("id"); //1) 아이디
				
				// [임시비밀번호 발급] - 대문자, 소문자, 숫자를 이용해서 랜덤하게 10글자를 만들기
				String[] ch= {
						"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                        "0","1","2","3","4","5","6","7","8","9"
				};
				
				// ch배열에서 랜덤하게 10글자 발생
				StringBuilder imsiPW=new StringBuilder(); // 2) 임시 비밀번호
				for(int i=0; i<10; i++) {
					int num=(int)(Math.random()*ch.length); // ch[0]~ch[61]까지 존재
					imsiPW.append(ch[num]);
				}
				
				// 임시비밀번호로 업데이트 하기
				sql=new StringBuilder();
				sql.append(" UPDATE user_tb ");
				sql.append(" SET passwd=? ");
				sql.append(" WHERE uname=? AND email=? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, imsiPW.toString());
				pstmt.setString(2, dto.getUname());
				pstmt.setString(3, dto.getEmail());
				
				int cnt=pstmt.executeUpdate();
				if(cnt==1) { // 임시 비밀번호로 업데이트 되었다면, 아이디와 임시비밀번호를 이메일로 전송하기
					String content="임시 비밀번호로 로그인 후, 회원 정보 수정에서 비밀번호를 변경하세요";
					content += "<hr>";
					content += "<table border='1'>";
					content += "<tr>";
					content += "<th>아이디</th>";
					content += "<td>" + id + "</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<th>임시 비밀번호</th>";
					content += "<td>" + imsiPW + "</td>";
					content += "</tr>";
					content += "</table>";
					
					String mailServer="mw-002.cafe24.com"; // cafe24 메일서버
					Properties props=new Properties();
					props.put("mail.smtp.host", mailServer);
					props.put("mail.smtp.auth", true);
					Authenticator myAuth=new MyAuthenticator(); //다형성
					Session sess=Session.getInstance(props, myAuth);
					
					InternetAddress[] address={ new InternetAddress(dto.getEmail()) };
					Message msg=new MimeMessage(sess);
					msg.setRecipients(Message.RecipientType.TO, address);
					msg.setFrom(new InternetAddress("younghy96@daum.net"));
					msg.setSubject("Village Symphony 아이디/비밀번호 입니다");
					msg.setContent(content, "text/html; charset=UTF-8");
					msg.setSentDate(new Date());
					Transport.send(msg);
					
					flag=true; // 최종적으로 성공

				}else {
					flag=false;
				}
				
			}
			
		}catch (Exception e) {
			System.out.println("아이디/비밀번호 찾기 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return flag;
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public MemberDTO read(MemberDTO dto) {
		
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" SELECT passwd, uname, tel, email, zipcode, address1, address2 ");
			sql.append(" FROM user_tb ");
			sql.append(" WHERE id=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			
			// pstmt.executeUpdate() -> insert, update, delete문 실행할 때
			rs=pstmt.executeQuery(); // -> select문 실행할 때
			if(rs.next()) {// 행이 존재 하는가
				dto=new MemberDTO();
				dto.setUname(rs.getString("uname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
			}
			
			
			
		}catch (Exception e) {
			System.out.println("회원 정보 가져오기 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	public int modifyProc(MemberDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" UPDATE user_tb ");
			sql.append(" SET passwd=?, uname=?, tel=?, email=?, zipcode=?, address1=?, address2=? ");
			sql.append(" WHERE id=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getUname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getZipcode());
			pstmt.setString(6, dto.getAddress1());
			pstmt.setString(7, dto.getAddress2());
			//pstmt.setString(8, dto.getUlevel());
			pstmt.setString(8, dto.getId());
			
			cnt=pstmt.executeUpdate(); // -> insert, update, delete문 실행할 때
			
			
		}catch (Exception e) {
			System.out.println("행 가져오기 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	
}



