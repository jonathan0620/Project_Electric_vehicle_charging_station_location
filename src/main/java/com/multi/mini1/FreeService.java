package com.multi.mini1;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

	// 게시물 수정
	public int updateFreePost(FreeVO freeVO) throws Exception {
		return freeDAO.updateFreePost(freeVO);
	}

	/*
	 * // 게시글 삭제 public int deleteFreePost(int f_no, int f_num) throws Exception {
	 * try { int result = freeDAO.deleteFreePost(f_no, f_num);
	 * 
	 * return result > 0 ? 1 : 0; } catch (Exception e) { e.printStackTrace(); throw
	 * new Exception("게시물 삭제 중 오류 발생", e); } }
	 */

	// 게시글 삭제
	public int deleteFreePost(int f_no, int f_num) throws Exception {
		try {
			int result = freeDAO.deleteFreePost(f_no, f_num);

			return result > 0 ? 1 : 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("게시물 삭제 중 오류 발생", e);
		}
	}

	// 게시글 + 댓글 삭제
	@RequestMapping("deleteFreePostWithComments")
	@ResponseBody
	public String deleteFreePostWithComments(@RequestParam("f_no") int f_no, @RequestParam("f_num") int f_num) {
		try {
			int commentResult = freeDAO.deleteComments(f_num);

			int postResult = deleteFreePost(f_no, f_num);

			if (commentResult > 0 && postResult > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 댓글 추가
	public int addComment(CommentVO comment) throws Exception {
		return freeDAO.addComment(comment);
	}

	// 댓글 가져오기
	public List<CommentVO> getComments(int fr_ori_bbs) throws Exception {
		return freeDAO.getComments(fr_ori_bbs);
	}

	// 댓글 삭제
	public int deleteComment(int fr_num) throws Exception {
		return freeDAO.deleteComment(fr_num);
	}

	// 댓글 삭제
	public int deleteComments(int fr_num) throws Exception {
		return freeDAO.deleteComments(fr_num);
	}

	// 댓글 수정
	public int updateComment(CommentVO commentVO) throws Exception {
		try {
			int result = freeDAO.updateComment(commentVO);

			return result > 0 ? 1 : 0;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("댓글 수정 중 오류 발생", e);
		}
	}

	// 댓글 상세 정보
	public CommentVO getCommentDetails(int fr_num) throws Exception {
		return freeDAO.getCommentDetails(fr_num);
	}

}
