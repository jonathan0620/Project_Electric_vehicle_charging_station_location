package com.multi.mini1;

import java.util.Date;
import java.lang.String;

public class FreeVO {

	private int f_no;
	private int f_num;
	private String f_title;
	private String f_content;
	private String f_writer;
	private int f_like;
	private Date f_time;
	private int f_view;
	private String type;
	private String keyword;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getF_no() {
		return f_no;
	}

	public void setF_no(int f_no) {
		this.f_no = f_no;
	}

	public int getF_num() {
		return f_num;
	}

	public void setF_num(int f_num) {
		this.f_num = f_num;
	}

	public String getF_title() {
		return f_title;
	}

	public void setF_title(String f_title) {
		this.f_title = f_title;
	}

	public String getF_content() {
		return f_content;
	}

	public void setF_content(String f_content) {
		this.f_content = f_content;
	}

	public String getF_writer() {
		return f_writer;
	}

	public void setF_writer(String f_writer) {
		this.f_writer = f_writer;
	}

	public int getF_like() {
		return f_like;
	}

	public void setF_like(int f_like) {
		this.f_like = f_like;
	}

	public Date getF_time() {
		return f_time;
	}

	public void setF_time(Date f_time) {
		this.f_time = f_time;
	}

	public int getF_view() {
		return f_view;
	}

	public void setF_view(int f_view) {
		this.f_view = f_view;
	}

	@Override
	public String toString() {
		return "FreeVO [f_no=" + f_no + ", f_num=" + f_num + ", f_title=" + f_title + ", f_content=" + f_content
				+ ", f_writer=" + f_writer + ", f_like=" + f_like + ", f_time=" + f_time + ", f_view=" + f_view
				+ ", type=" + type + ", keyword=" + keyword + "]";
	}

}
