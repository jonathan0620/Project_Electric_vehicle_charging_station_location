package com.multi.mini1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	/*
	 * public FreeVO selectFreeDetails(int f_no) throws Exception { return
	 * my.selectOne("free.selectFreeDetails", f_no); }
	 */

	public int updateFreePost(FreeVO freeVO) throws Exception {
		return my.update("free.updateFreePost", freeVO);
	}

	public int addComment(CommentVO comment) {
		return my.insert("comment.create", comment);
	}

	public List<CommentVO> getComments(int fr_ori_bbs) throws Exception {
		return my.selectList("comment.getComments", fr_ori_bbs);
	}
}
