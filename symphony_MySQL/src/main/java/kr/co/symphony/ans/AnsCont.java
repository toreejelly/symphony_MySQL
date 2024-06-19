package kr.co.symphony.ans;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.symphony.lessonreg.RegDTO;
import kr.co.symphony.paging.PageDTO;
import kr.co.symphony.pay.PayDTO;

@Controller
public class AnsCont {
		
		AnsDAO dao = null;
		
		public AnsCont() {
			dao = new AnsDAO();
			System.out.println("------AnsCont() 객체 생성됨");		
		}//end
		
		
		//강의 찾기
		@RequestMapping(value = "courses.do", method = RequestMethod.GET)
		public ModelAndView createForm() {
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("lessonsearch/course");
			
			return mav;
		}//createForm() end
		
		
		//강의 찾기 제출
		@RequestMapping("submitAns.do")
		public ModelAndView submitAns(@ModelAttribute AnsDTO dto, HttpSession session) {

			//세션 활용
			System.out.println("아이디 : "+session.getAttribute("s_id"));
			
			String id = (String) session.getAttribute("s_id");
			dto.setId(id);
			int cnt = dao.ansIns(dto);
			int nowPage = 1;
					
			ModelAndView mav = new ModelAndView();
					
			if(cnt == 1) {
						
				int total = dao.total(dto);
				int amount = 6;
						
				PageDTO page = new PageDTO(nowPage,total,amount);
						
				ArrayList<RegDTO> list = dao.resultSel(dto, page);
						
				if(list != null) {
							
					System.out.println("개수>>>>>>>>>"+list.size());
							
					mav.setViewName("lessonsearch/result");
					mav.addObject("list", list);
					mav.addObject("page", page);
					mav.addObject("dto", dto);
							
				}else {
					mav.setViewName("redirect:courses.do");// 주소로 넘겨 줌 
				}
						
			}else {
				mav.setViewName("redirect:courses.do");// 주소로 넘겨 줌 
			}
				
			return mav;
		}// submitAns() end
		
		
		//강의 찾기 결과
		@RequestMapping("result.do")
		public ModelAndView resultAns(@ModelAttribute AnsDTO dto, @RequestParam(required = false, defaultValue = "1") int nowPage) {
			//@RequestParam 요구되는 파라미터
			//required = false 필수는 아님
			//defaultValue = "1" 디폴트 값이1		
			ModelAndView mav = new ModelAndView();
					
			if(dto != null) {
						
				int total = dao.total(dto);
				int amount = 6;
						
				PageDTO page = new PageDTO(nowPage,total,amount);
						
				ArrayList<RegDTO> list = dao.resultSel(dto, page);
						
				if(list != null) {
							
					System.out.println("개수>>>>>>>>>"+list.size());
							
					mav.setViewName("lessonsearch/result");
					mav.addObject("list", list);
					mav.addObject("page", page);
					mav.addObject("dto", dto);
							
				}else {
					mav.setViewName("redirect:courses.do");// 주소로 넘겨 줌 
				}
						
			}else {
				mav.setViewName("redirect:courses.do");
			}
				
			return mav;
		}// submitAns() end
				
		
		@RequestMapping(value = "resultDetail.do", method = RequestMethod.GET)	
		public ModelAndView detailForm(@ModelAttribute RegDTO dto) {
			
			System.out.println("detailForm()");
			System.out.println("번호"+dto.getC_id());			
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("lessonsearch/resultDetail");
			//NewFile
			mav.addObject("detail", dao.detail(dto));
			return mav;
			
		}//detailForm() end
		
		
	   @ResponseBody
	   @RequestMapping(value = "submitCheck.do", method = RequestMethod.POST) 
	   public String check(@RequestBody ArrayList<PayDTO> dtos, HttpSession session) {
	   
			System.out.println("submitCheck.do >>>>>> check()");
			System.out.println("submitCheck.do >>>>>> dtos"+dtos);
			
			//세션에 체크라는 이름으로 담아 둠 
			session.setAttribute("check", dtos);
	      
			//성공이라고 ajax의 result 값으로 던져줌
			return "success";
	   }//comment() end
	   
	   @ResponseBody
	   @RequestMapping(value = "checkTime.do", method = RequestMethod.POST) 
	   public ArrayList<CheckDTO> checkTime(@RequestBody CheckDTO dto, HttpSession session) {
	   
			System.out.println("checkTime.do >>>>>> check()");
			System.out.println("checkTime.do >>>>>> dto : "+ dto);
			
			ArrayList<CheckDTO> result = new ArrayList<CheckDTO>();
			result = dao.checkTime(dto);
	      
			return result;
	   }//comment() end
		
		
}//class end
