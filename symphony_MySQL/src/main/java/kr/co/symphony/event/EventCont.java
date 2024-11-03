
package kr.co.symphony.event;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.symphony.paging.PageDTO;


@Controller
public class EventCont {


	EventDAO dao=null;
	
	public EventCont() {
		
		dao=new EventDAO();
		
		System.out.println("----EventCont() 객체 생성됨");
	}//end
	
	
	@RequestMapping(value = "eventCreate.do", method = RequestMethod.GET)	
	
	public String eventForm() {
		System.out.println("eventForm");
	
		return "board/eventCreate";  
	}//eventForm() end

	
	@RequestMapping(value = "eventCreate.do", method = RequestMethod.POST) 

	public ModelAndView eventProc(@ModelAttribute EventDTO dto, HttpSession session) {
	

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
		
		String id = (String)session.getAttribute("s_id");
		dto.setId(id);
	
		int cnt=dao.create(dto);						
		
		if(cnt==0) {
			String msg="글쓰기에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventCreate.do" );	
	
		}else {
			String msg="글쓰기에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventList.do" );
		
		}//if end
		
		return mav;		
	}//evnetProc() end

	
	@RequestMapping("eventList.do")
    public ModelAndView list() {

        ModelAndView mav=new ModelAndView();
        mav.setViewName("board/eventList");

        return mav;
    }//list() end

	
	@RequestMapping(value = "eventDetail.do", method = RequestMethod.GET)	//createForm을 post로 보냈는데 
	
	public ModelAndView detailForm(@ModelAttribute EventDTO dto) {
		
		System.out.println("detailForm()");
		System.out.println("번호"+dto.getwNum());
		
		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("board/eventDetail");
		mav.addObject("count", dao.count(dto));
		mav.addObject("detail", dao.detail(dto));
		
		return mav;
	}//detailForm() end..
	
	@RequestMapping(value = "eventDelete.do", method = RequestMethod.GET)
	public ModelAndView deleteProc(int wNum) {
		System.out.println("eventDelete.do >>>>>> deleteProc");
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		int cnt=dao.delete(wNum);						
		
		if(cnt==0) {
			String msg="이벤트 삭제에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventDetail.do" );	
	
			}else {
			String msg="이벤트 삭제에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventList.do" );
		}//if end
		return mav;	
	}//deleteProc() end
	
	@RequestMapping(value = "eventUpdateForm.do", method = RequestMethod.GET)	
	public ModelAndView updateForm(@ModelAttribute EventDTO dto) {
		
		System.out.println("eventupdateForm()");
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/eventUpdate");
		mav.addObject("update", dao.detail(dto));
		
		return mav;
		
	}//updateForm() end
	
	
	@RequestMapping(value = "eventUpdate.do", method = RequestMethod.GET)
	public ModelAndView updateProc(@ModelAttribute EventDTO dto) {
		System.out.println("eventUpdate.do >>>>>> eventProc");
		System.out.println("제목:" + dto.getwTitle());
		System.out.println("내용:" + dto.getwText());
		
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		int cnt=dao.update(dto);						
		
		if(cnt==0) {
			String msg="공지사항 수정에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventUpdateForm.do" );	
	
			}else {
			String msg="공지사항 수정에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/eventList.do" );
		}//if end
		return mav;	
	}//updateProc() end
	
}//class end

