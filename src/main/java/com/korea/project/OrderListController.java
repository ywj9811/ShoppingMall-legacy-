package com.korea.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import dao.OrderListDAO;

@Controller
public class OrderListController {
	@Autowired
	OrderListDAO orderlist_dao;
	
}
