package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.P_detailVO;

@Repository("p_detail_dao")
public class P_detailDAO {
	@Autowired
	SqlSession sqlSession;
	
	public Map<String, List<String>> p_dinfo(int p_info_code) {

		List<P_detailVO> list = sqlSession.selectList("p_detail.p_detail", p_info_code);
		List<String> size = new ArrayList<String>();
		List<String> color = new ArrayList<String>();

		for (int i = 0; i < list.size(); i++) {

			if (!size.contains(list.get(i).getP_detail_size())) {
				size.add(list.get(i).getP_detail_size());
			}
			if (!color.contains(list.get(i).getP_detail_color())) {
				color.add(list.get(i).getP_detail_color());
			}
		}
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("size", size);
		map.put("color", color);

		return map;
	}
	
	public int cellplus(int p_info_dcode) {
		int res = sqlSession.update("p_detail.plus", p_info_dcode);
		return res;
	}
	
	public P_detailVO select(int p_info_dcode){
		P_detailVO vo = sqlSession.selectOne("p_detail.p_code_vo", p_info_dcode);
		return vo;
	}
	
	public P_detailVO selectvo(P_detailVO pvo) {
		P_detailVO vo = sqlSession.selectOne("p_detail.pvo", pvo);
		return vo;
	}
	
	public P_detailVO selectd(int p_info_code){
		P_detailVO vo = sqlSession.selectOne("p_detail.p_dcode_vo", p_info_code);
		return vo;
	}
	
	public List<P_detailVO> selectList(int p_info_code){
		List<P_detailVO> list = sqlSession.selectList("p_detail.p_dlist", p_info_code);
		return list;
	}
	
	public List<P_detailVO> p_adinfo(int p_info_code) { //임시
		
		List<P_detailVO> list = sqlSession.selectList("p_detail.p_adetail", p_info_code);

		return list;
	}
}
