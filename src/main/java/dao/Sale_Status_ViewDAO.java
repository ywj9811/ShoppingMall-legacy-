package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import util.Method;
import vo.Sale_Status_ViewVO;

@Repository("sale_status_view_dao")
public class Sale_Status_ViewDAO {
	@Autowired
	SqlSession sqlSession;

	public HashMap<String, String> selectList() {
		List<Sale_Status_ViewVO> list = sqlSession.selectList("sale_status_view.list");
		int total_sales_view = 0;
		int total_amount_view = 0;

		for (int i = 0; i < list.size(); i++) {
			total_sales_view += list.get(i).getView_cell();
			total_amount_view += list.get(i).getProfit();
		}

		String total_sales = util.Method.math(total_sales_view);
		String total_amount = util.Method.math(total_amount_view);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("total_sales", total_sales);
		map.put("total_amount", total_amount);

		return map;
	}

	public List<Sale_Status_ViewVO> list() {
		List<Sale_Status_ViewVO> list = sqlSession.selectList("sale_status_view.list");
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setView_profit(Method.math(list.get(i).getProfit()));
		}
		return list;
	}

	public List<Sale_Status_ViewVO> searchList(Sale_Status_ViewVO vo) {

		List<Sale_Status_ViewVO> list = sqlSession.selectList("sale_status_view.search_list", vo);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setView_profit(Method.math(list.get(i).getProfit()));
		}
		return list;
	}

}
