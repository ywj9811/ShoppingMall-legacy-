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

	public P_infoVO select(int p_info_code){
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
	
	//각 카테고리별 이동 ////////////////////
	public List<P_infoVO> p_list(P_infoVO vo){
		List<P_infoVO> list = sqlSession.selectList("p_info.p_list", vo);
		return list;
	}
	public List<P_infoVO> today_list(P_infoVO vo){
		List<P_infoVO> list = sqlSession.selectList("p_info.today", vo);
		return list;
	}
}
