package com.korea.project;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderListDAO;
import dao.P_detailDAO;
import dao.PaymentDAO;
import dao.UserDAO;
import vo.CartVO;
import vo.CartViewVo;
import vo.OrderListVO;
import vo.OrderVO;
import vo.PaymentVO;
import vo.UserVO;

@Controller
public class OrderController {
	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;
	
	private static final String VIEW_PATH = "/WEB-INF/views/";
	
	@Autowired
	OrderDAO order_dao;
	@Autowired
	CartDAO cart_dao;
	@Autowired
	UserDAO user_dao;
	@Autowired
	OrderListDAO orderlist_dao;
	@Autowired
	PaymentDAO payment_dao;
	@Autowired
	P_detailDAO p_detail_dao;
	
	//session을 어고, 세션에 저장되어있는 user를 가져와서 코드를 받자. user_code
	//해당 코드의 장바구니를 가져와서 p_info_dcode를 통해서 상품 정보를 읽고 ordertbl(구매정보)에 상품 상세코드와 수량, user_code, user_class를 넣는다.
	//그리고 나머지 주문일 수령자 연락처 등등은 입력을 통해서 받아서 넣어주기 : 이것은 dao에서 vo에 저장하고 for문을 돌리면서 vo를 불러서 계쏙 저장하는 식으로 사용하자.(중복되는 정보니까)
	@RequestMapping("/c_order.do") //장바구니를 통해서 들어가는 경우
	public String c_order(int total, Model model) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}
		
		int user_code = uvo.getUser_code();
		//세션에서 받았다고 가정
		int count = 0;
		
		List<CartVO> cart_list = cart_dao.select(user_code);
		List<CartViewVo> view_list = new ArrayList<CartViewVo>();
		
		CartViewVo cart_view = new CartViewVo();
		
		for(int i = 0; i < cart_list.size(); i++) {
			cart_view = cart_dao.selectview(cart_list.get(i).getP_info_dcode());
			view_list.add(cart_view);
			count += cart_list.get(i).getCart_cnt();
		}
		
		
		model.addAttribute("view_list", view_list);
		model.addAttribute("count", count);
		model.addAttribute("total", total);
		return VIEW_PATH + "order/pay.jsp";
	}
	
	@RequestMapping("/payfin.do")
	public String payfin(Model model, int total, int count, String name, String address, String detail, String tel, String want) {
		
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}
		//total은 총 결제 금액이 넘어오는 것이다.
		//회원 누적결제금액에 추가 현재 총 결제금액 추가.
		////////////////////////////////////////////////////////////
		int user_code = uvo.getUser_code(); //세션 들어오면 수정/////////////////////////////////////
		long date = new Date().getTime();
		
		//sysdate로는 부족하니 초단위로 나오게 되는 함수를 사용함. 그러면 number를 사용해야함
		//헌데, default로 sysdate설정되어잇어 아예 변경하도록
		OrderVO ovo = new OrderVO();		
		ovo.setOrder_addr(address+"/"+detail);
		ovo.setOrder_detail(want);
		ovo.setOrder_name(name);
		ovo.setOrder_tel(tel);		
		ovo.setOrder_regdate(date);
		ovo.setUser_code(user_code);
		ovo.setOrder_total(total);
		ovo.setOrder_cnt(count);
		order_dao.insert(ovo);
		
		OrderVO ovo2 = order_dao.selectvo(ovo);
		int order_code = ovo2.getOrder_code();
		
		PaymentVO pvo = new PaymentVO();
		pvo.setOrder_code(order_code);
		pvo.setPayment_pay(total);
		pvo.setPayment_type("card");
		payment_dao.insert(pvo);
		
		PaymentVO pvo2 = payment_dao.selectvo(pvo);
		int payment_code = pvo2.getPayment_code();
		
		OrderListVO olvo = new OrderListVO();
		olvo.setOrder_code(order_code);
		olvo.setPayment_code(payment_code);
		olvo.setUser_code(user_code);
		
		CartViewVo viewvo = new CartViewVo();
		List<CartViewVo> cart_view = new ArrayList<CartViewVo>();
		List<CartVO> cart_list = cart_dao.select(user_code);

		for(int i = 0; i < cart_list.size(); i++) {
			int p_info_dcode = cart_list.get(i).getP_info_dcode();
			int cnt = cart_list.get(i).getCart_cnt();
			olvo.setP_info_dcode(p_info_dcode);
			olvo.setOrderList_cnt(cnt);
			orderlist_dao.insert(olvo);
			
			viewvo = cart_dao.selectview(p_info_dcode);
			cart_view.add(viewvo);

			//상품정보 판매량을 올려야함
			p_detail_dao.cellplus(p_info_dcode);
		}		
		
		user_dao.total(ovo);
		
		UserVO vo = user_dao.uservo(user_code);
		
		session.removeAttribute("vo");
		
		
		user_dao.classup(vo);
		
		cart_dao.deleteAll(user_code);
		
		session.setMaxInactiveInterval(60 * 60); //세션이 1시간 유지
		session.setAttribute("vo", vo);
		
		model.addAttribute("list", cart_view);
		//세션의 유저의 order_
		return VIEW_PATH + "order/payfin.jsp";
	}
}
