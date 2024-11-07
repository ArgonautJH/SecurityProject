package bean;

import java.nio.file.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FolderFileABS {
	private String folderPath;	// 폴더 경로
	private List<Path> fileList;	// 파일리스트
	private String password;
	
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPassword() {
		return password;
	}
	
	public String getFolderPath() {
		return folderPath;
	}
	
	public void setFolderPath(String folderPath) {
		this.folderPath = folderPath;
	}
	
	public List<Path> getFileList() {
		return fileList;
	}

	private void searchFileList() {
		fileList = new ArrayList<>();
		
		try {
            Files.walk(Paths.get(folderPath))
                    .filter(Files::isRegularFile)
                    .forEach(fileList::add);
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		// fileList에는 폴더 내의 모든 파일의 경로가 저장됩니다.
        for (Path path : fileList) {
            System.out.println("File: " + path.getFileName());
        }
	}
	
	//시드값을 파일에 저장하는 역할
	private static void saveSeedToFile(String seedFilePath, String seedValue) {
        try (FileWriter writer = new FileWriter(seedFilePath, true)) {
            // 시드값을 텍스트 파일에 추가
            writer.write(seedValue + System.lineSeparator());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	public boolean doFolderEncrypt() {
		searchFileList();
		
		ABSAlogorithm absAlgorithm = new ABSAlogorithm();
		
		// 시드값을 저장할 텍스트 파일 경로
        String seedFilePath = folderPath + File.separator + "seeds.txt";
        
     // 각 파일에 대해 암호화 및 시드값 저장
        for (Path filePath : fileList) {
            absAlgorithm.setFileName(filePath.getFileName().toString());
            absAlgorithm.setPassword(password); // 암호화에 사용할 비밀번호 설정

            try {
                // 암호화 수행
                absAlgorithm.doEncrypt(folderPath);

                // 시드값을 텍스트 파일에 추가
                saveSeedToFile(seedFilePath, absAlgorithm.getSeedValue());
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        
        return true;
	}
	
	// 폴더 내 파일을 시드값을 참고하여 복호화하는 메소드
	public boolean doFolderDecrypt() {
	    searchFileList();

	    ABSAlogorithm absAlgorithm = new ABSAlogorithm();

	    // seeds.txt 파일 경로
	    String seedFilePath = folderPath + File.separator + "seeds.txt";
	    
	    System.out.println(seedFilePath);

	    try (BufferedReader reader = new BufferedReader(new FileReader(seedFilePath))) {
	        String seedValue;
	        int index = 0;

	        // 각 파일에 대해 반복
	        for (Path filePath : fileList) {
	            String fileName = filePath.getFileName().toString();

	            int i = fileName.lastIndexOf(".");
	            String fName = fileName.substring(0, i);

	            // 파일 이름이 "_enc"로 끝나는지 확인
	            if (fName.endsWith("_enc")) {
	                absAlgorithm.setFileName(fileName);
	                absAlgorithm.setPassword(password);

	                // seeds.txt에서 시드값 읽기
	                seedValue = reader.readLine();

	                // 각 파일에 대해 시드값이 있는지 확인
	                if (seedValue != null) {
	                    try {
	                        // 시드값을 이용하여 파일 복호화
	                        boolean result = absAlgorithm.doDecrypt(folderPath, seedValue);
	                        
	                        if(result == false) {
	                        	return false;
	                        }

	                        System.out.println("파일 복호화 성공: " + fileName);
	                    } catch (Exception e) {
	                        System.out.println("파일 복호화 중 오류 발생: " + fileName);
	                        e.printStackTrace();
	                        return false; // 복호화 실패 시 false 반환
	                    }
	                } else {
	                    System.out.println("파일에 대한 시드값이 없음: " + fileName);
	                    return false; // 시드값이 없을 때 false 반환
	                }
	            }

	            index++;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false; // 예외 발생 시 false 반환
	    }

	    return true; // 모든 파일에 대한 복호화 성공 시 true 반환
	}
	
	
	public static void main(String[] args) {
		FolderFileABS a = new FolderFileABS();
		String path = "E:\\경민대학교\\2023 경민대학교\\2학기\\소프트웨어 개발 보안\\test";
		a.setFolderPath(path);
		a.searchFileList();
		
		a.setPassword("111");
		
//		a.doFolderEncrypt();
		
//		a.doFolderDecrypt();
	}
}
