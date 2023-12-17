package bean;

import java.security.MessageDigest;

import org.bouncycastle.pqc.math.linearalgebra.ByteUtils;

public class HashBean {
	private String plainText;	// 암호화 할 텍스트
	private String type;		// 알고리즘 타입
	
	private String hashResult;	// 암호화 결과
	
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

	private String changeTextToHash(String type, String text) {
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
}
