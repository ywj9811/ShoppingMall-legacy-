package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.PaymentVO;

@Repository("payment_dao")
public class PaymentDAO {
	@Autowired
	SqlSession sqlSession;
	
	public PaymentVO selectvo(PaymentVO vo) {
		PaymentVO pvo = sqlSession.selectOne("payment.paymentvo", vo);
		return pvo;
	}
	
	public int insert(PaymentVO vo) {
		int res = sqlSession.insert("payment.payment_insert", vo);
		return res;
	}
}
