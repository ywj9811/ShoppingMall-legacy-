package com.korea.project;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CartDAO;
import dao.P_detailDAO;
import dao.P_infoDAO;
import dao.UserDAO;
import vo.CartVO;
import vo.CartViewVo;
import vo.UserVO;

@Controller
public class CartController {

	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;
	
	private static final String VIEW_PATH = "/WEB-INF/views/";
	@Autowired
	CartDAO cart_dao;
	@Autowired
	P_infoDAO p_info_dao;
	@Autowired
	UserDAO user_dao;
	@Autowired
	P_detailDAO p_detail_dao;
	
	@RequestMapping("cart.do")
	public String cart_main(Model model) {
		int total = 0;
		
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}
		
		List<CartVO> need = new ArrayList<CartVO>();
		need = cart_dao.select(uvo.getUser_code());
		// cart_dao에서 해당 user_code와 일치하는 애들을 조회하겠다(장바구니 리스트) -> 나중에는 세션 사용해야함
		// 장바구니 코드, 상품코드, 유저 코드, 수량을 읽어서 리스트 형태로 반환해서 need에 저장함.
		// 이것을 이용해서 상품가격 * 수량을 계속해서 더해준다.
		// need에는 p_info_dcode가 들어있음 이것을 이용해서 p_info로 접근해서 p_info_price를 받아야함

		List<CartViewVo> view_list = new ArrayList<CartViewVo>();

		CartViewVo view;
		
		for (int i = 0; i < need.size(); i++) {
			view = cart_dao.selectview(need.get(i).getP_info_dcode());
			view_list.add(view);

			total = total + view.getP_info_price() * (need.get(i).getCart_cnt());
			// totalm.add(total);
		}

		// 할인도 따져봐야 함.
		// 로그인을 하면 세션에 회원정보가 저장되어 있을것 따라서 세션에서 가져다가 쓰면 됨
		int user_code = uvo.getUser_code(); // 임시용으로 1로 지정하자
		int user_class = user_dao.user_class(user_code);

		float sail = total * (user_class * 10 / 100f); //여기서 그냥 유저세션에서 가져다가 사용하면 된다.
		int sailtotal = (int) (total - sail);
		
		model.addAttribute("view_list", view_list);
		//view를 바인딩
		model.addAttribute("need", need);
		// 장바구니 테이블을 바인딩
		model.addAttribute("total", total);
		// total은 총 가격
		model.addAttribute("sail", (int) sail);
		// 할인액
		model.addAttribute("sailtotal", sailtotal);
		// 할인받은 최종 가격

		return VIEW_PATH + "cart/cart.jsp";
	}

	// 장바구니에 상품 코드와 구매 수량이 담겨있다.
	// plus를 누르게 되면,
	@RequestMapping(value = "/plus.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String plus(String cnt, int info) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		// info로 상품 상세코드 넘어옴, cnt로 수량이 넘어옴 장바구니 소속.
		CartVO vo = new CartVO();
		CartViewVo cart_view = new CartViewVo();
		
		vo.setP_info_dcode(info);
		vo.setUser_code(uvo.getUser_code());
		// 여기서 1은 원래 session에 저장되어있는 user_code 사용
		cart_dao.plus(vo);

		//////////////////////////////////////////////// ajax준비시작
		String resultStr = "";

		////////////////////////////////////////////
		int total = 0;

		List<CartVO> need = new ArrayList<CartVO>();
		need = cart_dao.select(uvo.getUser_code());
		//세션에서 받아서 사용
		
		for (int i = 0; i < need.size(); i++) {
			cart_view = cart_dao.selectview(need.get(i).getP_info_dcode());
			// 이렇게 하면 해당 need리스트의 하나하나를 조회하며, 상품코드에 대한 상품 정보를 받아와서 vo에 저장 .
			total = total + cart_view.getP_info_price() * need.get(i).getCart_cnt();
		}

		// 할인도 따져봐야 함.
		int user_class = uvo.getUser_class(); //user세션에서 가져와서 사용하면 된다.
		
		float sail = total * (user_class * 10 / 100f); //아예 여기에 user세션에서 가져다가 사용하면 된다.
		int sailtotal = (int) (total - sail);
		// total은 총 가격
		/////////////////////////////////////////////////////

		resultStr = String.format("[{'param':'%s'},{'param':'%s'},{'param':'%s'}]", total, (int) sail, sailtotal);
		return resultStr;
	}

	@RequestMapping(value = "/minus.do", produces = "application/text; charset=utf8")
	@ResponseBody
	public String minus(String cnt, int info) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		// info로 상품 코드가 넘어옴, cnt로 수량이 넘어옴 장바구니 소속.
		CartVO vo = new CartVO();
		CartViewVo cart_view = new CartViewVo();

		vo.setP_info_dcode(info);
		vo.setUser_code(uvo.getUser_code());
		// 여기서 1은 원래 session에 저장되어있는 user_code 사용
		cart_dao.minus(vo);

		//////////////////////////////////////////////// ajax준비시작
		String resultStr = "";

		////////////////////////////////////////////
		int total = 0;
		
		List<CartVO> need = new ArrayList<CartVO>();
		need = cart_dao.select(uvo.getUser_code());

		for (int i = 0; i < need.size(); i++) {
			cart_view = cart_dao.selectview(need.get(i).getP_info_dcode());
			// 이렇게 하면 해당 need리스트의 하나하나를 조회하며, 상품코드에 대한 상품 정보를 받아와서 vo에 저장 .
			total = total + cart_view.getP_info_price() * need.get(i).getCart_cnt();
		}

		int user_code = uvo.getUser_code();
		int user_class = user_dao.user_class(user_code);

		float sail = total * (user_class * 10 / 100f);
		int sailtotal = (int) (total - sail);
		// total은 총 가격
		/////////////////////////////////////////////////////

		resultStr = String.format("[{'param':'%s'},{'param':'%s'},{'param':'%s'}]", total, (int) sail, sailtotal);
		return resultStr;
	}

	@RequestMapping("/delOne.do")
	public String delOne(int cnt, int info) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}
		
		// info로 p_info_code가 넘어옴 이것으로 p_detailtbl접근, p_info_dcode얻어서 장바구니에서 삭제
		System.out.println(cnt);
		System.out.println(info);
		CartViewVo cart_view = cart_dao.selectview(info);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("p_info_dcode", cart_view.getP_info_dcode());
		map.put("user_code", uvo.getUser_code()); // 회원코드도 같이 보내야함

		////
		System.out.println(map.get("p_info_dcode"));
		System.out.println(map.get("user_code"));
		////

		cart_dao.deleteOne(map);

		return "redirect:cart.do";
	}

	@RequestMapping("/delAll.do")
	public String selectdel() {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}
		
		cart_dao.deleteAll(uvo.getUser_code());

		return "redirect:cart.do";
	}

}
