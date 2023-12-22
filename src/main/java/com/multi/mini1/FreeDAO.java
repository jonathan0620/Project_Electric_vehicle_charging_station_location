package com.multi.mini1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeDAO {

	@Autowired
	private SqlSessionTemplate my;

	public int insert(FreeVO freeVo) {
		return my.insert("free.create", freeVo);
	}

	public List<FreeVO> getFreeList(int start, int end) throws Exception {
		Map<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		return my.selectList("free.list", params);
	}

	public int getTotalCount() throws Exception {
		return my.selectOne("free.totalCount");
	}

	public int getSearchTotalCount(FreeVO freeVo) throws Exception {
		return my.selectOne("free.searchTotalCount", freeVo);
	}

	public List<FreeVO> getSearchList(int start, int end, FreeVO freeVo) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		params.put("freeVo", freeVo);
		return my.selectList("free.searchFreeList", params);
	}

	public int searchTotalCount(FreeVO freeVo) throws Exception {
		return my.selectOne("free.searchTotalCount", freeVo);
	}

	public List<FreeVO> selectSearchList(FreeVO freeVo) throws Exception {
		return my.selectList("free.searchFreeList", freeVo);
	}

	public FreeVO selectFreeDetails(Map<String, Integer> paramMap) throws Exception {
		return my.selectOne("free.selectFreeDetails", paramMap);
	}

	public int updateFreePost(FreeVO freeVO) throws Exception {
		return my.update("free.updateFreePost", freeVO);
	}

	/*
	 * public int deleteFreePost(@Param("f_no") int f_no, @Param("f_num") int f_num)
	 * { Map<String, Integer> params = new HashMap<>(); params.put("f_no", f_no);
	 * params.put("f_num", f_num); return my.delete("free.deleteFreePost", params);
	 * }
	 */

	public int deleteFreePost(int f_no, int f_num) {
		my.delete("comment.deleteComments", f_num);

		Map<String, Integer> paramMap = new HashMap<>();
		paramMap.put("f_no", f_no);
		paramMap.put("f_num", f_num);

		return my.delete("free.deleteFreePost", paramMap);
	}

	// 댓글 삭제
	public int deleteComment(int fr_num) {
		return my.delete("comment.deleteComment", fr_num);
	}

	// 댓글 전체 삭제
	public int deleteComments(int fr_num) {
		return my.delete("comment.deleteComments", fr_num);
	}

	// 댓글 추가
	public int addComment(CommentVO comment) {
		return my.insert("comment.create", comment);
	}

	// 댓글 가져오기
	public List<CommentVO> getComments(int fr_ori_bbs) throws Exception {
		return my.selectList("comment.getComments", fr_ori_bbs);
	}

	// 댓글 수정
	public int updateComment(CommentVO commentVO) {
		return my.update("comment.updateComment", commentVO);
	}

	// 댓글 상세 정보
	public CommentVO getCommentDetails(int fr_num) throws Exception {
		return my.selectOne("comment.getCommentDetails", fr_num);
	}

}
