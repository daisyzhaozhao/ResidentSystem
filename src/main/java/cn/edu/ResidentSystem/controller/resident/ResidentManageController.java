package cn.edu.ResidentSystem.controller.resident;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.others.LogOperation;
import cn.edu.ResidentSystem.services.impl.AdminService;
import cn.edu.ResidentSystem.services.interfaces.ResidencyInf;

@Controller
public class ResidentManageController {
	@Autowired
	AdminService adminServer;
	
	@Autowired
	ResidencyInf residencyInf;
	
	
	@RequestMapping("/residentmanage")
    public String residentManage(){
    	
		return "/resident/index";	
    }
	
	
	@RequestMapping(value = "/resident/list.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String list(@RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model) {
		PageBean page = null;
		if(pageNumber != null) {
			page = new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);
		}

		//List<T> list = getService().query(query, page);
		Gson gson = new Gson();
		int size = adminServer.countAll();
		List<Admin> list = adminServer.query(page);
		String json = gson.toJson(list);
		
		if(pageNumber != null) {
			json = "{\"rows\":" + json + ",\"total\":" + size + "}";
		}
		return json;
	}
	
	@RequestMapping(value = "/resident/id{id}.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public Admin getById(@PathVariable("id") int id) {
		Admin bean = adminServer.getId(id);
		return bean;
	}
	

	@RequestMapping(value = "/uploadResidency.do", produces = { "application/html;charset=utf-8" })
	@ResponseBody
	@OptLog(operation = LogOperation.IMPORT_FILE, operationModule = LogOperation.TRAIN, ext = LogOperation.EXT_IMPORT_FILE)
	public String uploadResidency(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) throws RuntimeException {
		
		try {
			Msg msg = residencyInf.importExcel(file.getInputStream());
			return new Gson().toJson(msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new Gson().toJson(new Msg(0,8));
		}

	}
}
