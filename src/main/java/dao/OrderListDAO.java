package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.OrderListVO;

@Repository("orderlist_dao")
public class OrderListDAO {
	@Autowired
	SqlSession sqlSession;
	
	public List<OrderListVO> select(int order_code){
		List<OrderListVO> list = sqlSession.selectList("orderlist.oselect", order_code);
		return list;
	}
	
	public int insert(OrderListVO vo){
		int res = sqlSession.insert("orderlist.olinsert", vo);
		return res;
	}
	
	///////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////작업!!//////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////
	public List<OrderListVO> selectlsit(int user_code){
		List<OrderListVO> list = sqlSession.selectList("orderlist.olist", user_code);
		return list;
	}
}
