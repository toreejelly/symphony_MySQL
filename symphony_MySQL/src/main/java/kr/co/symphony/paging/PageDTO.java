package kr.co.symphony.paging;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageDTO {
    private int startPage, endPage, total, nowPage, amount;
    private boolean prev, next;
   
    public PageDTO() {
    	
    }

	public PageDTO(int nowPage, int total,int amount) {
    	this.nowPage = nowPage; 
	    this.amount = amount;
        this.total = total;
      
        this.endPage = (int)(Math.ceil(nowPage / 5.0)) * 5; 
        this.startPage = this.endPage - 4;
      
        int realEnd = (int)(Math.ceil((total * 1.0) / amount));
        if(realEnd <= endPage) { 
           this.endPage = realEnd;
        }
      
        this.prev = this.startPage > 1;
        this.next = realEnd > this.endPage;
        
        System.out.println("realEnd :"+realEnd);
   }
   
   public int getStartPage() {
	   return startPage;
   }
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getTotal() {
		return total;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}
	
	public int getNowPage() {
		return nowPage;
	}
	
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	
	public int getAmount() {
		return amount;
	}
	
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public void setNext(boolean next) {
		this.next = next;
	}

	public String makeQuery(int page) {
      
		UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("nowPage", page).queryParam("amount", amount).build();

      return uriComponentsBuilder.toString();
   }
	
    @Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", total=" + total + ", nowPage=" + nowPage
				+ ", amount=" + amount + ", prev=" + prev + ", next=" + next + "]";
	}
   
}