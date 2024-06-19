package kr.co.symphony.lessonreg;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


import kr.co.symphony.lessonreg.RegDTO;
import kr.co.symphony.notice.NoticeDTO;
import net.utility.DBClose;
import net.utility.DBOpen;



public class RegDAO {
	private DBOpen dbopen = null;
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	public RegDAO() {
		dbopen = new DBOpen();
	}

	public int create(RegDTO dto) {
	    int cnt = 0;
	    try {
	        con = dbopen.getConnection();
	        sql = new StringBuilder();
	        sql.append(
	                "INSERT INTO lesson_tb(id, c_title, prof_photo, c_content, q01ans, q03ans, q04ans, c_time, c_date, price, ddate) ");
	        sql.append("VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW()) ");
	        ////import java.sql.Statement;
	        pstmt = con.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, dto.getId());
	        pstmt.setString(2, dto.getC_title());
	        pstmt.setString(3, dto.getProf_photo());
	        pstmt.setString(4, dto.getC_content());
	        pstmt.setString(5, dto.getQ01ans());
	        pstmt.setString(6, dto.getQ03ans());
	        pstmt.setString(7, dto.getQ04ans());
	        pstmt.setString(8, dto.getC_time());
	        pstmt.setString(9, dto.getC_date());
	        pstmt.setInt(10, dto.getPrice());
	        cnt = pstmt.executeUpdate();
	        
	        // 새로 생성된 레코드의 자동 증가된 c_id 값을 가져옴
	        ResultSet rs = pstmt.getGeneratedKeys();
	        if (rs.next()) {
	            dto.setC_id(rs.getInt(1)); // 새로 생성된 c_id 설정
	        }

	    } catch (Exception e) {
	        System.out.println("강의 등록 실패 : " + e);
	    } finally {
	        DBClose.close(con, pstmt);
	    }
	    return cnt;
	}

	
	
	public ArrayList<RegDTO> list2(String col, String word, int nowPage, int recordPerPage) {
		
		ArrayList<RegDTO> list=null;
		
		// 페이지당 출력할 레코드 갯수 (10개를 기준)
        // 1 page : WHERE r>=1 AND r<=10
        // 2 page : WHERE r>=11 AND r<=20
        // 3 page : WHERE r>=21 AND r<=30
		int startRow = (nowPage - 1) * recordPerPage;
		
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			
			word = word.trim(); //검색어의 좌우 공백 제거
			
			if(word.length()==0) { //검색을 하지 않는 경우
				sql.append(" SELECT c_id, id, c_title, c_content, ddate, w_views, price ");
	            sql.append(" FROM lesson_tb ");
	            sql.append(" ORDER BY c_id DESC ");
	            sql.append("LIMIT " + recordPerPage + " OFFSET " + startRow);
	            
	          } else {
	            
	            //검색을 하는 경우
	            //sql.append(" SELECT c_id, id, c_title, c_content, ddate, w_views, price, r ");
	            //sql.append(" FROM( SELECT c_id, id, c_title, c_content, ddate, w_views, price, rownum as r ");
	            //sql.append("       FROM ( SELECT c_id, id, c_title, c_content, ddate, w_views, price ");
	            //sql.append("              FROM lesson_tb ");
	        	  sql.append(" SELECT c_id, id, c_title, c_content, ddate, w_views, price ");
	        	  sql.append("FROM ( ");
	        	  sql.append("    SELECT c_id, id, c_title, c_content, ddate, w_views, price, ");
	        	  sql.append("           ROW_NUMBER() OVER (ORDER BY c_id DESC) AS r ");
			      sql.append("    FROM lesson_tb ");
	        	  
	        	  
	            
	            String search="";
	            if(col.equals("c_title")) {
	                search += " WHERE c_title LIKE '%" + word + "%' ";
	            }else if(col.equals("c_content")) {
	                search += " WHERE c_content LIKE '%" + word + "%' ";
	            }else if(col.equals("c_title_c_content")) {
	                search += " WHERE c_title LIKE '%" + word + "%' ";
	                search += " OR c_content LIKE '%" + word + "%' ";
	            }else if(col.equals("id")) {
	                search += " WHERE id LIKE '%" + word + "%' ";
	            }//if end
	            
	            sql.append(search);
	            sql.append(") AS subquery ");
		        sql.append("WHERE r > " + startRow + " AND r <= " + (startRow + recordPerPage));
	          }
			
			pstmt = con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list=new ArrayList<RegDTO>();
				do {
					RegDTO dto=new RegDTO(); // 한줄담기
					dto.setC_id(rs.getInt("c_id"));
					dto.setId(rs.getString("id"));
					dto.setC_title(rs.getString("c_title"));
					dto.setC_content(rs.getString("c_content"));
					dto.setDdate(rs.getString("ddate"));
					dto.setW_views(rs.getInt("w_views"));
					dto.setPrice(rs.getInt("price"));
					list.add(dto); // list에 모으기
				}while(rs.next());
			}//end
			
		}catch (Exception e) {
			System.out.println("강의목록 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}
	
	public int count2(String col, String word) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT COUNT(*) as cnt ");
			sql.append(" FROM lesson_tb ");
			
			if(word.length()>=1) { // 검색어가 존재한다면
				String search="";
				if(col.equals("c_title_c_content")) {
					search+=" WHERE c_title LIKE '%" + word + "%' ";
					search+=" OR c_content LIKE '%" + word + "%' ";
				} else if(col.equals("c_title")) {
					search+=" WHERE w_title LIKE '%" + word + "%' ";
				} else if(col.equals("c_content")) {
					search+=" WHERE c_content LIKE '%" + word + "%' ";
				} else if(col.equals("id")) {
					search+=" WHERE id LIKE '%" + word + "%' ";
				}//if end
				sql.append(search);
			}
			
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			
		}catch (Exception e) {
			System.out.println("강의목록갯수 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
	}

	
	public RegDTO count(RegDTO dto) {
		
		
		RegDTO count=new RegDTO();
		
		try {
            con=dbopen.getConnection();
            
            sql=new StringBuilder();
            sql.append(" UPDATE lesson_tb ");
            sql.append(" SET w_views=w_views+1 ");
            sql.append(" WHERE c_id=? ");
            
            pstmt=con.prepareStatement(sql.toString());
            pstmt.setInt(1, dto.getC_id());
            pstmt.executeUpdate();
            
        }catch (Exception e) {
            System.out.println("조회수 증가 실패:"+e);
        }finally {
            DBClose.close(con, pstmt);
        }//end    
		
		return count;		
	}//count() end
	
	
public RegDTO r_detail(RegDTO dto) {
		
		
		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" SELECT c_id, c_title, prof_photo, c_content, q01ans, q03ans, q04ans, c_time, c_date, price ");
			sql.append(" FROM lesson_tb");
			sql.append(" WHERE c_id=?");
			
			pstmt=con.prepareStatement(sql.toString()); 
														
			pstmt.setInt(1, dto.getC_id());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new RegDTO();
				dto.setC_id(rs.getInt("c_id"));
				dto.setC_title(rs.getString("c_title"));
				dto.setProf_photo(rs.getString("prof_photo"));
				dto.setC_content(rs.getString("c_content"));
				dto.setQ01ans(rs.getString("q01ans"));
				dto.setQ03ans(rs.getString("q03ans"));
				dto.setQ04ans(rs.getString("q04ans"));
				dto.setC_time(rs.getString("c_time"));
				dto.setC_date(rs.getString("c_date"));
				dto.setPrice(rs.getInt("price"));
				
			}

		}catch(Exception e) {
			System.out.println("상세보기 실패:" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end
		
		return dto;		
	}//detail() end


	public int delete(int c_id) {
		int cnt = 0;
		try {
			con = dbopen.getConnection();

			sql = new StringBuilder();
			sql.append(" DELETE FROM lesson_tb ");
			sql.append(" WHERE c_id=? ");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, c_id);

			cnt = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("강의 삭제 실패:" + e);
		} finally {
			DBClose.close(con, pstmt);
		} // end
		return cnt;
	}// delete()end
	
	
	public int update(RegDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" UPDATE lesson_tb ");
			sql.append(" SET c_title=?, prof_photo=?, c_content=?, q01ans=?, q03ans=?, q04ans=?, c_time=?, c_date=?, price=? ");
			sql.append(" WHERE c_id=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getC_title());
			pstmt.setString(2, dto.getProf_photo());
			pstmt.setString(3, dto.getC_content());
			pstmt.setString(4, dto.getQ01ans());
			pstmt.setString(5, dto.getQ03ans());
			pstmt.setString(6, dto.getQ04ans());
			pstmt.setString(7, dto.getC_time());
			pstmt.setString(8, dto.getC_date());
			pstmt.setInt(9, dto.getPrice());
			pstmt.setInt(10, dto.getC_id());
			cnt=pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("음원 수정 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt);
		}
		return cnt;
	}
	
		
	
}
