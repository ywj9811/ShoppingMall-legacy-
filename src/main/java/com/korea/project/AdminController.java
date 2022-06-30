package com.korea.project;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import dao.P_detailDAO;
import dao.P_infoDAO;
import dao.Sale_Status_ViewDAO;
import util.Path;
import vo.AdminVO;
import vo.P_infoVO;
import vo.Sale_Status_ViewVO;

@Controller
public class AdminController {
	private static final String VIEW_PATH = "/WEB-INF/views/";

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	@Autowired
	AdminDAO admin_dao;

	@Autowired
	P_infoDAO p_info_dao;

	@Autowired
	P_detailDAO p_detail_dao;

	@Autowired
	Sale_Status_ViewDAO sale_status_view_dao;

	// 관리자 로그인 페이지 이동
	@RequestMapping("admin_login.do" )
	public String admin_login() {

		return Path.VIEW_PATH + "admin_login.jsp";
	}

	// 관리자 계정 체크
	@RequestMapping("admin_check.do")
	@ResponseBody
	public String adminPage(String admin_id, String admin_pw) {

		String check = "no";
		AdminVO admin_vo = admin_dao.selectOne(admin_id, admin_pw);

		if (admin_vo != null) {
			session = request.getSession();
			session.setMaxInactiveInterval(60 * 60); // 세션이 1시간 유지
			session.setAttribute("admin_vo", admin_vo);
			check = "yes";
		}
		return check;
	}

	// 관리자 페이지 이동
	@RequestMapping("admin.do")
	public String admin() {

		return Path.VIEW_PATH + "admin.jsp";
	}

	// 상품 등록 페이지로 가기
	@RequestMapping("/p_insert_form.do")
	public String insert_form() {
		return Path.VIEW_PATH + "p_insert_form.jsp";
	}

	// 상품 등록 후 admin페이지로 되돌아가기
	@RequestMapping("p_insert.do")
	public String insert(Model model, P_infoVO vo, String p_detail_size, String p_detail_color) {
		p_info_dao.insert(vo);
		P_infoVO testVO = p_info_dao.selectOne(vo.getP_info_img1());

		p_detail_dao.insert(testVO.getP_info_code(), p_detail_size, p_detail_color);

		return Path.VIEW_PATH + "admin.jsp";
	}

	// 중복 게시물 체크
	@RequestMapping("p_info_check.do")
	@ResponseBody
	public String p_check(Model model, String p_info_img1) {

		P_infoVO vo = p_info_dao.selectOne(p_info_img1);
		String check = "yes";
		if (vo == null) {
			check = "no";

		}

		return check;
	}

	// 판매 현황 페이지
	@RequestMapping("p_sell_list.do")
	public String p_sell_list(Model model) {
		HashMap<String, String> map = sale_status_view_dao.selectList();
		List<Sale_Status_ViewVO> list = sale_status_view_dao.list();

		model.addAttribute("map", map);
		model.addAttribute("list", list);
		return Path.VIEW_PATH + "sale_status.jsp";

	}

	// 판매 현황 검색
	@RequestMapping("sale_search.do")
	public String sale_search(Model model, Sale_Status_ViewVO vo) {

		if (vo.getP_info_lType() == null)
			vo.setP_info_lType("");
		if (vo.getP_info_mType() == null)
			vo.setP_info_mType("");
		if (vo.getP_info_sType() == null)
			vo.setP_info_sType("");

		List<Sale_Status_ViewVO> list = sale_status_view_dao.searchList(vo);

		HashMap<String, String> map = sale_status_view_dao.selectList();

		int total_sales_view = 0;
		int total_amount_view = 0;

		for (int i = 0; i < list.size(); i++) {
			total_sales_view += list.get(i).getView_cell();
			total_amount_view += list.get(i).getProfit();
		}

		String total_sales = util.Method.math(total_sales_view);
		String total_amount = util.Method.math(total_amount_view);
		HashMap<String, String> map2 = new HashMap<String, String>();
		map.put("total_sales", total_sales);
		map.put("total_amount", total_amount);

		model.addAttribute("map", map);
		model.addAttribute("list", list);
		model.addAttribute("map2", map2);
		return Path.VIEW_PATH + "sale_status.jsp";

	}

	@RequestMapping(value = { "/", "/main.do" }) // 시작페이지
	public String main() {

		return VIEW_PATH + "main.jsp";
	}

}
