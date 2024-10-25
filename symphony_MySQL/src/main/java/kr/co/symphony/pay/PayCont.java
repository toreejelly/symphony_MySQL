package kr.co.symphony.pay;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PayCont {
	
private PayDAO dao = null;
	
	public PayCont() {
		
		dao = new PayDAO();
		System.out.println("------PayCont() 객체 생성됨");		
	}
	
	@RequestMapping(value = "cartproc.do", method = RequestMethod.POST) 
	public ModelAndView cartProc(@ModelAttribute PayDTO dto) {

		ModelAndView mav=new ModelAndView();
		mav.setViewName("pay/msgView"); 	
	
		int cnt=dao.create(dto);						
		
		if(cnt==0) {
			String msg="장바구니에 실패했습니다.";		
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/lessondetail.do" );	
	
			}else {
			String msg="글쓰기에 성공했습니다.";
			
			mav.addObject("msg", msg );
			mav.addObject("url", "/cart.do" );
		}//if end
		return mav;	
	}//create() end
	
	//장바구니 페이지
	@RequestMapping("cart.do")
	public ModelAndView list(HttpSession session) {
		
		System.out.println("cart.do >>>>> list()");
		
		ModelAndView mav = new ModelAndView();
		
		//노란줄 생기는 부분 노란줄 없애는 주석.
		@SuppressWarnings("unchecked")
		//세션에 담아둔 데이터 가져옴.
		ArrayList<PayDTO> items = (ArrayList<PayDTO>) session.getAttribute("check");
		
		if(items != null) {
			
			ArrayList<PayDTO> list = new ArrayList<PayDTO>(); 
			
			for(int i = 0; i < items.size(); i++) {
				
				PayDTO pay = new PayDTO();
				pay.setC_id(items.get(i).getC_id());
				pay.setC_title(items.get(i).getC_title());
				pay.setC_time(items.get(i).getC_time());
				pay.setC_date(items.get(i).getC_date());
				pay.setPrice(items.get(i).getPrice());
				pay.setName(dao.name(items.get(i).getC_id()));
				
				list.add(pay);
				
			}
			
			mav.addObject("list", list);
			
		}
		
		mav.setViewName("payment/cart");

		return mav;
	}// list() end
	
	//주문
	@Transactional
	@RequestMapping(value = "pay.do", method = RequestMethod.POST) 
	public ModelAndView pay(@ModelAttribute PayListDTO dtos, HttpSession session) {
		
		System.out.println("pay.do >>>>> pay() >>>>> dtos " + dtos.toString());
		
		ModelAndView mav = new ModelAndView();
		
		String id = (String) session.getAttribute("s_id");
		
		if(id != null) {//세션에서 아이디 확인
			if(dtos != null)  {
				ArrayList <PayDTO> newDtos = dtos.getDtos();
				
				if(newDtos != null) {
					
					PayDTO dto = newDtos.get(0);//newDtos에서 첫번째 배열가지고 옴
					int pay = dto.getPrice() * newDtos.size();//총 금액
					
					PaymentDTO payment = new PaymentDTO();
					payment.setC_id(dto.getC_id());	//강의 아이디
					payment.setId(id);				//구매자 아이디
					payment.settPay(pay);			//총 금액
					
					int resultPayment = dao.insPayment(payment);//payment테이블에 insert 한 것 되었는지 확인
					
					if(resultPayment != 0) {
						int maxOderId = dao.maxOderId();//위에 insert 됐었을 때 oder_Id를 가져옴. 가져와서 payDetail 테이블에 넣어야 하기 때문이다.
						
						dao.insPayDetail(newDtos,maxOderId);
					}
					
					mav.addObject("list", newDtos);
					mav.setViewName("payment/paydetail");//결제 상세 페이지
				}else {
					mav.setViewName("redirect:cart.do");//장바구니 페이지
				}
			}
		}else {
			mav.setViewName("redirect:loginform.do");
		}

		return mav;	
	}//pay() end
	
}
