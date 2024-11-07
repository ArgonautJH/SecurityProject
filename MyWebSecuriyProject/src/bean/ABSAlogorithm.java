package bean;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.nio.ByteBuffer;
import java.util.Base64;

public class ABSAlogorithm {
    private ServletContext application;
    private HttpServletRequest request;
    private HttpServletResponse response;

    private String type;    // 암 / 복호화 타입
    private String fileName;
    private String password;
    
    private String seedValue;

    public String getSeedValue() {
		return seedValue;
	}

	public void setApplication(ServletContext application) {
		this.application = application;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	/**
     * 파일을 암호화 하는 메소드
     * @param key  암호화 키
     * @param targetfile 암호화 할 파일
     * @param saveFile 암호화 된 파일을 저장할 파일
     */
    private static void encryptFile(SecretKey key, File targetfile,File saveFile) {
        InputStream input = null;
        OutputStream out = null;

        try {
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, key);

            input = new BufferedInputStream(new FileInputStream(targetfile));
            out = new CipherOutputStream(new FileOutputStream(saveFile), cipher);

            byte[] buffer = new byte[1024];		// 버퍼 사이즈[한번의 읽을 양]
			int read = 0; 						// 읽은 부분을 확인하기 위한 변수
			
			while((read=input.read(buffer)) != -1 ) {
				out.write(buffer, 0, read);	// 쓰기
			}
			
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) out.close();
                if (input != null) input.close();
                System.out.println("암호화 종료");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 파일을 복호화 하는 메소드
     * @param key 복호화 키
     * @param encryptFile
     * @param decryptFile
     */
    private static boolean decryptFile(SecretKey key, File encryptFile,File decryptFile ){
        InputStream input = null;
        OutputStream out = null;

        try{
        	Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, key);

            input = new CipherInputStream(new FileInputStream(encryptFile), cipher);
            out = new BufferedOutputStream(new FileOutputStream(decryptFile));

            byte[] buffer = new byte[1024];		// 버퍼 사이즈[한번의 읽을 양]
			int read = 0; 						// 읽은 부분을 확인하기 위한 변수
			
			while((read=input.read(buffer)) != -1 ) {
				out.write(buffer, 0, read);	// 쓰기
			}

			return true; // 성공했을 때 true 반환
        }catch (Exception e) {
            e.printStackTrace();
			return false; // 예외가 발생하면 false 반환
        } finally {
            try {
                if (out != null) out.close();
                if (input != null) input.close();
                System.out.println("복호화 종료");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
	public void FileDownload(String saveDirectory, String saveFileName, String originalFileName, HttpServletResponse response) {
		try {
		    // 파일을 찾아 입력 스트림 생성
		    File file = new File(saveDirectory, saveFileName);  
		    InputStream inStream = new FileInputStream(file);
		    
		    // 한글 파일명 깨짐 방지
		    String client = request.getHeader("User-Agent");
		    if (client.indexOf("WOW64") == -1) {
		    	originalFileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
		    }
		    else {
		    	originalFileName = new String(originalFileName.getBytes("KSC5601"), "ISO-8859-1");
		    }
		   
		    // 파일 다운로드용 응답 헤더 설정 
		    response.reset();
		    response.setContentType("application/octet-stream");
		    response.setHeader("Content-Disposition", 
		                       "attachment; filename=\"" + originalFileName + "\"");
		    response.setHeader("Content-Length", "" + file.length() );
		
		    
		    // response 내장 객체로부터 새로운 출력 스트림 생성
		    OutputStream outStream = response.getOutputStream();  

		    // 출력 스트림에 파일 내용 출력
		    byte b[] = new byte[(int)file.length()];
		    int readBuffer = 0;    
		    while ( (readBuffer = inStream.read(b)) > 0 ) {
		        outStream.write(b, 0, readBuffer);
		    }

		    // 입/출력 스트림 닫음
		    inStream.close(); 
		    outStream.close();
		}
		catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
		    e.printStackTrace();
		}
	}
    
    
    // 파일 암호화 후 savePath 위치에 저장
    public void doEncrypt(String savePath) throws NoSuchAlgorithmException, InvalidKeySpecException {
    	String encoding = "utf-8";
    	
    	//PBE2 키값 만들기
    	char[] charPassword = password.toCharArray();	// 입력받은 비밀번호를 문자배열로
    	byte[] salt = new byte[8];						// 8비트 크기의 솔트값
    	int iterCount = 1000;							// 반복 횟수
    	
    	long currentTimeMillis = System.currentTimeMillis();
    	byte[] seed = ByteBuffer.allocate(Long.BYTES).putLong(currentTimeMillis).array();
    	
    	// 시드값 저장
    	seedValue = encodeSeedFromString(seed);
    	
    	SecureRandom random = new SecureRandom(seed);
    	random.nextBytes(salt);
    	
    	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
    	PBEKeySpec keySpec = new PBEKeySpec(charPassword, salt, iterCount, 128);
    	SecretKey secretKey = new SecretKeySpec(keyFactory.generateSecret(keySpec).getEncoded(), "AES");
    	
    	// 저장 시 파일 명 변경을 위해
    	int index = fileName.lastIndexOf(".");
		String fName = fileName.substring(0,index);
		String ext = fileName.substring(index);
		
		File file = new File(savePath + File.separator + fileName);
		File encryptFileData = new File(savePath + File.separator + fName + "_enc" + ext);
    	
		// 암호화 진행
		encryptFile(secretKey, file, encryptFileData);
		
		System.out.println("doEncrypt 완료");
    }
    
    // 파일 복호화 후 savePath 위치에 저장
    public boolean doDecrypt(String savePath, String seedText) throws NoSuchAlgorithmException, InvalidKeySpecException{
		String encoding = "utf-8";

		char[] charPassword = password.toCharArray();
		byte[] salt = new byte[8];						// 8비트 크기의 솔트값
		int iterCount = 1000;							// 반복 횟수

		// 저장 시 파일 명 변경을 위해
		int index = fileName.lastIndexOf(".");
		String fName = fileName.substring(0,index);
		String ext = fileName.substring(index);

		File file = new File(savePath + File.separator + fileName);

		File decryptFileData = new File(savePath + File.separator + fName + "_dec" + ext);

		// 생성 시 만들어졌던 seed로 호출
		SecureRandom random = new SecureRandom(decodeSeedFromString(seedText));
		random.nextBytes(salt);

		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		PBEKeySpec keySpec = new PBEKeySpec(charPassword, salt, iterCount, 128);
		SecretKey secretKey = new SecretKeySpec(keyFactory.generateSecret(keySpec).getEncoded(), "AES");

		return decryptFile(secretKey, file, decryptFileData);

    }
    
    public static String encodeSeedFromString(byte[] seed) {
        // 시드를 Base64로 인코딩하여 문자열로 반환
        return Base64.getEncoder().encodeToString(seed);
    }
    
    public static byte[] decodeSeedFromString(String encodedSeed) {
        // Base64로 인코딩된 문자열을 디코딩하여 바이트 배열을 얻음
        return Base64.getDecoder().decode(encodedSeed);
    }
    


    public static void main(String[] args) throws Exception{
        // TODO Auto-generated method stub

        // 키 생성
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(128);	// 128크기의 키를 생성

        SecretKey secretKey = keyGenerator.generateKey(); 	// 키 생성

        // 파일 가져오기
        File plainFile = new File("E:\\경민대학교\\2023 경민대학교\\2학기\\소프트웨어 개발 보안\\과제제출용테스트\\test.txt");

        // 암호화 파일 / 복호화 파일
        File encryptFileData = new File("E:\\경민대학교\\2023 경민대학교\\2학기\\소프트웨어 개발 보안\\과제제출용테스트\\encrypt.txt");
        File decryptFileData = new File("E:\\경민대학교\\2023 경민대학교\\2학기\\소프트웨어 개발 보안\\과제제출용테스트\\decrypt.txt");

        encryptFile(secretKey, plainFile, encryptFileData);
        decryptFile(secretKey, encryptFileData, decryptFileData);
    }


}
