package kr.co.symphony.lessonreg;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.symphony.notice.NoticeDTO;
import kr.co.symphony.review.ReviewDTO;
import net.utility.UploadSaveManager;

@Controller
public class RegCont {
	
	private RegDAO dao = null;
	
	public RegCont() {
		dao = new RegDAO();
		System.out.println("------RegCont() 객체 생성됨");		
	}
	
	@RequestMapping(value = "lessoncreate.do", method = RequestMethod.GET)
	public ModelAndView createForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("lesson/classreg");
		
		return mav;
	}
	
	@RequestMapping(value = "lessoncreate.do", method = RequestMethod.POST) 
	public ModelAndView createProc(@ModelAttribute RegDTO dto, HttpServletRequest req, HttpSession session) {
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("lesson/msgView"); 	
		
		// 파일 저장 폴더의 실제 물리적 경로 가져오기
		String basePath=req.getRealPath("/storage");
		
		// 1) <input type="file" name="posterMF" size="50">
		MultipartFile prof_photoMF = dto.getProf_photoMF(); // 파일 가져오기
		// /storage 폴더에 파일 저장하고, rename된 파일명 반환
		String prof_photo = UploadSaveManager.saveFileSpring30(prof_photoMF, basePath);
		dto.setProf_photo(prof_photo); // rename된 파일명을 dto 객체 담기
		
		String id = (String)session.getAttribute("s_id");
		dto.setId(id);
	
		int cnt=dao.create(dto);						
		
		if(cnt==0) {
			String msg="글쓰기에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessoncreate.do" );	
	
			}else {
			String msg="글쓰기에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessonlist.do" );
		}//if end
		return mav;	
	}//create() end
	
	
	@RequestMapping("lessonlist.do")
	public ModelAndView list() {

		ModelAndView mav=new ModelAndView();
        mav.setViewName("lesson/lessonList");

        return mav;
	}// list() end
	
	
	@RequestMapping(value = "lessondetail.do", method = RequestMethod.GET)	
	public ModelAndView lessondetailForm(@ModelAttribute RegDTO dto) {
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("lesson/lessonDetail");
		mav.addObject("r_detail", dao.r_detail(dto));
		mav.addObject("count", dao.count(dto));
		
		return mav;
		
	}//detailForm() end
	
	
	
	@RequestMapping(value = "lessondelete.do", method = RequestMethod.GET)
	public ModelAndView deleteProc(@ModelAttribute RegDTO dto, int c_id, HttpServletRequest req) {
		

		ModelAndView mav=new ModelAndView();
		mav.setViewName("lesson/msgView"); 	
		
		// 삭제하고자 하는 글정보 가져오기 (/storage 폴더에서 삭제할 파일명을 확인하기 위해)
		RegDTO oldDTO = dao.r_detail(dto);
	
		int cnt=dao.delete(c_id);						
		
		if(cnt==0) {
			String msg="강의 삭제에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessondetail.do" );	

			}else {
			String msg="강의 삭제에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessonlist.do" );
			
			String basePath=req.getRealPath("/storage");
			UploadSaveManager.deleteFile(basePath, oldDTO.getProf_photo());
		
			}//if end
		return mav;	
	}//deleteProc() end
	
	
	@RequestMapping(value = "lessonupdateform.do", method = RequestMethod.GET)
	public ModelAndView updateForm(@ModelAttribute RegDTO dto) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("lesson/lessonUpdate");
		dto = dao.r_detail(dto);
		mav.addObject("dto", dto); // DB에서 수정할 행 가져오기
		
		return mav;
	}
	
	
	@RequestMapping(value = "lessonupdate.do", method = RequestMethod.POST)
	public ModelAndView updateProc(@ModelAttribute RegDTO dto, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("lesson/msgView");
		
		String basePath = req.getRealPath("/storage");
		RegDTO oldDTO = dao.r_detail(dto); // 기존에 저장된 정보 가져오기
		
		// 파일 수정할 것인지?

		// 1)
		MultipartFile prof_photoMF = dto.getProf_photoMF();
		if (prof_photoMF.getSize() > 0) { // 새로운 포스터 파일이 첨부되어 전송되었는지?
			UploadSaveManager.deleteFile(basePath, oldDTO.getProf_photo()); // 기존에 저장되어 있는 파일 삭제
			String prof_photo = UploadSaveManager.saveFileSpring30(prof_photoMF, basePath); // 신규로 전송된 파일 저장
			dto.setProf_photo(prof_photo); // 새롭게 첨부된 신규 파일명

		} else { // 포스터 파일은 수정하지 않을 경우
			dto.setProf_photo(oldDTO.getProf_photo()); // 기존에 저장된 파일명
		}
		
		
		int cnt=dao.update(dto);
		if(cnt==0) {
			String msg="공지사항 수정에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessonupdateform.do" );	
	
			}else {
			String msg="공지사항 수정에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessonlist.do" );
		}//if end
		
		return mav;
	} // updateProc end
	
	
}



