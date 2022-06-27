package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CartVO;
import vo.OrderVO;

@Repository("order_dao")
public class OrderDAO {
	@Autowired
	SqlSession sqlSession;
	//orderDAO에서 장바구니 테이블 리스트를 만들어서 반복문을 통해 반복을 함.
	//결제 페이지에서 구매자의 정보를 받아 구매자의 정보를 ordervo에 저장.
	//그럼 반복문 안에서 vo와 장바구니 리스트를 파라미터로 mapper에 넘겨서 insert
	public int insert(OrderVO vo) {
		int res = sqlSession.insert("order.order_insert", vo);
		return res;
	}
	
	public OrderVO selectvo(OrderVO vo) {
		OrderVO ovo = sqlSession.selectOne("order.selectvo", vo);
		return ovo;
	}
}
