package com.kh.mw.util;

import java.io.File;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class MyFileUploader {
	public static String uploadFile(String uploadPath, String originalFilename, 
										byte[] fileData) {
		String path = "C:/workspace/mw_upload_img"; //폴더 경로
		File folder = new File(path);

		// 해당 디렉토리가 없는 경우 디렉토리를 생성
		if (!folder.exists()) {
			try{
			    folder.mkdir(); // 폴더 생성
			    System.out.println("폴더가 생성되었습니다.");
		        } 
		    catch(Exception e){
			    e.getStackTrace();
		    }        
	    } else {
			System.out.println("이미 폴더가 존재합니다.");
		}
		
		// 업로드한 파일 저장
		UUID uuid = UUID.randomUUID();
		String saveFilename = uploadPath + "/" + uuid + "_" + originalFilename;
		File target = new File(saveFilename); // 업로드할 위치정보를 가진 파일객체
		try {
			FileCopyUtils.copy(fileData, target);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saveFilename;
	}
}
