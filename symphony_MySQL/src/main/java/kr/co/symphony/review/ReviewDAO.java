package kr.co.symphony.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;

public class ReviewDAO {

	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public ReviewDAO() {
		dbopen=new DBOpen();
	} //end
	
	public int create(ReviewDTO dto) {
		
		
		int cnt=0;
		
		try {
			con=dbopen.getConnection();		
		
			sql=new StringBuilder();	
			sql.append("INSERT INTO notice_tb (ID, W_TITLE, W_TEXT, W_PIC, W_PICPATH, W_DATE, W_CODE) ");
			sql.append("VALUES (?, ?, ?, ?, ?, NOW(), 'r')");
			
			pstmt=con.prepareStatement(sql.toString()); 

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getwTitle());
			pstmt.setString(3, dto.getwText());
			pstmt.setString(4, dto.getwPic());
			pstmt.setString(5, dto.getwPicPath());

			cnt=pstmt.executeUpdate();	
			
		}catch(Exception e) {
			
			System.out.println("수강후기 글쓰기 실패:" + e);
		
		}finally {
		
			DBClose.close(con, pstmt);
		
		}//end
		
		return cnt;		
	}//create() end
	
	
	public ArrayList<ReviewDTO> list2(String col, String word, int nowPage, int recordPerPage) {
		
		ArrayList<ReviewDTO> list=null;
		
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
	            sql.append(" SELECT w_num, id, w_title, w_text, w_date, w_views, w_like ");
	            sql.append("FROM notice_tb ");
	            sql.append("WHERE W_CODE = 'r' ");
	            sql.append("ORDER BY w_num DESC ");
	            //sql.append("LIMIT \" + recordPerPage + \" OFFSET \" + startRow");
	            sql.append("LIMIT " + recordPerPage + " OFFSET " +startRow);
	       
	            
	          } else {
	            
	            //검색을 하는 경우
	        	  sql.append("SELECT w_num, id, w_title, w_text, w_date, w_views, w_like ");
	        	  sql.append("FROM ( ");
	        	  sql.append("    SELECT w_num, id, w_title, w_text, w_date, w_views, w_like, ");
	        	  sql.append("           ROW_NUMBER() OVER (ORDER BY w_num DESC) AS r ");
	        	  sql.append("    FROM notice_tb ");
	            
	            String search="";
	            if(col.equals("w_title")) {
	                search += " WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'r' ";
	            }else if(col.equals("w_text")) {
	                search += " WHERE w_text LIKE '%" + word + "%' AND W_CODE = 'r' ";
	            }else if(col.equals("w_title_w_text")) {
	                search += " WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'r' ";
	                search += " OR w_text LIKE '%" + word + "%' AND W_CODE = 'r' ";
	            }else if(col.equals("id")) {
	                search += " WHERE id LIKE '%" + word + "%' AND W_CODE = 'r' ";
	            }//if end
	            
	            sql.append(search);
	        	  sql.append(") AS subquery ");
	        	  sql.append("WHERE r > " + startRow + " AND r <= " + (startRow + recordPerPage));
	          }
			
			pstmt = con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list=new ArrayList<ReviewDTO>();
				do {
					ReviewDTO dto=new ReviewDTO(); // 한줄담기
					dto.setwNum(rs.getInt("w_num"));
					dto.setId(rs.getString("id"));
					dto.setwTitle(rs.getString("w_title"));
					dto.setwText(rs.getString("w_text"));
					dto.setwDate(rs.getString("w_date"));
					dto.setwViews(rs.getInt("w_views"));
					dto.setwLike(rs.getInt("w_like"));
					list.add(dto); // list에 모으기
				}while(rs.next());
			}//end
			
		}catch (Exception e) {
			System.out.println("글개수 실패d : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}
	
	//여기서부터
	public int count2(String col, String word) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" SELECT COUNT(*) as cnt ");
			sql.append(" FROM notice_tb WHERE w_code='r' ");
			
			if(word.length()>=1) { // 검색어가 존재한다면
				String search="";
				if(col.equals("w_title_w_text")) {
					search+=" WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'r' ";
					search+=" OR w_text LIKE '%" + word + "%' AND W_CODE = 'r' ";
				} else if(col.equals("w_title")) {
					search+=" WHERE w_title LIKE '%" + word + "%' AND W_CODE = 'r' ";
				} else if(col.equals("w_text")) {
					search+=" WHERE w_text LIKE '%" + word + "%' AND W_CODE = 'r' ";
				} else if(col.equals("id")) {
					search+=" WHERE id LIKE '%" + word + "%' AND W_CODE = 'r' ";
				}//if end
				sql.append(search);
			}
			
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			
		}catch (Exception e) {
			System.out.println("글갯수 실패 : " + e);
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return cnt;
	}

	
public ReviewDTO count(ReviewDTO dto) {
		
		
		ReviewDTO count=new ReviewDTO();
		
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
	
	public ReviewDTO detail(ReviewDTO dto) {
		
		
		ReviewDTO detail=new ReviewDTO();
		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" SELECT W_NUM,W_TITLE,W_TEXT,W_PIC,W_PICPATH");
			sql.append(" FROM notice_tb");
			sql.append(" WHERE W_NUM=? AND W_CODE='r'");
			
			pstmt=con.prepareStatement(sql.toString()); 
														
			pstmt.setInt(1, dto.getwNum());
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			detail.setwNum(rs.getInt("W_NUM"));
			detail.setwTitle(rs.getString("W_TITLE"));
			detail.setwText(rs.getString("W_TEXT"));
			detail.setwPic(rs.getString("W_PIC"));
			detail.setwPicPath(rs.getString("W_PICPATH"));

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
            sql.append(" WHERE W_NUM=?  AND W_CODE='r' ");
            
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
	
	public int update(ReviewDTO dto) {
		int cnt=0;

		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" UPDATE notice_tb ");
			sql.append(" SET W_TITLE=?, W_TEXT=?, W_PIC=?, W_PICPATH=? ");
			sql.append(" WHERE W_NUM=? AND W_CODE='r'");
	            
			pstmt=con.prepareStatement(sql.toString()); 
			
			System.out.println(sql.toString());
														
			pstmt.setString(1, dto.getwTitle());
			pstmt.setString(2, dto.getwText());
			pstmt.setString(3, dto.getwPic());
			pstmt.setString(4, dto.getwPicPath());
			pstmt.setInt(5, dto.getwNum());
			
			cnt=pstmt.executeUpdate();
		
		}catch (Exception e) {
            System.out.println("공지사항 수정 실패:"+e);	
			
		}finally {
			DBClose.close(con, pstmt);
		}//end
		
		return cnt;		
	}//update() end
	
	
	public int total() {

		int total = 0;
		
		try {
			con=dbopen.getConnection();		
			
			sql=new StringBuilder();		
			sql.append(" SELECT COUNT(*) cnt");
			sql.append(" FROM notice_tb");
			sql.append(" WHERE W_CODE = 'r'");
			
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
	
	//좋아요 되어있는지 확인
	public LikeDTO checkLike(LikeDTO dto) {
		
		System.out.println("checkLike()");
		
		LikeDTO result = new LikeDTO();
		
		try {
			con = dbopen.getConnection();		
			
			sql = new StringBuilder();		
			sql.append("SELECT LIKE_NUM FROM LIKE_TB WHERE ID = ? AND W_NUM = ?");
			
			pstmt = con.prepareStatement(sql.toString()); 
			
			System.out.println(sql.toString());
														
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getwNum());
			
			 rs = pstmt.executeQuery();
		        
		        if (rs.next()) {
		            result.setLikeNum(rs.getInt("LIKE_NUM"));
		        }

		    } catch(Exception e) {
		        System.out.println("checkLike 실패: " + e);
		    } finally {
		        DBClose.close(con, pstmt, rs);
		    }
		    
		    return result;
	}//checkLike() end

	//좋아요 클릭
	public void like(LikeDTO dto) {

		System.out.println("like()"+dto.getLikedYn());
			
		try {
			con = dbopen.getConnection();		
			
			sql = new StringBuilder();		
			
			if(dto.getLikedYn().equals("N")) {
				
				sql.append("INSERT INTO LIKE_TB(LIKE_NUM, W_NUM, W_CODE, ID) VALUES ((SELECT NVL(MAX(LIKE_NUM)+1 ,'1') FROM LIKE_TB), ?, ?, ?)");
				
				pstmt=con.prepareStatement(sql.toString()); 
				
				System.out.println(sql.toString());
															
				pstmt.setInt(1, dto.getwNum());
				pstmt.setString(2, dto.getwCode());
				pstmt.setString(3, dto.getId());
				
			}else {
				
				sql.append("DELETE FROM LIKE_TB WHERE LIKE_NUM = ?");
				
				pstmt=con.prepareStatement(sql.toString()); 
				
				System.out.println(sql.toString());
															
				pstmt.setInt(1, dto.getLikeNum());

			}
			
			rs = pstmt.executeQuery();
			rs.next();

		}catch(Exception e) {
			System.out.println(" like 실패 :" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end	
	}//like() end 

	//wLike 넣기
	public void wLike(LikeDTO dto) {

		System.out.println("like()"+dto.getLikedYn());
			
		try {
			con = dbopen.getConnection();		
			
			sql = new StringBuilder();		
			
			if(dto.getLikedYn().equals("N")) {
				
				sql.append("UPDATE NOTICE_TB SET W_LIKE = (SELECT NVL(W_LIKE, '0') +1 FROM NOTICE_TB WHERE W_NUM = ? AND W_CODE = 'r') WHERE W_NUM = ?");
				
				pstmt = con.prepareStatement(sql.toString()); 
				
				System.out.println(sql.toString());
															
				pstmt.setInt(1, dto.getwNum());
				pstmt.setInt(2, dto.getwNum());
				
			}else {
				
				sql.append("UPDATE NOTICE_TB SET W_LIKE = (SELECT NVL(W_LIKE, '0') -1 FROM NOTICE_TB WHERE W_NUM = ? AND W_CODE = 'r') WHERE W_NUM = ?");
				
				pstmt = con.prepareStatement(sql.toString()); 
				
				System.out.println(sql.toString());
															
				pstmt.setInt(1, dto.getwNum());
				pstmt.setInt(2, dto.getwNum());

			}
			
			rs = pstmt.executeQuery();
			rs.next();

		}catch(Exception e) {
			System.out.println(" like 실패 :" + e);
		
		}finally {
			DBClose.close(con, pstmt, rs);
		}//end	
	}//wLike() end
	
	//좋아요 123등
	public ArrayList<ReviewDTO> likeList() {
	    ArrayList<ReviewDTO> list = null;
	    
	    try {
	        con = dbopen.getConnection();        
	        sql = new StringBuilder();        
	        
	        sql.append("SELECT @ranking := @ranking + 1 AS ranking, B.* ");
	        sql.append("FROM (SELECT (SELECT COUNT(*) FROM LIKE_TB WHERE W_NUM = A.W_NUM) AS CNT, A.* FROM NOTICE_TB A ");
	        sql.append("WHERE W_CODE = 'r' AND A.W_DATE > DATE_FORMAT(NOW(), '%Y-%m-01') AND A.W_DATE < LAST_DAY(NOW()) ORDER BY CNT DESC, A.W_DATE DESC) B, (SELECT @ranking := 0) AS dummy ");
	        sql.append("WHERE @ranking < 4");
	        
	        pstmt = con.prepareStatement(sql.toString());
	        
	        System.out.println(sql.toString());
	        
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            list = new ArrayList<ReviewDTO>();
	            do {
	                ReviewDTO dto = new ReviewDTO();
	                
	                dto.setRank(rs.getInt("ranking"));
	                dto.setwNum(rs.getInt("w_num"));
	                dto.setId(rs.getString("id"));
	                dto.setwTitle(rs.getString("w_title"));
	                dto.setwText(rs.getString("w_text"));
	                dto.setwPic(rs.getString("w_pic"));
	                dto.setwPicPath(rs.getString("w_picpath"));
	                dto.setwDate(rs.getString("w_date"));
	                dto.setwRdate(rs.getString("w_rdate"));
	                dto.setwLike(rs.getInt("w_like"));
	                dto.setwViews(rs.getInt("w_views"));
	                
	                list.add(dto); 
	                
	            } while (rs.next());
	        }
	    } catch(Exception e) {
	        System.out.println("likeList 실패: " + e);
	    } finally {
	        DBClose.close(con, pstmt, rs);
	    }
	    
	    return list;
	}

	
}//class end
