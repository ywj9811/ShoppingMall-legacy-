package com.korea.project;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ReplyDAO;
import vo.ReplyVO;
import vo.UserVO;

@Controller
public class ReplyController {
	
	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;
	
	@Autowired
	ReplyDAO reply_dao;
	
	private static final String VIEW_PATH = "/WEB-INF/views/";
	
	@RequestMapping(value = "p_reply.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String replyinsert(int p_info_dcode, String content, int payment_code) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		String ip = request.getRemoteAddr();

		ReplyVO vo = new ReplyVO();
		vo.setP_info_dcode(p_info_dcode);
		vo.setReply_content(content);
		vo.setUser_code(uvo.getUser_code());
		vo.setReply_ip(ip);
		vo.setPayment_code(payment_code);
		
		reply_dao.reply_insert(vo);
		
		String resultStr = "";
		//resultStr = String.format("[{'param':'%s'}]", "작성되었습니다");
		
		return resultStr;

	}
}
