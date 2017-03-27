package cn.edu.ResidentSystem.controller.teacher;

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
import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.model.Teacher;
import cn.edu.ResidentSystem.others.LogOperation;
import cn.edu.ResidentSystem.services.impl.TeacherService;
import cn.edu.ResidentSystem.util.SameAdminException;

@Controller
public class TeacherManageController extends ImportExportAction{
	
	@Autowired
	TeacherService teacherService;
	
	@RequestMapping("/teachermanage")
	public String teacherManage(){
		
		return "/teacher/index";
	}
	
	@RequestMapping(value = "/teacher/list.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public String list(Teacher teacher,@RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model) {
		PageBean page = null;
		if(pageNumber != null) {
			page = new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);
		}

		//List<T> list = getService().query(query, page);
		Gson gson = new Gson();
		int size = teacherService.countAll(teacher);
		List<Teacher> list = teacherService.query(teacher,page);
		String json = gson.toJson(list);
		
		if(pageNumber != null) {
			json = "{\"rows\":" + json + ",\"total\":" + size + "}";
		}
		return json;
	}
	
	@RequestMapping(value = "/teacher/id{id}.do", produces = { "application/json;charset=utf-8" })
	@ResponseBody
	public Teacher getById(@PathVariable("id") int id) {
		Teacher bean = teacherService.getId(id);
		return bean;
	}
	
	@RequestMapping(value = "/teacher/uploadUserInfo.do", produces = { "application/html;charset=utf-8" })
	@ResponseBody
	@OptLog(operation = LogOperation.IMPORT_FILE, operationModule = LogOperation.TRAIN, ext = LogOperation.EXT_IMPORT_FILE)
	public String uploadJudge(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) throws RuntimeException {
		
		try {
			Msg msg = teacherService.importTeacher(file.getInputStream());
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
	
	@RequestMapping(value = "/teacher/exportTeacherExcel.do")  
	public void exportJudgeExcel(HttpServletRequest request,HttpServletResponse response){
	 	exportExcel(request, response, "teacher.xls");
	}	
	
}
