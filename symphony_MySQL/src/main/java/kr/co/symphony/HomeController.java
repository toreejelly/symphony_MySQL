package kr.co.symphony;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	public HomeController() {
		System.out.println("------HomeController() 객체 생성됨");
	}
	
	// symphony프로젝트의 첫페이지 호출
	// 결과확인 http://localhost:9095/home.do

	@RequestMapping("/home.do")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("intro");

		return mav;
	}
	
}
