package com.multi.mini1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FreeController {

	// 전체 게시글 불러오기
	@Autowired
	private FreeService freeService;

	@RequestMapping("free_list")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int pageSize) throws Exception {
		int totalCount = freeService.getFreeTotalCount();

		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		List<FreeVO> freeList = freeService.getFreeList(page, pageSize); // 1, 10

		Map<String, Object> result = new HashMap<>();
		result.put("numPages", totalPages);
		result.put("posts", freeList);

		return result;
	}

	// 게시글 메인에서 검색하기
	@RequestMapping("getSearchList")
	@ResponseBody
	private Map<String, Object> getSearchList(@RequestParam("page") int page, @RequestParam("pageSize") int pageSize,
			@RequestParam("type") String type, @RequestParam("keyword") String keyword, Model model) throws Exception {
		FreeVO freeVo = new FreeVO();
		freeVo.setType(type);
		freeVo.setKeyword(keyword);

		int totalCount = freeService.getSearchTotalCount(freeVo);
		int totalPages = (int) Math.ceil((double) totalCount / pageSize);

		Map<String, Object> result = freeService.getSearchListWithPagination(page, pageSize, freeVo);
		result.put("numPages", totalPages);

		return result;
	}

	// 게시글 작성하기
	@RequestMapping("free_board_insert")
	public String insert(FreeVO freeVo, Model model) {
		System.out.println("insert 호출!");
		try {
			int result = freeService.insert(freeVo);
			if (result > 0) {
				model.addAttribute("result", "게시글이 성공적으로 작성되었습니다.");
			} else {
				model.addAttribute("result", "게시글 작성에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("result", "에러가 발생했습니다.");
		}

		return "redirect:free_board.jsp";
	}

	// 게시글 상세페이지
	@RequestMapping("getFreeDetails")
	@ResponseBody
	private FreeVO getFreeDetails(@RequestParam("f_no") int f_no, @RequestParam("f_num") int f_num) throws Exception {
		return freeService.getFreeDetails(f_no, f_num);
	}

	// 게시글 수정
	@RequestMapping("updateFreePost")
	@ResponseBody
	private String updateFreePost(@RequestParam("f_no") int f_no, @RequestParam("f_title") String f_title,
			@RequestParam("f_content") String f_content, @RequestParam("f_num") int f_num) {
		try {
			FreeVO existingPost = freeService.getFreeDetails(f_no, f_num);

			existingPost.setF_title(f_title);
			existingPost.setF_content(f_content);

			int result = freeService.updateFreePost(existingPost);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 게시글 + 게시글 댓글 삭제
	@RequestMapping("deleteFreePostWithComments")
	@ResponseBody
	public String deleteFreePostWithComments(@RequestParam("f_no") int f_no, @RequestParam("f_num") int f_num) {
		try {
			freeService.deleteComments(f_num);

			int result = freeService.deleteFreePost(f_no, f_num);

			if (result > 0) {
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
	@RequestMapping("addComment")
	@ResponseBody
	private String addComment(@RequestParam("fr_ori_bbs") int fr_ori_bbs,
			@RequestParam("fr_content") String fr_content) {
		try {
			CommentVO comment = new CommentVO();
			comment.setFr_ori_bbs(fr_ori_bbs);

			comment.setFr_content(fr_content);

			int result = freeService.addComment(comment);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 댓글 가져오기
	@RequestMapping("getComments")
	@ResponseBody
	private List<CommentVO> getComments(@RequestParam("fr_ori_bbs") int fr_ori_bbs) throws Exception {
		return freeService.getComments(fr_ori_bbs);
	}

	// 댓글 수정
	@RequestMapping("updateComment")
	@ResponseBody
	private String updateComment(@RequestParam("fr_num") int fr_num, @RequestParam("fr_content") String fr_content) {
		try {
			CommentVO existingComment = freeService.getCommentDetails(fr_num);

			if (existingComment != null) {
				existingComment.setFr_content(fr_content);

				int result = freeService.updateComment(existingComment);

				if (result > 0) {
					return "success";
				} else {
					return "fail";
				}
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	// 댓글 삭제
	@RequestMapping("deleteComment")
	@ResponseBody
	private String deleteComment(@RequestParam("fr_num") int fr_num) {
		try {
			int result = freeService.deleteComment(fr_num);

			if (result > 0) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

}
