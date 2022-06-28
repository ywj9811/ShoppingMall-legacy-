package com.korea.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import dao.ReplyDAO;
import vo.CartVO;
import vo.P_detailVO;
import vo.P_infoVO;
import vo.Reply_ViewsVO;
import vo.UserVO;

@Controller
public class P_infoController {
	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;
	
	private static final String VIEW_PATH = "/WEB-INF/views/";
	
	@Autowired
	P_infoDAO p_info_dao;
	@Autowired
	P_detailDAO p_detail_dao;
	@Autowired
	CartDAO cart_dao;
	@Autowired
	ReplyDAO reply_dao;
	
	@RequestMapping(value = { "/search1.do" }) // 검색완료 페이지
	public String list(Model model, String search) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);

		List<P_infoVO> list = p_info_dao.search(map);
		model.addAttribute("list", list);

		return VIEW_PATH + "search.jsp";
	}

	@RequestMapping(value = { "/search.do" }) // 검색 페이지
	public String list() {
		return VIEW_PATH + "search.jsp";
	}

	@RequestMapping(value = { "/p_info.do" }) // 상품 정보 페이지
	public String p_info(int p_info_code, Model model) {
		
		P_infoVO p_infoVO = p_info_dao.p_info(p_info_code);
		
		Map<String, List<String>> map = p_detail_dao.p_dinfo(p_info_code);
		
		List<String> size = map.get("size");
		List<String> color = map.get("color");

		List<Reply_ViewsVO> list = reply_dao.reply(p_info_code);
		
		
		model.addAttribute("vo", p_infoVO);
		model.addAttribute("size", size);
		model.addAttribute("color", color);
		model.addAttribute("list", list);

		return "/WEB-INF/views/p_info/p_info.jsp";
	}

	@RequestMapping("/addcart.do")
	@ResponseBody
	public String addcart(int p_info_code, String sizebox, String colorbox) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		
		P_detailVO pvo = new P_detailVO();
		pvo.setP_detail_color(colorbox);
		pvo.setP_detail_size(sizebox);
		pvo.setP_info_code(p_info_code);
		
		pvo = p_detail_dao.selectvo(pvo);
		pvo.setUser_code(uvo.getUser_code());
		
		int ok = 1; //상품이 존재하는지 확인
		
		CartVO cvo = new CartVO();
		if(cart_dao.cart_count(uvo.getUser_code()) > 0) {
			List<CartVO> c_list = cart_dao.select(uvo.getUser_code());
			for(int i = 0; i < c_list.size(); i++) {
				if(c_list.get(i).getP_info_dcode() == pvo.getP_info_dcode()) {
					ok = 0;
					cvo = c_list.get(i);
					break;
				}
			}
		}
		if(ok == 1) {
			cart_dao.cartplus(pvo);
		}else {
			cart_dao.plus(cvo);
		}

		return "";
	}
	
	@RequestMapping("p_list.do")
	public String p_list(String ltype, String mtype, Model model) {
		P_infoVO vo = new P_infoVO();
		vo.setP_info_lType(ltype);
		vo.setP_info_mType(mtype);
		List<P_infoVO> list = p_info_dao.p_list(vo);
		model.addAttribute("list", list);
		return VIEW_PATH + "list.jsp";
	}
	@RequestMapping("today.do")
	public String today(String ltype, Model model) {
		P_infoVO vo = new P_infoVO();
		vo.setP_info_lType(ltype);
		List<P_infoVO> list = p_info_dao.today_list(vo);
		model.addAttribute("list", list);
		return VIEW_PATH + "list.jsp";
	}
}