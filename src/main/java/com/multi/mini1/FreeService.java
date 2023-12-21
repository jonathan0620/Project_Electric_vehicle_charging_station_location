package com.multi.mini1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeService {
	private FreeDAO freeDAO;

	@Autowired
	public FreeService(FreeDAO freeDAO) {
		this.freeDAO = freeDAO;
	}

	public List<FreeVO> getFreeList(int page, int pageSize) throws Exception {
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		return freeDAO.getFreeList(start, end);
	}

	public int insert(FreeVO freeVO) throws Exception {
		return freeDAO.insert(freeVO);
	}

	public int getFreeTotalCount() throws Exception {
		return freeDAO.getTotalCount();
	}

	public List<FreeVO> getSearchList(FreeVO freeVo) throws Exception {
		return freeDAO.selectSearchList(freeVo);
	}

	public int getSearchTotalCount(FreeVO freeVo) throws Exception {
		return freeDAO.getSearchTotalCount(freeVo);
	}

	public Map<String, Object> getSearchListWithPagination(int page, int pageSize, FreeVO freeVo) throws Exception {
		int start = 1 + (page - 1) * pageSize;
		int end = page * pageSize;

		List<FreeVO> searchList = freeDAO.getSearchList(start, end, freeVo);
		int totalCount = freeDAO.getSearchTotalCount(freeVo);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", searchList);

		return result;
	}
	
	public FreeVO getFreeDetails(int f_no, int f_num) throws Exception {
	    Map<String, Integer> paramMap = new HashMap<>();
	    paramMap.put("f_no", f_no);
	    paramMap.put("f_num", f_num);
	    return freeDAO.selectFreeDetails(paramMap);
	}
	
	/*
	 * public FreeVO getFreeDetails(int f_no) throws Exception { return
	 * freeDAO.selectFreeDetails(f_no); }
	 */

	public int updateFreePost(FreeVO freeVO) throws Exception {
		return freeDAO.updateFreePost(freeVO);
	}

	public int addComment(CommentVO comment) throws Exception {
		return freeDAO.addComment(comment);
	}

	public List<CommentVO> getComments(int fr_ori_bbs) throws Exception {
		return freeDAO.getComments(fr_ori_bbs);
	}

}
