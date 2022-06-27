package com.korea.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.AdminDAO;

@Controller
public class AdminController {
	private static final String VIEW_PATH = "/WEB-INF/views/";
	
	@Autowired
	AdminDAO admin_dao;
	
	@RequestMapping(value = { "/", "/main.do" }) // 시작페이지
	public String main() {

		return "/WEB-INF/views/main.jsp";
	}

}
