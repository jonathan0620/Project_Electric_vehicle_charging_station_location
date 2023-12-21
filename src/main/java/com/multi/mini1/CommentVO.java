package com.multi.mini1;

import java.util.Date;

public class CommentVO {
	private int fr_num;
	private String fr_content;
	private String fr_writer;
	private Date fr_time;
	private int fr_ori_bbs;

	public int getFr_num() {
		return fr_num;
	}

	public void setFr_num(int fr_num) {
		this.fr_num = fr_num;
	}

	public String getFr_content() {
		return fr_content;
	}

	public void setFr_content(String fr_content) {
		this.fr_content = fr_content;
	}

	public String getFr_writer() {
		return fr_writer;
	}

	public void setFr_writer(String fr_writer) {
		this.fr_writer = fr_writer;
	}

	public Date getFr_time() {
		return fr_time;
	}

	public void setFr_time(Date fr_time) {
		this.fr_time = fr_time;
	}

	public int getFr_ori_bbs() {
		return fr_ori_bbs;
	}

	public void setFr_ori_bbs(int fr_ori_bbs) {
		this.fr_ori_bbs = fr_ori_bbs;
	}

	@Override
	public String toString() {
		return "CommentVO [fr_num=" + fr_num + ", fr_content=" + fr_content + ", fr_writer=" + fr_writer + ", fr_time="
				+ fr_time + ", fr_ori_bbs=" + fr_ori_bbs + "]";
	}

}
