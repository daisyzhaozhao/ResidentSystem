package cn.edu.ResidentSystem.controller.base;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class ImportExportAction {
	
	public void exportExcel(HttpServletRequest request,
			HttpServletResponse response,String fileName) {
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/template/"+fileName);
			response.setContentType("application/vnd.ms-excel;charset=GBK");
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(fileName.getBytes("GBK"), "ISO8859_1"));
			OutputStream os = response.getOutputStream();
			File file = new File(path);
			FileInputStream fis = new FileInputStream(file);
			byte[] buffer = new byte[1024];
			int i = 0;
			while ((i = fis.read(buffer)) != -1) {
				os.write(buffer, 0, i);
			}
			fis.close();
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
