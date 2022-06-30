package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.P_infoVO;

@Repository("p_info_dao")
public class P_infoDAO {
	@Autowired
	SqlSession sqlSession;

	public P_infoVO select(int p_info_code) {
		P_infoVO vo = sqlSession.selectOne("p_info.p_info_vo", p_info_code);
		return vo;
	}

	// 검색어 입력조회
	public List<P_infoVO> search(Map<String, Object> map) {

		List<P_infoVO> list = sqlSession.selectList("p_info.search", map);

		return list;
	}

	// 검색된 데이터 한개의 값을 가져온다
	public P_infoVO p_info(int p_info_code) {

		P_infoVO p_infoVO = sqlSession.selectOne("p_info.p_info", p_info_code);

		return p_infoVO;
	}

	// 각 카테고리별 이동
	public List<P_infoVO> p_list(P_infoVO vo) {
		List<P_infoVO> list = sqlSession.selectList("p_info.p_list", vo);
		return list;
	}

	public List<P_infoVO> today_list(P_infoVO vo) {
		List<P_infoVO> list = sqlSession.selectList("p_info.today", vo);
		return list;
	}

	// 관리자 상품 게시물 return
	public List<P_infoVO> selectList() {
		List<P_infoVO> list = sqlSession.selectList("p_info.p_info_select");
		return list;
	}

	// 관리자 상품 중복 체크
	public P_infoVO selectOne(String p_info_img1) {
		P_infoVO vo = sqlSession.selectOne("p_info.p_info_one", p_info_img1);

		return vo;
	}

	// 관리자 상품 등록
	public int insert(P_infoVO vo) {
		int res = sqlSession.insert("p_info.p_insert", vo);

		return res;
	}
}
