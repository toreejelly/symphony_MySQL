package kr.co.symphony.member;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ScriptUtils {
	
	public static void init(HttpServletResponse res) {
		res.setContentType("text/html; charset=UTF-8");
		res.setCharacterEncoding("UTF-8");
	}
	
	public static void alert(HttpServletResponse res, String alertText) throws IOException {
		init(res);
		PrintWriter out = res.getWriter();
		out.println("<script>('" + alertText + "');</script>");
		out.flush();
	}
	
	public static void alertAndMovePage(HttpServletResponse res, String alertText, String nextPage) throws IOException {
		init(res);
		PrintWriter out = res.getWriter();
		out.println("<script>('" + alertText + "'); location.href='" + nextPage + "';</script>");
		out.flush();
	}
	
	public static void alertAndBackPage(HttpServletResponse res, String alertText) throws IOException {
		init(res);
		PrintWriter out = res.getWriter();
		out.println("<script>('" + alertText + "'); history.go(-1);</script>");
		out.flush();
	}

}
