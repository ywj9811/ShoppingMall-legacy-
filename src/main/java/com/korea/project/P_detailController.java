package com.korea.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import dao.P_detailDAO;

@Controller
public class P_detailController {
	@Autowired
	P_detailDAO p_detailDAO;

}
