package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.ReplyVO;
import vo.Reply_ViewsVO;

@Repository("reply_dao")
public class ReplyDAO {
	@Autowired
	SqlSession sqlSession;
	// 상품 정보 구매후기
	public List<Reply_ViewsVO> reply(int p_info_code) {
		List<Reply_ViewsVO> list = sqlSession.selectList("reply.reply", p_info_code);

		return list;
	}

	public int reply_insert(ReplyVO vo) {
		int res = sqlSession.insert("reply.reply_insert", vo);
		return res;
	}

	public ReplyVO replycheck(ReplyVO vo) {
		ReplyVO rvo = sqlSession.selectOne("reply.replycheck", vo);
		return rvo;
	}

	// MyPage 구매후기
	public List<Reply_ViewsVO> user_reply(int user_code) {

		List<Reply_ViewsVO> list = sqlSession.selectList("reply.user_reply", user_code);

		return list;
	}
}
