package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.OrderVO;
import vo.UserVO;

@Repository("user_dao")
public class UserDAO {
	@Autowired
	SqlSession sqlSession;
	public int c_user_out(HashMap<String, Object>map) {
		int res = sqlSession.update("user.c_user_out",map);
		return res;
	}
	
	//email중복 확인
	public UserVO echeck(String user_email) {
		UserVO vo = sqlSession.selectOne("user.e_check", user_email);
		return vo;
	}
	
	//회원탈퇴 취소
	public int restore(UserVO vo) {
		int res = sqlSession.update("user.restore", vo);
		return res;
	}

	//login할때 마지막 로그인 날짜 수정
	public int logupdate(UserVO vo) {
		int res = sqlSession.update("user.logdate", vo);
		return res;
	}

	public int classup(UserVO vo) {
		int res = sqlSession.update("user.classup", vo);
		return res;
	}
	public UserVO uservo(int user_code) {
		UserVO vo = sqlSession.selectOne("user.user_vo", user_code);
		return vo;
	}

	public int user_class(int user_code) {
		int res = sqlSession.selectOne("user.user_class", user_code);
		return res;
	}

	public int total(OrderVO vo) {
		int res = sqlSession.update("user.totalsum", vo);
		return res;
	}

	// 게시글 추가
	public int insert(UserVO vo) {
		int res = sqlSession.insert("user.user_insert", vo);

		// sqlSession.commit();

		return res;
	}

	// 안쓰는 id 중복췤
	public int id_double_check(UserVO vo) {
		int res = sqlSession.selectOne("user.user_id_double_check", vo);
		return res;
	}

	//nick 중복체크
	public UserVO nickselectOne(String user_nick) {
		UserVO vo = sqlSession.selectOne("user.nickSelectOne", user_nick);

		return vo;
	}

	//id 중복체크
	public UserVO selectOne(String user_id) {

		UserVO vo = sqlSession.selectOne("user.selectOne",user_id);

		return vo;
	}

	//로그인
	public UserVO login(String user_id) {


		UserVO vo = sqlSession.selectOne("user.user_login", user_id);
		return vo;
	}

	//id 찾기
	public List<UserVO> id_search(String user_email) {
		List<UserVO> list = sqlSession.selectList("user.user_id_search", user_email);
		return list;
	}

	//pw 찾기
	public UserVO pw_search(String user_id) {
		UserVO vo = sqlSession.selectOne("user.user_pw_search", user_id);
		return vo;
	}

	//
	public List<UserVO> user_info(int user_code){

		List<UserVO> list = sqlSession.selectList("user.user_info",user_code);

		return list;
	}

	// @@ MyPpage 회원정보 변경 @@ //

	// @@ 1. 프로필 사진 변경 @@ //
	public int c_profile(UserVO vo) {

		int res = sqlSession.update("user.c_profile", vo);

		return res;
	}

	// @@ 2. 닉네임 변경 @@ //
	public int c_nick(HashMap<String, String> map) {

		int res = sqlSession.update("user.c_nick", map);

		return res;
	}

	// @@ 3-1 기존 비밀번호 확인 @@ //
	public String c_pw_check(UserVO vo) {

		String res = sqlSession.selectOne("user.c_pw_check", vo);

		return res;
	}

	// @@ 3-2 비밀번호 변경 @@ //
	public int c_pw(HashMap<String, Object> map) {

		int res = sqlSession.update("user.c_pw",map);

		return res;
	}

	// @@ 4. 전화번호 변경 @@ //
	public int c_tel(HashMap<String, Object> map) {

		int res = sqlSession.update("user.c_tel", map);

		return res;
	}

	// @@ 5. 주소 변경 @@ //
	public int c_addr(HashMap<String, Object> map) {

		int res = sqlSession.update("user.c_addr", map);

		return res;
	}

	// @@ 6. 이메일 변경 @@ //
	public int c_email(HashMap<String, Object> map) {

		int res = sqlSession.update("user.c_email", map);

		return res;
	}
}
