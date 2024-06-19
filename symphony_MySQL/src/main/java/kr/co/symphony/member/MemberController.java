package kr.co.symphony.member;



import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.symphony.lessonreg.RegDTO;
import net.utility.Utility;

@Controller
public class MemberController {

	private MemberDAO dao = null;

	public MemberController() {
		dao = new MemberDAO();
		System.out.println("------MemberController() 객체 생성됨");
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	@RequestMapping(value = "loginform.do", method = RequestMethod.GET)
	public String loginForm() {
		System.out.println("login");
		return "member/login"; // /WEB-INF/views/login/loginForm.jsp
	}
	
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public ModelAndView loginProc(@ModelAttribute MemberDTO dto, HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		System.out.println("loginproc");
		ModelAndView mav = new ModelAndView();
		
		String id=req.getParameter("id").trim();
		String passwd=req.getParameter("passwd").trim();

		dto.setId(id);
		dto.setPasswd(passwd);
		
		String ulevel=dao.loginProc(dto);
		
		if(ulevel==null) {
			
			System.out.println("<p>아이디/비밀번호를 다시 한번 확인해주세요</p>");
			System.out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
			
			mav.setViewName("member/login");
		}else {
			System.out.println("로그인 성공");
			//out.print("회원등급 : " + ulevel);
			
			// 다른 페이지에서 로그인 상태정보를 공유할 수 있도록
			session.setAttribute("s_id", id);
			session.setAttribute("s_passwd", passwd);
			session.setAttribute("s_ulevel", ulevel);
			session.setAttribute("info", dto);
			
			// 쿠키 시작-------------------------------------------------------------
			//-> 웹서버가 사용자PC에 저장하는 텍스트 파일로 된 정보
			//-> 각 브라우저의 쿠키삭제의 영향을 받는다
			//-> 보안에 취약하다
			//-> 예) 아이디저장, 오늘창그만보기, 클릭한상품목록
			//-> 예) 오늘창그만보기는 자바스크립트 쿠키. 참조) https://www.w3schools.com/js/js_cookies.asp

			// <input type="checkbox" name="c_id"> 값 가져오기
			String c_id=Utility.checkNull(req.getParameter("c_id"));
			Cookie cookie=null;
			if(c_id.equals("SAVE")) { // 아이디 저장에 체크를 했다면
				// 쿠키변수 선언
				cookie=new Cookie("c_id", id);
				// 쿠키의 생존기간 1개월
				cookie.setMaxAge(60*60*24*30); // 각 브라우저의 쿠키삭제의 영향을 받는다
				
			}else {
				cookie=new Cookie("c_id", "");
				cookie.setMaxAge(0);
			}
			
			resp.addCookie(cookie); // 요청한 사용자 PC에 쿠키값을 저장
			
			// 쿠키 끝-------------------------------------------------------------
			
			
			mav.setViewName("intro");
			mav.addObject("id", id);
		}
		
		return mav;
		
	}
	
	
	@RequestMapping(value = "logoutproc.do", method = RequestMethod.GET)
	public ModelAndView logoutProc(@ModelAttribute MemberDTO dto, HttpServletResponse resp, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/login");
		
		// 세션변수 제거 -> null값
		session.removeAttribute("s_id");
		session.removeAttribute("s_passwd");
		session.removeAttribute("s_ulevel");
		session.removeAttribute("info");
		

		
		return mav;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

	@RequestMapping("signin.do")    
	public String createForm() {
		System.out.println("signin.do >>>>>> createForm");
		
		return "member/signin";
	} 

	@RequestMapping(value = "signin.do", method = RequestMethod.POST)
	public ModelAndView createProc(@ModelAttribute MemberDTO dto) {
		System.out.println("signin.do >>>>>> createProc");
		

		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/msgView");

		int cnt=dao.create(dto);

		if(cnt==0) {
			String msg="회원가입에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/signin.do" );	
	
		}else {
			String msg="회원가입에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/home.do" );
		
		}//if end
		
		return mav;
	}// create() end
		
	
	@RequestMapping("idCheckForm.do")    
	public String idCheckForm() {
		return "member/idCheckForm";
	}//idCheckForm() end

	

	@RequestMapping(value = "idCheckProc.do", method = RequestMethod.POST)
	public ModelAndView idCheckProc(HttpServletRequest req) {
		
		String id=req.getParameter("id");
		int cnt=dao.duplecateID(id);        //dao에서 아이디 중복되었다면 1, 중복되지 않았다면 0 반환
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("member/idCheckProc"); //idCheckProc.jsp 뷰페이지 이동
		mav.addObject("cnt", cnt); //request영역에 cnt값 올림. idCheckProc.jsp의 14행
		mav.addObject("id", id);   //request영역에 id값 올림. idCheckProc.jsp의 15행
		return mav;
	}//idCheckProc() end
	
	
	@RequestMapping("emailCheckForm.do")    
	public String emailCheckForm() {
		return "member/emailCheckForm";
	}//emailCheckForm() end

	

	@RequestMapping(value = "emailCheckProc.do", method = RequestMethod.GET)
	public ModelAndView emailCheckProc(HttpServletRequest req) {
		
		String email=req.getParameter("email");
		int cnt=dao.duplecateEmail(email);        //dao에서 아이디 중복되었다면 1, 중복되지 않았다면 0 반환
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("member/emailCheckProc"); 
		mav.addObject("cnt", cnt); //request영역에 cnt값 올림.
		mav.addObject("email", email);   //request영역에 id값 올림. 
		return mav;
	}//emailCheckProc() end
	
	@RequestMapping(value = "modify.do", method = RequestMethod.GET)
	public ModelAndView modifyForm(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/memberModify");
		
		dto = dao.read(dto);
		mav.addObject("dto", dto); // DB에서 수정할 행 가져오기
		
		
		return mav;
	}
	
	@RequestMapping(value = "modifyproc.do", method = RequestMethod.POST)
	public ModelAndView memberModify(@ModelAttribute MemberDTO dto, HttpServletRequest req, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/msgView");
		
		
		// 1) 사용자가 입력 요청한 값 가져오기
		String passwd = req.getParameter("passwd").trim();
		String uname = req.getParameter("uname").trim();
		String tel = req.getParameter("tel").trim();
		String email = req.getParameter("email").trim();
		String zipcode = req.getParameter("zipcode").trim();
		String address1 = req.getParameter("address1").trim();
		String address2 = req.getParameter("address2").trim();
		//String ulevel = req.getParameter("ulevel").trim();

		// 2) dto객체 담기
		dto.setId((String)session.getAttribute("s_id"));
		dto.setPasswd((String)session.getAttribute("s_passwd"));
		dto.setUname((String)session.getAttribute("s_uname"));
		dto.setTel((String)session.getAttribute("s_tel"));
		dto.setEmail((String)session.getAttribute("s_email"));
		dto.setZipcode((String)session.getAttribute("s_zipcode"));
		dto.setAddress1((String)session.getAttribute("s_address1"));
		dto.setAddress2((String)session.getAttribute("s_address2"));
		
		dto.setPasswd(passwd);
		dto.setUname(uname);
		dto.setEmail(email);
		dto.setTel(tel);
		dto.setZipcode(zipcode);
		dto.setAddress1(address1);
		dto.setAddress2(address2);
		//dto.setUlevel(ulevel);

		// 3) member테이블에 추가하기
		int cnt=dao.modifyProc(dto);
		
		if(cnt==0) {
			String msg="회원 정보 수정 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/loginform.do" );	

		}else {
			
			String msg="회원 정보 수정 되었습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/loginform.do" );	

		}
		return mav;
	}
	
	@RequestMapping(value = "findid.do", method = RequestMethod.GET)
	public String findId() {
		return "member/findID";
	}
	
	@RequestMapping(value = "findidproc.do", method = RequestMethod.POST)
	public ModelAndView findIdProc(@ModelAttribute MemberDTO dto, HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/msgView");
		
		String uname=req.getParameter("uname").trim();
		String email=req.getParameter("email").trim();
		
		dto.setUname(uname);
		dto.setEmail(email);
		
		boolean flag=dao.findID(dto);
		if(flag==false) {
			
			String msg="이름/이메일을 다시 한번 확인해주세요";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/findid.do" );
			
		} else {
			
			String msg="아이디/임시 비밀번호가 이메일로 전송되었습니다. \\n 임시 비밀번호는 로그인 후 회원정보수정에서 수정하시기 바랍니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/loginform.do" );
			
		}
		return mav;
	}
	

}




