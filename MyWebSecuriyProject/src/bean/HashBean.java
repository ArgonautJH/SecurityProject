package bean;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.security.MessageDigest;

import org.bouncycastle.pqc.math.linearalgebra.ByteUtils;

public class HashBean {
	private String plainText;	// 암호화 할 텍스트
	private String type;		
	private String fileName;	
	private String filePath;
	
	private String hashResult;	// 암호화 결과
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFilePath() {
		return filePath;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileName() {
		return fileName;
	}
	
	public String getPlainText() {
		return plainText;
	}
	public void setPlainText(String plainText) {
		this.plainText = plainText;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getHashResult() {
		return changeTextToHash(type,plainText);
	}

	public String changeTextToHash(String type, String text) {
		String hashValue = "";
		String mdType = "";
		switch(type) {
		case "md5":
			mdType ="MD5";
			break;
		case "sha1":
			mdType ="SHA-1";
			break;
		case "sha256":
			mdType ="SHA-256";
			break;
		case "sha384":
			mdType ="SHA-384";
			break;
		case "sha512":
			mdType ="SHA-512";
			break;
		}
		
		try {
			MessageDigest md = MessageDigest.getInstance(mdType);
			md.update(text.getBytes());
			byte[] hash = md.digest();
			hashValue = ByteUtils.toHexString(hash);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return hashValue;
	}
	
	// 파일을 해쉬로
	public String changeFileToHash(String type) {
		MessageDigest md;
		String mdType = "";
		String hashValue = "";
		
		File file = new File(filePath);
		
		switch(type) {
		case "md5":
			mdType ="MD5";
			break;
		case "sha1":
			mdType ="SHA-1";
			break;
		case "sha256":
			mdType ="SHA-256";
			break;
		case "sha384":
			mdType ="SHA-384";
			break;
		case "sha512":
			mdType ="SHA-512";
			break;
		}
		
		try {
			md = MessageDigest.getInstance(mdType);
			
			byte[] buffer = new byte[1024];
			InputStream input = new BufferedInputStream(new FileInputStream(file));
			int read = -1;
			
			while((read=input.read(buffer)) != -1) {
				md.update(buffer, 0 , read); // 0 => 처음부터 끝까지
			}
			hashValue = ByteUtils.toHexString(md.digest());
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return hashValue;
	}
	
	public static void main(String[] args) {
		HashBean a = new HashBean();
//		a.setPlainText("1234");
		a.setFilePath("E:\\경민대학교\\2023 경민대학교\\2학기\\소프트웨어 개발 보안\\test");
		a.setFileName("2.txt");
		a.setType("md5");
//		System.out.println(a.getHashResult());
	}
}
