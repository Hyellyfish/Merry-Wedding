package com.kh.mw.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VendorVo {
	private int v_no;
	private String v_tcode;
	private String v_rcode;
	private String v_name;
	private String v_address;
	private String v_tel;
	private String v_link;
	private String v_detail;
	private int v_score;
	private String v_pic;
}
