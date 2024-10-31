package kr.co.symphony.notice;

import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;



import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.symphony.paging.PageDTO;


@Controller
public class NoticeCont {

	NoticeDAO dao = null;
	
	public NoticeCont() {
		
		dao = new NoticeDAO();
		
		System.out.println("----NoticeCont() 객체 생성됨");
	}//end
	
	@RequestMapping(value = "noticeCreate.do", method = RequestMethod.GET)	
	public String createForm() {	
		System.out.println("noticeCreate.do >>>>>> createForm");
		
		return "board/noticeCreate";  
	}//createForm() end.


	@RequestMapping(value = "noticeCreate.do", method = RequestMethod.POST) 
	public ModelAndView createProc(@ModelAttribute NoticeDTO dto, HttpSession session) {
		
		System.out.println("noticeCreate.do >>>>>> createProc");
		System.out.println("제목"+dto.getwTitle());
		System.out.println("내용"+dto.getwText());

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
		
		String id = (String)session.getAttribute("s_id");
		dto.setId(id);
	
		int cnt=dao.create(dto);						
		
		if(cnt==0) {
			String msg="글쓰기에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeCreate.do" );	
	
			}else {
			String msg="글쓰기에 성공했습니다..";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeList.do" );
		}//if end
		return mav;	
	}//create() end
	
	
	@RequestMapping("noticeList.do")
    public ModelAndView list() {

        ModelAndView mav=new ModelAndView();
        mav.setViewName("board/noticeList");

        return mav;
    }//list() end.

	@RequestMapping(value = "noticeDetail.do", method = RequestMethod.GET)	
	public ModelAndView detailForm(@ModelAttribute NoticeDTO dto) {
		
		System.out.println("detailForm()");
		System.out.println("번호"+dto.getwNum());
		System.out.println("번호"+dto.getwViews());
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/noticeDetail");
		mav.addObject("count", dao.count(dto));
		mav.addObject("detail", dao.detail(dto));
		
		
		return mav;
		
	}//detailForm() end..

	
	
	@RequestMapping(value = "noticeDelete.do", method = RequestMethod.GET)
	public ModelAndView deleteProc(int wNum) {
		System.out.println("noticeDelete.do >>>>>> deleteProc");
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		int cnt=dao.delete(wNum);						
		
		if(cnt==0) {
			String msg="공지사항 삭제에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeDetail.do" );	
	
			}else {
			String msg="공지사항 삭제에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeList.do" );
		}//if end
		return mav;	
	}//deleteProc() end
	
	
	@RequestMapping(value = "noticeUpdateForm.do", method = RequestMethod.GET)	
	public ModelAndView updateForm(@ModelAttribute NoticeDTO dto) {
		
		System.out.println("noticeupdateForm()");
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/noticeUpdate");
		mav.addObject("update", dao.detail(dto));
		
		return mav;
		
	}//updateForm() end
	
	
	@RequestMapping(value = "noticeUpdate.do", method = RequestMethod.GET)
	public ModelAndView updateProc(@ModelAttribute NoticeDTO dto) {
		System.out.println("noticeUpdate.do >>>>>> updateProc");
		System.out.println("제목:" + dto.getwTitle());
		System.out.println("내용:" + dto.getwText());
		
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		int cnt=dao.update(dto);						
		
		if(cnt==0) {
			String msg="공지사항 수정에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeUpdateForm.do" );	
	
			}else {
			String msg="공지사항 수정에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/noticeList.do" );
		}//if end
		return mav;	
	}//updateProc() end
	
}//class end