package com.kh.mw.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVo {
	private String userid;
	private String userpw;
	private String username;
	private String email;
	private String phonenum;
	private String url;
	private int pjnum;
	private String temptype;
}
