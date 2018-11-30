package test.upload;

import java.util.Map;
import com.wp.project.background.PicUpload.service.PicUploadServiceImpl;

public class pic_test {
	public static void main(){
		PicUploadServiceImpl pic = new PicUploadServiceImpl();
		String MEDIA_ID = "1";
		Map record = pic.get(MEDIA_ID);
		
		
	}
}
