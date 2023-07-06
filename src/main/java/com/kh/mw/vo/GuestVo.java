package com.kh.mw.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestVo {
	private int g_no;
	private String g_name;
	private String g_phonenumber;
	private String userid;
}
