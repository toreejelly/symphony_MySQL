package kr.co.symphony.ans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import kr.co.symphony.lessonreg.RegDTO;
import kr.co.symphony.paging.PageDTO;
import net.utility.DBClose;
import net.utility.DBOpen;

public class AnsDAO {
	
	private DBOpen dbopen = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;
	
	public AnsDAO() {
		dbopen = new DBOpen();
	}//end
	
	
public int ansIns(AnsDTO dto) {
		
		System.out.println("result.do >>>>>> submitAns >>>>>>ansIns");
		
		int cnt=0;
		
		try {
			con = dbopen.getConnection();		
			sql = new StringBuilder();		
			sql.append(" INSERT INTO RESULT_TB(ID, Q01ANS, Q02ANS, Q03ANS, Q04ANS)");
			sql.append(" VALUES(?, ?, ?, ?, ?)");
			
			pstmt = con.prepareStatement(sql.toString()); 
			
			System.out.println(sql.toString());
														
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getQ01ans());
			pstmt.setString(3, dto.getQ02ans());
			pstmt.setString(4, dto.getQ03ans());
			pstmt.setString(5, dto.getQ04ans());

			cnt = pstmt.executeUpdate();	
			
		}catch(Exception e) {
			System.out.println("글쓰기 실패:" + e);
		
		}finally {
			DBClose.close(con, pstmt);
		}//end
		
		return cnt;		
	}//ansIns() end


public ArrayList<RegDTO> resultSel(AnsDTO ans, PageDTO page) {
    ArrayList<RegDTO> list = null;

    System.out.println("resultSel");

    try {
        con = dbopen.getConnection();
        sql = new StringBuilder();

        if (ans.getQ02ans().equals("E")) { // 성별이 상관없음인 경우
            sql.append("SELECT A.*, B.gender ");
            sql.append("FROM lesson_tb A ");
            sql.append("LEFT JOIN user_tb B ON B.ID = A.ID ");
            sql.append("WHERE A.Q01ANS = ? AND B.gender IN ('F', 'M') ");
            sql.append("AND A.Q03ANS = ? AND A.Q04ANS = ? ");
            sql.append("ORDER BY A.DDATE DESC ");
            sql.append("LIMIT ? OFFSET ?");

            pstmt = con.prepareStatement(sql.toString());

            System.out.println(sql.toString());

            pstmt.setString(1, ans.getQ01ans());
            pstmt.setString(2, ans.getQ03ans());
            pstmt.setString(3, ans.getQ04ans());
            pstmt.setInt(4, page.getAmount());
            pstmt.setInt(5, (page.getNowPage() - 1) * page.getAmount());

        } else { // 특정 성별을 검색하는 경우
            sql.append("SELECT A.*, B.gender ");
            sql.append("FROM lesson_tb A ");
            sql.append("LEFT JOIN user_tb B ON B.ID = A.ID ");
            sql.append("WHERE A.Q01ANS = ? AND B.gender = ? ");
            sql.append("AND A.Q03ANS = ? AND A.Q04ANS = ? ");
            sql.append("ORDER BY A.DDATE DESC ");
            sql.append("LIMIT ? OFFSET ?");

            pstmt = con.prepareStatement(sql.toString());

            System.out.println(sql.toString());

            pstmt.setString(1, ans.getQ01ans());
            pstmt.setString(2, ans.getQ02ans());
            pstmt.setString(3, ans.getQ03ans());
            pstmt.setString(4, ans.getQ04ans());
            pstmt.setInt(5, page.getAmount());
            pstmt.setInt(6, (page.getNowPage() - 1) * page.getAmount());
        }

        rs = pstmt.executeQuery();

        if (rs.next()) {
            list = new ArrayList<RegDTO>();

            do {
                RegDTO dto = new RegDTO();

                dto.setC_id(rs.getInt("C_ID"));
                dto.setId(rs.getString("ID"));
                dto.setC_title(rs.getString("C_TITLE"));
                dto.setProf_photo(rs.getString("PROF_PHOTO"));
                dto.setC_content(rs.getString("C_CONTENT"));
                dto.setQ01ans(rs.getString("Q01ANS"));
                dto.setQ03ans(rs.getString("Q03ANS"));
                dto.setQ04ans(rs.getString("Q04ANS"));
                dto.setC_time(rs.getString("C_TIME"));
                dto.setC_date(rs.getString("C_DATE"));
                dto.setPrice(rs.getInt("PRICE"));
                dto.setDdate(rs.getString("DDATE"));
                dto.setGender(rs.getString("GENDER"));

                list.add(dto);
            } while (rs.next());
        }

    } catch (Exception e) {
        System.out.println("강의찾기실패:" + e);

    } finally {
        DBClose.close(con, pstmt, rs);
    }

    return list;
}//list() end

	
	public RegDTO detail(RegDTO dto) {
	      
	      System.out.println("detail");
	      
	      RegDTO detail = new RegDTO();
	      
	      try {
	         con=dbopen.getConnection();      
	         
	         sql=new StringBuilder();      
	         sql.append(" SELECT A.C_ID, A.C_TITLE, A.PROF_PHOTO, A.C_CONTENT,  A.C_TIME, A.C_DATE, A.PRICE,");
	         sql.append("(SELECT B.A_CONTENT FROM ans_tb B WHERE A.Q01ANS = B.A_CODE)AS q1, ");
	         sql.append("(SELECT B.A_CONTENT FROM ans_tb B WHERE A.Q03ANS = B.A_CODE)AS q3, ");
	         sql.append("(SELECT B.A_CONTENT FROM ans_tb B WHERE A.Q04ANS = B.A_CODE)AS q4 ");
	         sql.append(" FROM lesson_tb A");         
	         sql.append(" WHERE A.C_ID=?");
	         
	         
	         
	         pstmt=con.prepareStatement(sql.toString()); 
	                                          
	         pstmt.setInt(1, dto.getC_id());
	         
	         rs=pstmt.executeQuery();
	         
	         rs.next();
	         
	         detail.setC_id(rs.getInt("C_ID"));
	         detail.setC_title(rs.getString("C_TITLE"));
	         detail.setProf_photo(rs.getString("PROF_PHOTO"));
	         detail.setC_content(rs.getString("C_CONTENT"));
	         detail.setQ01ans(rs.getString("q1"));
	         detail.setQ03ans(rs.getString("q3"));
	         detail.setQ04ans(rs.getString("q4"));
	         detail.setC_time(rs.getString("C_TIME"));
	         detail.setC_date(rs.getString("C_DATE"));
	         detail.setPrice(rs.getInt("PRICE"));

	      }catch(Exception e) {
	         System.out.println("글상세보기 실패:" + e);
	      
	      }finally {
	         DBClose.close(con, pstmt, rs);
	      }//end
	      
	      return detail;   
	      
	   }//detail

	

	public int total(AnsDTO ans) {

		System.out.println("total()");
		
		int total = 0;
		
		try {
			con = dbopen.getConnection();		
			
			sql = new StringBuilder();
			
			if(ans.getQ02ans().equals("E")) {
				sql.append(" SELECT COUNT(*) cnt");
				sql.append(" FROM lesson_tb A LEFT JOIN user_tb B on B.ID = A.ID");
				sql.append(" WHERE Q01ANS = ? AND GENDER IN ('F','M') AND Q03ANS = ? AND Q04ANS = ? ORDER BY DDATE ASC;");
	
				pstmt = con.prepareStatement(sql.toString()); 
				
				System.out.println(sql.toString());
				
				pstmt.setString(1, ans.getQ01ans());
				pstmt.setString(2, ans.getQ03ans());
				pstmt.setString(3, ans.getQ04ans());
			
			}else {
				sql.append(" SELECT COUNT(*) cnt");
				sql.append(" FROM lesson_tb A LEFT JOIN user_tb B on B.ID = A.ID");
				sql.append(" WHERE Q01ANS = ? AND GENDER = ? AND  Q03ANS = ? AND Q04ANS =? ORDER BY DDATE ASC");
				
			
				pstmt = con.prepareStatement(sql.toString());
				
				System.out.println(sql.toString());
				
				pstmt.setString(1, ans.getQ01ans());
				pstmt.setString(2, ans.getQ02ans());
				pstmt.setString(3, ans.getQ03ans());
				pstmt.setString(4, ans.getQ04ans());	
				
			}//if end

			System.out.println(sql.toString());
			
			rs = pstmt.executeQuery();
			rs.next();
			
			total = rs.getInt("cnt");
	
		}catch(Exception e) {
			System.out.println(" total 실패 :" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		
		return total;
	}//total() end

	//시간 체크
	public ArrayList<CheckDTO> checkTime(CheckDTO dto) {
		System.out.println(">>>>>>checkTime()");
		
		ArrayList<CheckDTO> list = null;
		
		try {
			con = dbopen.getConnection();
		
			sql = new StringBuilder();
				
			sql.append("SELECT B.S_TIME FROM PAYMENT_TB  A LEFT OUTER JOIN PAYDETAIL_TB B ON B.ORDER_ID = A.ORDER_ID AND B.S_DATE = ? ");
			sql.append("WHERE A.C_ID = ?");
		
			pstmt = con.prepareStatement(sql.toString());
			
			System.out.println(sql.toString());
			
			pstmt.setString(1, dto.getDate());
			pstmt.setInt(2, dto.getC_id());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<CheckDTO>();
			
				do {
					CheckDTO result = new CheckDTO();
				
					result.setTime(rs.getString("S_TIME"));
					
					list.add(result);
				
				}while(rs.next());
			}//if end
			
		}catch(Exception e) {
			System.out.println("시간 확인 실패:" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		
		return list;
	}//checkTime() end
	
}//class end
