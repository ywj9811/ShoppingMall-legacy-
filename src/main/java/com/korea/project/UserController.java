package com.korea.project;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.apache.ibatis.jdbc.SQL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.CartDAO;
import dao.OrderListDAO;
import dao.ReplyDAO;
import dao.UserDAO;
import vo.CartViewVo;
import vo.OrderListVO;
import vo.ReplyVO;
import vo.Reply_ViewsVO;
import vo.UserVO;

@Controller
public class UserController {

	static final String VIEW_PATH = "/WEB-INF/views/";

	@Autowired
	ServletContext application;

	@Autowired
	HttpSession session;

	@Autowired
	HttpServletRequest request;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Autowired
	UserDAO user_dao;
	@Autowired
	ReplyDAO reply_dao;
	@Autowired
	OrderListDAO orderlist_dao;
	@Autowired
	CartDAO cart_dao;
	 
	//회원가입 페이지 이동
	@RequestMapping(value = { "/shop_join.do" })
	public String memberLogin() {
		return VIEW_PATH + "user/shop_member_join.jsp";
	}
	
	//email중복체크
	@RequestMapping("/e_check.do")
	@ResponseBody
	public String e_check(String user_email) {
		UserVO vo = user_dao.echeck(user_email);

		String data = "";

		if(vo != null) {
			data="no";
		} else {
			data="yes";
		}

		return data;
	}
	
	//email인증
	@RequestMapping(value = "/certifyEmail.do")
	@ResponseBody
	public String emailAuth(String user_email) {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		/* 이메일 보내기 */
		String setFrom = "ywj9811@naver.com";
		String toMail = user_email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호 : " + checkNum + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}


		return Integer.toString(checkNum);

	}
	@RequestMapping(value = { "/mypage.do" }) // 마이페이지 이동
	public String mypage(Model model) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}

		model.addAttribute("vo", uvo);

		return "/WEB-INF/views/user/mypage.jsp";
	}

	// 사진 첨부(프로필 사진) + jsp로 바인딩 및 포워딩  + vo에 회원가입 정보 저장
	@RequestMapping("/upload.do")
	public String upload(UserVO vo, String birth, String user_status, String user_total, String user_class, String selectEmail, String str_email02) {
		//birth형식이 ex): 2000-07-01 이런 형식으로 나오는데 -기준으로 split시킨 후 20000701(String형태)로 만들어줌.
		String b[] = birth.split("-");
		String user_birth = b[0] + b[1] + b[2];

		if(selectEmail.equals("1")) {
			selectEmail = str_email02;
		}

		String email = vo.getUser_email() + "@" +selectEmail;
		//String으로 넘어온 값들 int타입으로 바꿔줘야함.
		vo.setUser_birth(Integer.parseInt(user_birth));
		vo.setUser_status(Integer.parseInt(user_status));
		vo.setUser_total(Integer.parseInt(user_total));
		vo.setUser_class(Integer.parseInt(user_class));
		vo.setUser_email(email);

		String webPath = "/resources/upload/"; // 절대 경로
		String savePath = application.getRealPath(webPath);


		System.out.println(savePath);
		// upload된 파일의 정보
		MultipartFile user_photo = vo.getUser_photo();

		String filename = "no_file";

		if (!user_photo.isEmpty()) {
			filename = user_photo.getOriginalFilename(); // 업로드 될 실제 파일명

			File saveFile = new File(savePath, filename); // 파일을 저장할 경로

			// savePath = "c:/myupload/abc.jpg인데 경로가 없으니 폴더를 생성함."
			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				// 동일한 이름의 파일일 경우 폴더 형태로 변환이 불가하므로
				// 업로드 시간을 붙여서 이름이 중복되는 것을 방지
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			try {
				// 물리적으로 파일을 업로드 하는 코드
				user_photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // if

		vo.setUser_profile(filename);
		System.out.println("user_profile : " + vo.getUser_profile());

		// 회원가입 버튼 누를시 vo에 저장시키는 역할
		user_dao.insert(vo);
		// vo에 등록이 완료되면은, 로그인 페이지로 vo에 저장시켜 가지고 간다. //
		//response.sendRedirect("login_form.do");
		return "redirect:login.do"; //로그인 페이지

		//		return VIEW_PATH + "shop_member_info.jsp";
	}

	//id 중복체크
	@RequestMapping("/id_double_check.do")
	public String id_double_check(UserVO vo) {
		//vo.id = curr.id --> 사용가능한 id
		// " != " --> 다른 아이디 사용바람

		int res = user_dao.id_double_check(vo);

		if(res >= 1) {
			return "redirect:shop_join.do";
		} 
		return null;
	}

	//아이디 체크
	@RequestMapping("/check_id.do")
	@ResponseBody
	public String check(String user_id) {
		System.out.println("controller");
		UserVO vo = user_dao.selectOne(user_id);
		String data = "yes";

		if(vo != null) {
			System.out.println("중복아이디");
			data="no";
		}
		else {
			System.out.println("null값 넘ㅇ어옴");
		}

		return data;

	}

	//닉네임 중복체크 
	@RequestMapping("double_nick_check.do")
	@ResponseBody
	public String double_nick_check(String user_nick) {

		UserVO vo = user_dao.nickselectOne(user_nick);

		String data = "";

		if(vo != null) {
			data="no";
		} else {
			data="yes";
		}

		return data;
	}

	//login page
	@RequestMapping("/login.do")
	public String login() {
		return VIEW_PATH + "user/user_login.jsp";
	}

	@RequestMapping("/login_action.do")
	@ResponseBody
	public String main_page(String user_id, String user_pw) {

		UserVO vo = user_dao.login(user_id);

		String param = "";
		String resultStr = "";

		//vo가 null인 경우 id자체가 DB에 존재하지 않는다는 의미
		if( vo == null || vo.getUser_status() == 3 ) {
			param = "no_id";
			resultStr = String.format("[{'param':'%s'}]", param);
			return resultStr;
		}

		if( !vo.getUser_pw().equals(user_pw) ) {
			// id는 일치하지만 pwd가 일치하지 않을 때
			param = "pwd_false";
			resultStr = String.format("[{'param':'%s'}]", param);
			return resultStr;
		}

		if(vo.getUser_status() == 1) {
			param = "1";
			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(60 * 60); //세션이 1시간 유지
			session.setAttribute("nvo", vo);
			resultStr = String.format("[{'param':'%s'}]", param);
			return resultStr;
		}

		if(vo.getUser_status() == 2) {
			param = "2";
			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(60 * 60); //세션이 1시간 유지
			session.setAttribute("nvo", vo);
			resultStr = String.format("[{'param':'%s'}]", param);
			return resultStr;
		}

		//아이디와 비밀번호 체크에 문제가 없다면 session에 바인딩 할거임.
		//세션은 서버의 메모리를 사용하기 때문에 세션을 많이 사용할수록 브라우저가 느려지기 때문에
		//필요한 곳에서만 세션을 쓰도록 하자.
		user_dao.logupdate(vo);

		//세션유지시간(기본값 30분)
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60 * 60); //세션이 1시간 유지
		session.setAttribute("vo", vo);

		param = "clear";
		resultStr = String.format("[{'param':'%s'}]", param);
		return resultStr;
	}

	//////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////
	//logout page
	@RequestMapping(value = { "logout.do" })
	public String logout() {
		session.removeAttribute("vo");

		return VIEW_PATH + "main.jsp";
	}
	///////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////

	@RequestMapping(value = { "userreply.do" }) // MyPage > 구매후기 페이지로 이동
	public String userreply(Model model) {

		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}

		List<Reply_ViewsVO> list = reply_dao.user_reply(uvo.getUser_code());

		model.addAttribute("vo", uvo);
		model.addAttribute("list", list);

		return "/WEB-INF/views/user/userreply.jsp";
	}

	@RequestMapping(value = { "infochange.do" }) // MyPage > 회원 정보 변경 페이지
	public String infochange(Model model) {

		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}

		model.addAttribute("vo", uvo);

		return "/WEB-INF/views/user/infochange.jsp";
	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 프로필 사진 변경
	@RequestMapping(value = { "/c_profile.do" })
	public String c_profile(Model model, UserVO vo) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}

		String filename = "no_file";

		String webPath = "/resources/upload/"; // 절대 경로

		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);


		MultipartFile user_photo = vo.getUser_photo();

		if (!user_photo.isEmpty()) {
			filename = user_photo.getOriginalFilename(); // 업로드 될 실제 파일명

			File saveFile = new File(savePath, filename); // 파일을 저장할 경로

			// savePath = "c:/myupload/abc.jpg인데 경로가 없으니 폴더를 생성함."
			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				// 동일한 이름의 파일일 경우 폴더 형태로 변환이 불가하므로
				// 업로드 시간을 붙여서 이름이 중복되는 것을 방지
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			try {
				// 물리적으로 파일을 업로드 하는 코드
				user_photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} // if

		uvo.setUser_profile(filename);

		int list = user_dao.c_profile(uvo);

		if (list == 1) {
			session.setAttribute("vo", uvo);
		}

		return "WEB-INF/views/user/infochange.jsp";
	}


	// @@ Mypage 회원정보 변경 관련 @@ //
	// 닉네임 변경
	@RequestMapping(value = { "/c_nick.do" })
	@ResponseBody
	public String c_nick(Model model, String nick) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		HashMap<String, String> nick_map = new HashMap<String, String>();
		nick_map.put("ori", uvo.getUser_nick()); // 기존 닉네임
		nick_map.put("rep", nick); // 바꿀 닉네임

		int list = user_dao.c_nick(nick_map);
		String str = "";
		if (list == 1) {
			str = "yes";
			uvo.setUser_nick(nick);
			session.setAttribute("vo", uvo);
		}

		String resultStr = String.format("[{'param':'%s'}]", str);
		return resultStr;
	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 비밀번호 변경
	@RequestMapping(value = { "/c_pw.do" })
	@ResponseBody
	public String c_pw(Model model, String c_pw1, String c_pw2, String c_pw3) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		String ori_pw = user_dao.c_pw_check(uvo);
		String str = "";
		String resultStr = "";
		
		
		if (!ori_pw.equals(c_pw1)) { // 기존의 비밀번호와 일치하지 않을때

			str = "not_equal1";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;

		} else if(c_pw1.equals(c_pw2)) {
			str = "equal";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;
			
		}else {
			HashMap<String, Object> pw_map = new HashMap<String, Object>();
			pw_map.put("user_code", uvo.getUser_code());
			pw_map.put("c_pw3", c_pw3);

			user_dao.c_pw(pw_map);
			session.removeAttribute("vo");
			str = "completed";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;
		}

	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 전화번호 변경
	@RequestMapping(value = { "/c_tel.do" })
	@ResponseBody
	public String c_tel(Model model, String tel) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		String reg_tel = "" + tel;
		HashMap<String, Object> tel_map = new HashMap<String, Object>();
		tel_map.put("user_code", uvo.getUser_code()); // 유저 코드
		tel_map.put("user_tel", reg_tel); // 바꿀 전화번호

		int list = user_dao.c_tel(tel_map);
		String str = "";
		if (list == 1) {
			str = "yes";
			uvo.setUser_tel(reg_tel);
			session.setAttribute("vo", uvo);
		}

		String resultStr = String.format("[{'param':'%s'}]", str);
		return resultStr;

	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 주소, 상세주소 변경
	@RequestMapping(value = { "/c_addr.do" })
	@ResponseBody
	public String c_addr(Model model, String user_addr, String user_daddr) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		HashMap<String, Object> addr_map = new HashMap<String, Object>();
		addr_map.put("user_code", uvo.getUser_code());
		addr_map.put("user_addr", user_addr);
		addr_map.put("user_daddr", user_daddr);

		int list = user_dao.c_addr(addr_map);
		String str = "";
		if (list == 1) {
			str = "yes";
			uvo.setUser_addr(user_addr);
			uvo.setUser_daddr(user_daddr);
			session.setAttribute("vo", uvo);
		}

		String resultStr = String.format("[{'param':'%s'}]", str);
		return resultStr;
	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 이메일 변경
	@RequestMapping(value = { "/c_email.do" })
	@ResponseBody
	public String c_email(Model model, String user_email1, String user_email2) {
		String full = user_email1 + "@" + user_email2;
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");
		HashMap<String, Object> email_map = new HashMap<String, Object>();
		email_map.put("user_code", uvo.getUser_code());
		email_map.put("user_email", full);

		int list = user_dao.c_email(email_map);
		String str = "";
		if (list == 1) {
			str = "yes";
			uvo.setUser_email(full);
			session.setAttribute("vo", uvo);
		}
		String resultStr = String.format("[{'param':'%s'}]", str);
		return resultStr;
	}
	///////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////작업!!//////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value = { "orderlist.do" }) // MyPage > 주문 내역 페이지
	public String orderlist(Model model) {
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		if(uvo == null) {
			return VIEW_PATH + "user/login.jsp";
		}

		CartViewVo viewvo = new CartViewVo();
		List<CartViewVo> list = new ArrayList<CartViewVo>();

		//cartview를 이용해야 겠다. ordercontroller참고!!
		List<OrderListVO> orderlist = new ArrayList<OrderListVO>();
		orderlist = orderlist_dao.selectlsit(uvo.getUser_code());


		for(int i = 0; i < orderlist.size(); i++) {
			int p_info_dcode = orderlist.get(i).getP_info_dcode();
			viewvo = cart_dao.selectview(p_info_dcode);

			ReplyVO rvo = new ReplyVO();
			rvo.setP_info_dcode(p_info_dcode);
			rvo.setUser_code(uvo.getUser_code());
			rvo.setPayment_code(orderlist.get(i).getPayment_code());

			rvo = reply_dao.replycheck(rvo);

			//rvo를 내부에서 생성하면 괜찮지만, 밖에서 생성을 하면 충분히 반복이 되지 않는다.
			if(rvo == null) {
				viewvo.setReply_ok(0);
			}else {
				viewvo.setReply_ok(1);
			}

			viewvo.setPayment_code(orderlist.get(i).getPayment_code());
			list.add(viewvo);
		}

		model.addAttribute("vo", uvo);
		model.addAttribute("list", list);
		return "/WEB-INF/views/user/userorderlist.jsp";
	}
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////

	// id_search_form.jsp로 맵핑 찍어주는데
	@RequestMapping("/id_search_form.do")
	public String id_search_form() {

		return VIEW_PATH + "user/id_search.jsp";
	}

	//id찾기 기능
	@RequestMapping("/id_search.do")
	@ResponseBody
	public List<String> id_search(String user_email) {
		List<UserVO> list = user_dao.id_search(user_email);

		List<String> param = new ArrayList<String>();

		//vo가 null인 경우 id자체가 DB에 존재하지 않는다는 의미
		if( list == null ) {
			param.add("no_email");

		}
		else {
			for(int i = 0; i < list.size(); i++) {
				param.add(list.get(i).getUser_id());
			}
		}
		return param;
	}

	//pw찾기 맵핑
	@RequestMapping("/pw_search_form.do")
	public String pw_search_form() {

		return VIEW_PATH + "user/pw_search.jsp";
	}

	//pw찾기 기능
	@RequestMapping("/pw_search.do")
	@ResponseBody
	public String pw_search(String user_id) {
		String param = "";

		UserVO vo = user_dao.pw_search(user_id);


		//vo가 null인 경우 id자체가 DB에 존재하지 않는다는 의미
		if( vo == null ) {
			param = "no_id";

		}
		else {
			param = vo.getUser_pw();

		}
		return param;
	}

	//main page로 이동하는 맵핑
	@RequestMapping("/main_page.do")
	public String main_page() {
		return VIEW_PATH + "main.jsp";
	}

	//휴면활성화
	@RequestMapping("/activate.do")
	public String activate() {
		return VIEW_PATH + "user/activate.jsp";
	}
	//탈퇴취소
	@RequestMapping("/restore.do")
	public String restore() {
		return VIEW_PATH + "user/restore.jsp";
	}

	//휴면 및 탈퇴 취소 완료
	@RequestMapping("/restorefin.do")
	@ResponseBody
	public String restorefin(String user_id, String user_pw) {

		//UserVO vo = user_dao.login(user_id);
		HttpSession session = request.getSession();
		//vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO vo = (UserVO) session.getAttribute("nvo");

		String param = "";

		//vo가 null인 경우 id자체가 DB에 존재하지 않는다는 의미
		if( !vo.getUser_id().equals(user_id)) {
			param = "no_id";
			return param;
		}

		if( !vo.getUser_pw().equals(user_pw) ) {
			// id는 일치하지만 pwd가 일치하지 않을 때
			param = "pwd_false";
			return param;
		}

		user_dao.restore(vo);
		param = "clear";
		session.removeAttribute("nvo");

		return param;
	}

	// @@ Mypage 회원정보 변경 관련 @@ //
	// 회원 탈퇴, 탈퇴 예정
	@RequestMapping(value = { "/c_user_out.do" })
	@ResponseBody
	public String user_out(Model model, String user_pw1, String user_pw2) {
		HttpSession session = request.getSession();
		// vo라는 이름의 userVO 세션이 생성되어 있음
		UserVO uvo = (UserVO) session.getAttribute("vo");

		String ori_pw = user_dao.c_pw_check(uvo);

		String str = "";
		String resultStr = "";
		if (!ori_pw.equals(user_pw1)) { // 기존의 비밀번호와 일치하지 않을때

			str = "pw_db_not_eq";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;

		} else if (!user_pw1.equals(user_pw2)) {

			str = "pw_not_eq";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;

		} else {

			HashMap<String, Object> pw_map = new HashMap<String, Object>();
			pw_map.put("user_code", uvo.getUser_code());
			pw_map.put("user_pw1", user_pw1);

			user_dao.c_user_out(pw_map);
			session.removeAttribute("vo");
			str = "yes";
			resultStr = String.format("[{'param':'%s'}]", str);
			return resultStr;
		}
	}

}
