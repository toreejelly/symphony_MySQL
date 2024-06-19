package kr.co.symphony.notice;


import java.sql.Connection;




import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import net.utility.DBClose;
import net.utility.DBOpen;

public class NoticeDAO {

	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public NoticeDAO() {
		dbopen=new DBOpen();
	} //end
	
	public int create(NoticeDTO dto) {
		
		System.out.println("noticeCreate.do >>>>>> createForm >>>>>>create");
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();		
			sql=new StringBuilder();		
			sql.append(" INSERT INTO notice_tb(W_NUM, ID, W_TITLE, W_TEXT, W_DATE, W_CODE)");
			sql.append(" VALUES(W_NUM, ?, ?, ?, now() , 'n')");
			
			pstmt=con.prepareStatement(sql.toString()); 
				
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getwTitle());
			pstmt.setString(3, dto.getwText());

			cnt=pstmt.executeUpdate();	
			
		}catch(Exception e) {
			System.out.println("글쓰기 실패:" + e);
		
		}finally {
			DBClose.close(con, pstmt);
		}//end
		
		return cnt;		
	}//create() end
	
	public ArrayList<NoticeDTO> list2(String col, String word, int nowPage, int recordPerPage) {
		
		ArrayList<NoticeDTO> list=null;
		
		// 페이지당 출력할 레코드 갯수 (10개를 기준)
        // 1 page : WHERE r>=1 AND r<=10
        // 2 page : WHERE r>=11 AND r<=20
        // 3 page : WHERE r>=21 AND r<=30
		int startRow = (nowPage - 1) * recordPerPage;
		try {
		    con = dbopen.getConnection();
		    sql = new StringBuilder();
		    
		    word = word.trim(); // 검색어의 좌우 공백 제거
		    
		    if (word.length() == 0) { // 검색을 하지 않는 경우
		        sql.append("SELECT w_num, id, w_title, w_text, w_date, w_views ");
		        sql.append("FROM notice_tb ");
		        sql.append("WHERE W_CODE = 'n' ");
		        sql.append("ORDER BY w_num DESC ");
		        sql.append("LIMIT " + recordPerPage + " OFFSET " + startRow);
		    } else {
		        // 검색을 하는 경우
		        sql.append("SELECT w_num, id, w_title, w_text, w_date, w_views ");
		        sql.append("FROM ( ");
		        sql.append("    SELECT w_num, id, w_title, w_text, w_date, w_views, ");
		        sql.append("           ROW_NUMBER() OVER (ORDER BY w_num DESC) AS r ");
		        sql.append("    FROM notice_tb ");
		        
		        String search = "";
		        if (col.equals("w_title")) {
		            search += "WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'n' ";
		        } else if (col.equals("w_text")) {
		            search += "WHERE w_text LIKE '%" + word + "%' AND W_CODE = 'n' ";
		        } else if (col.equals("w_title_w_text")) {
		            search += "WHERE (w_title LIKE '%" + word + "%' OR w_text LIKE '%" + word + "%') AND W_CODE = 'n' ";
		        } else if (col.equals("id")) {
		            search += "WHERE id LIKE '%" + word + "%' AND W_CODE = 'n' ";
		        }//if end
		        
		        sql.append(search);
		        sql.append(") AS subquery ");
		        sql.append("WHERE r > " + startRow + " AND r <= " + (startRow + recordPerPage));
		    }
		    
		    pstmt = con.prepareStatement(sql.toString());
		    rs = pstmt.executeQuery();
		    if (rs.next()) {
		        list = new ArrayList<NoticeDTO>();
		        do {
		            NoticeDTO dto = new NoticeDTO(); // 한줄담기
		            dto.setwNum(rs.getInt("w_num"));
		            dto.setId(rs.getString("id"));
		            dto.setwTitle(rs.getString("w_title"));
		            dto.setwText(rs.getString("w_text"));
		            dto.setwDate(rs.getString("w_date"));
		            dto.setwViews(rs.getInt("w_views"));
		            list.add(dto); // list에 모으기
		        } while (rs.next());
		    }//end
		    
		} catch (Exception e) {
		    System.out.println("글개수 실패n : " + e);
		} finally {
		    DBClose.close(con, pstmt, rs);
		}
		return list;

	}
	
	//여기서부터 바꿔
	public int count2(String col, String word) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT COUNT(*) as cnt ");
			sql.append(" FROM notice_tb WHERE w_code='n' ");
			
			if(word.length()>=1) { // 검색어가 존재한다면
				String search="";
				if(col.equals("w_title_w_text")) {
					search+=" WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'n' ";
					search+=" OR w_text LIKE '%" + word + "%' ";
				} else if(col.equals("w_title")) {
					search+=" WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'n' ";
				} else if(col.equals("w_text")) {
					search+=" WHERE w_text LIKE '%" + word + "%' AND W_CODE = 'n' ";
				} else if(col.equals("id")) {
					search+=" WHERE id LIKE '%" + word + "%' AND W_CODE = 'n' ";
				}//if end
				sql.append(search);
			}
			
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			
		}catch (Exception e) {
			System.out.println("글개수 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
	}

	
	public NoticeDTO count(NoticeDTO dto) {
		
		
		NoticeDTO count=new NoticeDTO();
		
		try {
            con=dbopen.getConnection();
            
            sql=new StringBuilder();
            sql.append(" UPDATE notice_tb ");
            sql.append(" SET W_VIEWS=W_VIEWS+1 ");
            sql.append(" WHERE W_NUM=? ");
            
            pstmt=con.prepareStatement(sql.toString());
            pstmt.setInt(1, dto.getwNum());
            pstmt.executeUpdate();
            
        }catch (Exception e) {
            System.out.println("조회수 증가 실패:"+e);
        }finally {
            DBClose.close(con, pstmt);
        }//end    
		
		return count;		
	}//count() end
	
	
	
	public NoticeDTO detail(NoticeDTO dto) {
	
		System.out.println("detail");
		
		NoticeDTO detail=new NoticeDTO();
		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" SELECT W_NUM,W_TITLE,W_TEXT");
			sql.append(" FROM notice_tb");
			sql.append(" WHERE W_NUM=?");
			
			pstmt=con.prepareStatement(sql.toString()); 
														
			pstmt.setInt(1, dto.getwNum());
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			detail.setwNum(rs.getInt("W_NUM"));
			detail.setwTitle(rs.getString("W_TITLE"));
			detail.setwText(rs.getString("W_TEXT"));

		}catch(Exception e) {
			System.out.println("글상세보기 실패:" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		
		return detail;		
	}//detail() end
	
	
	public int delete(int wNum) {
		int cnt=0;
    	try {
    		con=dbopen.getConnection();
            
            sql=new StringBuilder();
            sql.append(" DELETE FROM notice_tb ");
            sql.append(" WHERE W_NUM=? AND W_CODE='n'");
            
            pstmt=con.prepareStatement(sql.toString());
            pstmt.setInt(1, wNum);
          
            cnt=pstmt.executeUpdate();
    		
    		
    	}catch (Exception e) {
            System.out.println("공지사항 삭제 실패:"+e);
        }finally {
            DBClose.close(con, pstmt);
        }//end
        return cnt;
    }//delete()end
	
	
	public int update(NoticeDTO dto) {
		int cnt=0;
		System.out.println("update");

		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" UPDATE notice_tb ");
			sql.append(" SET W_TITLE=?, W_TEXT=?");
			sql.append(" WHERE W_NUM=? AND W_CODE IN ('n') ");
	            
			pstmt=con.prepareStatement(sql.toString()); 
														
			pstmt.setString(1, dto.getwTitle());
			pstmt.setString(2, dto.getwText());
			pstmt.setInt(3, dto.getwNum());
			
			cnt=pstmt.executeUpdate();
		
		}catch (Exception e) {
            System.out.println("공지사항 수정 실패:"+e);	
			
		}finally {
			DBClose.close(con, pstmt);
		}//end
		
		return cnt;		
	}//update() end

	
	public int total() {

		System.out.println("total()");
		
		int total = 0;
		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" SELECT COUNT(*) cnt");
			sql.append(" FROM notice_tb");
			sql.append(" WHERE W_CODE = 'n'");
			
			pstmt=con.prepareStatement(sql.toString()); 
			
			System.out.println(sql.toString());
			
			rs=pstmt.executeQuery();
			rs.next();
			
			total = rs.getInt("cnt");

		}catch(Exception e) {
			System.out.println(" total 실패 :" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		
		return total;
	}//total() end
	
}//class end

