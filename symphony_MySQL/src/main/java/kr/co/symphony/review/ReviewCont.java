package kr.co.symphony.review;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.utility.UploadSaveManager;

@Controller
public class ReviewCont {
	
	private ReviewDAO dao=null;
	
	public ReviewCont() {
	
		dao=new ReviewDAO();
		
		System.out.println("----ReviewCont() 객체 생성됨");
	}//end
	
	@RequestMapping(value = "reviewCreate.do", method = RequestMethod.GET)
	public String createForm() {
		
	
		return "board/reviewCreate";		
	}//createForm() end
	
	
	@RequestMapping(value = "reviewCreate.do", method = RequestMethod.POST)
	public ModelAndView createProc(@ModelAttribute ReviewDTO dto, HttpServletRequest req, HttpSession session) {
	
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView");

		String basePath=req.getRealPath("/storage");
		
		MultipartFile filenameMF=dto.getFilenameMF();
		String wPicPath=UploadSaveManager.saveFileSpring30(filenameMF, basePath);
		String wPic = filenameMF.getOriginalFilename();
		
		System.out.println(filenameMF);
		System.out.println(filenameMF.getOriginalFilename());
		
		String id = (String)session.getAttribute("s_id");
		dto.setId(id);
		
		dto.setwPicPath(wPicPath);
		dto.setwPic(wPic);
		
		int cnt=dao.create(dto);
		
		if(cnt==0) {
		
			String msg="수강후기 글쓰기에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewCreate.do" );	
	
		}else {
		
			String msg="수강후기 글쓰기에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewList.do" );
		
		}//if end
		
		return mav;	
	}//createProc() end
	
	
	@RequestMapping("reviewList.do")
    public ModelAndView list() {

        ModelAndView mav=new ModelAndView();
        mav.setViewName("board/reviewList");

        return mav;
    }//list() end
    


	@RequestMapping(value = "reviewDetail.do", method = RequestMethod.GET)	
	public ModelAndView detailForm(@ModelAttribute ReviewDTO dto) {
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/reviewDetail");
		mav.addObject("count", dao.count(dto));
		mav.addObject("detail", dao.detail(dto));
		
		return mav;
		
	}//detailForm() end
	

	@RequestMapping(value = "reviewDelete.do", method = RequestMethod.GET)
	public ModelAndView deleteProc(@ModelAttribute ReviewDTO dto, int wNum, HttpServletRequest req) {
	
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		ReviewDTO oldDTO=dao.detail(dto);
		
		int cnt=dao.delete(wNum);						
		
		if(cnt==0) {
			String msg="수강후기 삭제에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewDetail.do" );	
	
			}else {
			String msg="수강후기 삭제에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewList.do" );
			
			String basePath=req.getRealPath("/storage");
			UploadSaveManager.deleteFile(basePath, oldDTO.getwPicPath());
		
			}//if end
		return mav;	
	}//deleteProc() end
	
	@RequestMapping(value = "reviewUpdateForm.do", method = RequestMethod.GET)	
	public ModelAndView updateForm(@ModelAttribute ReviewDTO dto) {
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/reviewUpdate");
		mav.addObject("update", dao.detail(dto));
		
		return mav;
		
	}//updateForm() end
	
	@Transactional
	@RequestMapping(value = "reviewUpdate.do", method = RequestMethod.POST)
	public ModelAndView updateProc(@ModelAttribute ReviewDTO dto, HttpServletRequest req) {
		
		String basePath=req.getRealPath("/storage");
	
		ModelAndView mav=new ModelAndView();
		mav.setViewName("board/msgView"); 	
	
		MultipartFile filenameMF = dto.getFilenameMF();
		String wPic = filenameMF.getOriginalFilename();
		
		if(wPic != null && !wPic.equals("")) {
			String wPicPath=UploadSaveManager.saveFileSpring30(filenameMF, basePath);//신규로 전송된 파일 저장
			UploadSaveManager.deleteFile(basePath, dto.getwPicPath()); //기존에 저장되어 있는 파일 삭제
			
			dto.setwPicPath(wPicPath);
			dto.setwPic(wPic);//새롭게 첨부된 신규 파일명
	
		}
		
		int cnt=dao.update(dto);						
		
		if(cnt==0) {
			String msg="공지사항 수정에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewUpdateForm.do" );	
	
			}else {
			String msg="공지사항 수정에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/reviewList.do" );
		}//if end
		return mav;	
	}//updateProc() end
	

	@GetMapping("ajax")
	public String ajax() {
		System.out.println("ajax 실행!");
		return "ajax";
	}
	
	static int cnt=0;
	
	@GetMapping("ajax_result")
	@ResponseBody
	public String ajaxResult() {
		return ++cnt+"";//숫자를 문자화함
	}


	@ResponseBody
	@RequestMapping(value = "checkLike.do")	
	public LikeDTO checkLike(@RequestBody LikeDTO dto, HttpSession session) {
		
		System.out.println("checkLike()");
		
		String s_id = (String) session.getAttribute("s_id");
		LikeDTO result = new LikeDTO();
		
		if(s_id != null && !s_id.equals("")) {
			
			dto.setId(s_id);
			result = dao.checkLike(dto);
		}
		
		return result;
		
	}//checkLike() end

	//좋아요
	@Transactional
	@ResponseBody
	@RequestMapping(value = "like.do")	
	public String like(@RequestBody LikeDTO dto, HttpSession session) {
		
		System.out.println("like()");
		
		String s_id = (String) session.getAttribute("s_id");
		
		if(s_id != null && !s_id.equals("")) {
			
			dto.setId(s_id);
			dao.like(dto);
			dao.wLike(dto);
		}
		
		return "success";

	}//like() end
	
	@ResponseBody
	@RequestMapping(value = "likeList.do")	
	public ArrayList<ReviewDTO> likeList() {
		
		System.out.println("likeList()");

		ArrayList<ReviewDTO> list = new ArrayList<ReviewDTO>();
		list = dao.likeList();
		
		return list;
		
	}//likeList() end

}//class end
