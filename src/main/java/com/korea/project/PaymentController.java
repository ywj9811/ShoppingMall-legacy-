package com.korea.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import dao.PaymentDAO;

@Controller
public class PaymentController {
	
	@Autowired
	PaymentDAO payment_dao;
	

}
