package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CartVO;
import vo.CartViewVo;
import vo.P_detailVO;

@Repository("cart_dao")
public class CartDAO {
	@Autowired
	SqlSession sqlSession;
	
	public CartViewVo selectview(int p_info_dcode){
		CartViewVo view = sqlSession.selectOne("cart.cart_view", p_info_dcode);
		return view;
	}
	
	public int cartplus(P_detailVO pvo) {
		int res = sqlSession.insert("cart.cartplus", pvo);
		return res;
	}
	
	public List<CartVO> select(int user_code){
		List<CartVO> list = sqlSession.selectList("cart.cart_list", user_code);
		return list;
	}
	
	public int cart_count(int user_code) {
		int res = sqlSession.selectOne("cart.cart_count", user_code);
		return res;
	}
	
	public int plus(CartVO vo) {
		int res = sqlSession.update("cart.cart_plus", vo);
		return res;
	}
	
	public int minus(CartVO vo) {
		int res = sqlSession.update("cart.cart_minus", vo);
		return res;
	}
	
	public int deleteOne(HashMap<String, Integer> map) {
		int res = sqlSession.delete("cart.delOne", map);
		return res;
	}
	
	public int deleteAll(int user_code) {
		int res = sqlSession.delete("cart.delAll",user_code);
		return res;
	}
}
