package cn.edu.ResidentSystem.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import cn.edu.ResidentSystem.annotation.OptLog;
import cn.edu.ResidentSystem.controller.base.ImportExportAction;
import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.model.Secretary;
import cn.edu.ResidentSystem.others.LogOperation;
import cn.edu.ResidentSystem.services.impl.SecretaryService;
import cn.edu.ResidentSystem.util.SameAdminException;

@Controller
public class TeachingSecretaryAndDirectorController extends ImportExportAction {
	@Autowired
	public SecretaryService secretaryService;
	
	@RequestMapping("/teachingsecretary")
	public String teachingSecretaryAndDirector(){
		
		return "/teaching/index";
		
	}
	
	@RequestMapping(value = "/teaching/allList.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String allList(Secretary query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model) {
		PageBean page = null;
		if(pageNumber != null) {
			page = new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);
		}
		Gson gson = new Gson();
		int size = secretaryService.countAll(query);
		List<Secretary> list = secretaryService.querySecretary(query,page);
		String json = gson.toJson(list);
		
		if(pageNumber != null) {
			json = "{\"rows\":" + json + ",\"total\":" + size + "}";
		}
		return json;
	}
	
	@RequestMapping(value = "/teaching/uploadTeaching.do", produces = { "application/html;charset=utf-8" })
	@ResponseBody
	@OptLog(operation = LogOperation.IMPORT_FILE, operationModule = LogOperation.TRAIN, ext = LogOperation.EXT_IMPORT_FILE)
	public String uploadJudge(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) throws RuntimeException {
		
		try {
			Msg msg = secretaryService.importTeaching(file.getInputStream());
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
	
	@RequestMapping(value = "/teaching/id{id}.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public Secretary getById(@PathVariable("id")int id) {
		Secretary secretary = secretaryService.selectById(id);
		return secretary;
	}
	
	@RequestMapping(value = "/teaching/exportTeachingExcel.do")  
	public void exportJudgeExcel(HttpServletRequest request,HttpServletResponse response){
	 	exportExcel(request, response, "secretary.xls");
	}	
}
