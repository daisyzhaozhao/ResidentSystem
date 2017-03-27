package cn.edu.ResidentSystem.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import cn.edu.ResidentSystem.annotation.OptLog;
import cn.edu.ResidentSystem.controller.base.ImportExportAction;
import cn.edu.ResidentSystem.model.HeadTeaching;
import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.others.LogOperation;
import cn.edu.ResidentSystem.services.impl.HeadTeachingService;
import cn.edu.ResidentSystem.util.SameAdminException;

@Controller
public class HeadOfTeachingController extends ImportExportAction{
	
	@Autowired
	HeadTeachingService headTeachingService;
	
	@RequestMapping("/headofteaching")
	public String headOfTeaching(){
		
		return "/headteaching/index";
		
	}
	
	@RequestMapping(value = "/headteaching/list.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String list(HeadTeaching headTeaching,@RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model) {
		PageBean page = null;
		if(pageNumber != null){
			page = new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);
		}

		//List<T> list = getService().query(query, page);
		Gson gson = new Gson();
		int size = headTeachingService.countAll(headTeaching);
		List<HeadTeaching> list = headTeachingService.query(headTeaching,page);
		String json = gson.toJson(list);
		
		if(pageNumber != null) {
			json = "{\"rows\":" + json + ",\"total\":" + size + "}";
		}
		return json;
	}
	
	@RequestMapping(value = "/headteaching/uploadUserInfo.do", produces = { "application/html;charset=utf-8" })
	@ResponseBody
	@OptLog(operation = LogOperation.IMPORT_FILE, operationModule = LogOperation.TRAIN, ext = LogOperation.EXT_IMPORT_FILE)
	public String uploadJudge(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) throws RuntimeException {
		
		try {
			Msg msg = headTeachingService.importExcel(file.getInputStream());
			msg.setState(1);
			return new Gson().toJson(msg);
		}catch(SameAdminException m){
			m.printStackTrace();
			return new Gson().toJson(new Msg(0,"该用户名已存在！")); 
		} catch (Exception e) {
			e.printStackTrace();
			return new Gson().toJson(new Msg(0,8));
		}

	}
	
	@RequestMapping(value = "/headteaching/exportUserExcel.do")  
	public void exportJudgeExcel(HttpServletRequest request,HttpServletResponse response){
	 	exportExcel(request, response, "teachAdmin.xls");
	}	
	
	
}
