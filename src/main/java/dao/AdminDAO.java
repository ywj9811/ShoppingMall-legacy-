package dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.AdminVO;

@Repository("admin_dao")
public class AdminDAO {
	@Autowired
	SqlSession sqlSession;

	public AdminVO selectOne(String admin_id, String admin_pw) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("admin_id", admin_id);
		map.put("admin_pw", admin_pw);
		AdminVO admin_vo = sqlSession.selectOne("admin.select", map);

		return admin_vo;
	}
}
