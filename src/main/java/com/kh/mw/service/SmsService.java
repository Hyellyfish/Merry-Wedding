package com.kh.mw.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.google.inject.spi.Message;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SmsService {
	public void certifiedPhoneNumber(String to, String text) throws CoolsmsException {
		String api_key = "NCSCQZ9TEWEGY5XD";
		String api_secret = "JLWCOP55G9YJHAHBTNWH4OWUBDROAW6W";
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", to);
		params.put("from", "01066483012");
		params.put("type", "LMS");
		params.put("text", text);
		params.put("app_version",  "test app 1.2");
		
		System.out.println(params);
//		coolsms.send(params);
		}
}
