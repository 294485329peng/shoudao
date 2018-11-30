/**
 * Copyright2015-2019 daiwk All Rights Reserved.
 */
package com.wp.base.sys.sys_file.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wp.common.RetObj;
import com.wp.common.service.ConfigService;

/**
 * @ClassName: SysFileController
 * @Description: 文件管理：上传、下载、文件表操作
 * @author:daiwk 
 * @date: 2015年10月10日上午8:50:22
 */
@Controller
@RequestMapping("/sysFile")
public class SysFileController {

/*	@Autowired
	private IOmOrganizationService omOrganizationService;*/

	@PostConstruct
	public void init() throws ServletException {
		String tempDir = ConfigService.getConfig(ConfigService.TMP_DIR);
		String uploadDir = ConfigService.getConfig(ConfigService.UPLOAD_DIR);
		if (!new File(tempDir).exists()) {
			new File(tempDir).mkdirs();
		}
		if (!new File(uploadDir).exists()) {
			new File(uploadDir).mkdirs();
		}
	}
	
	@RequestMapping("/forDemo")
	public String forDemo() {
		return "base/sys/sys_file/sys_file_forDemo";
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param chunk分割块数
	 * @param chunks总分割数
	 * @param uuid分割时防止几个人同时上传相同文件名的文件
	 * 
	 * @return
	 */
	@RequestMapping(value = "batchUpload", method = RequestMethod.POST)
	@ResponseBody
	public RetObj batchUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam ArrayList<MultipartFile> multipartFiles,
			Integer chunk, Integer chunks, String uuid) {

		String name = null;// 文件名
		try {
			String newFileName = null;
			for (MultipartFile multipartFile : multipartFiles) {
				name = multipartFile.getOriginalFilename();
				newFileName = UUID.randomUUID().toString().replace("-", "").concat(".").concat(FilenameUtils.getExtension(name));
				String nFname = newFileName;
				if (chunk != null) {
					nFname = uuid + "_" + chunk + "_" + name;
				}
				File savedFile = new File(ConfigService.getConfig(ConfigService.TMP_DIR), nFname);
				multipartFile.transferTo(savedFile);

				if (chunk != null && chunk + 1 == chunks) {
					try (BufferedOutputStream outputStream = new BufferedOutputStream(new FileOutputStream(new File(
							ConfigService.getConfig(ConfigService.TMP_DIR), newFileName)));) {
						// 遍历文件合并
						for (int i = 0; i < chunks; i++) {
							File tempFile = new File(ConfigService.getConfig(ConfigService.TMP_DIR), uuid + "_" + i + "_" + name);
							byte[] bytes = FileUtils.readFileToByteArray(tempFile);
							outputStream.write(bytes);
							outputStream.flush();
							tempFile.delete();
						}
						outputStream.flush();
					}
				}
			}

			int size = 0;

			try (FileInputStream inputStream = new FileInputStream(new File(ConfigService.getConfig(ConfigService.TMP_DIR), newFileName));) {
				size = inputStream.available() / 1024;
			} catch (FileNotFoundException ex) {
				// 因文件分片此处可能报nofilefound异常 忽略
				// ex.printStackTrace();
			}
			Map fileMap = new HashMap();
			fileMap.put("fileName", name);
			fileMap.put("newFileName", newFileName);
			fileMap.put("size",size);
			RetObj r = new RetObj(true, "",fileMap);
			return r;
		} catch (Exception e) {
			e.printStackTrace();
			return new RetObj(false, "");
		}
	}
}
