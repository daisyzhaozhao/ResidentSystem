package cn.edu.ResidentSystem.services.impl;

import java.io.InputStream;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.CourseSubject;
import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.services.interfaces.ResidentInf;
import cn.edu.ResidentSystem.util.SameAdminException;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

@Service
public class ResidentService implements ResidentInf{
	@Autowired
	AdminService adminServer;
	@Autowired
	CourseSubjectService courseSubjectService;

	@Override
	public Msg importExcel(InputStream in) throws RuntimeException,SameAdminException, Exception {
		// TODO Auto-generated method stub
		Msg msg=new Msg();
		Workbook book = Workbook.getWorkbook(in);
	            // 获得第一个工作表对象
        Sheet sheet = book.getSheet(0);
        int rows=sheet.getRows();
        //int columns=sheet.getColumns();
        Admin admin = null;
        for(int i=1;i<rows;i++){
        	//北卫生局学员编号	身份类别	工号	密码	姓名	类别	学员状态	性别	学历	所属单位	手机	身份证号	毕业院校	最高学位	是否执业医师	在培学科	录取志愿	培训年限	纳入培训时间
            Cell[] row = sheet.getRow(i);
            if (StringUtils.isEmpty(row[2].getContents().trim()) || StringUtils.isEmpty(row[11].getContents().trim())) {
            	continue;
            }
            admin= new Admin();
            int j = 0;
            admin.setIdentity(row[j++].getContents());
            Login login = new Login();
            //调用表login，查看对比是否存在相同的账号密码
            String str = row[j++].getContents();
            //login.setAdminname(row[j++].getContents());
            String adminname = null;
            if(adminServer.selectByNo(str) != null){
            	adminname = adminServer.selectByNo(str).getAdminname();
            }
            if(str.equals(adminname)){
            	throw new SameAdminException("该用户名已存在！");
            }else{
            	login.setAdminname(str);
            }
            login.setAdminpass(row[j++].getContents());
            admin.setName(row[j++].getContents());
            admin.setStudentState(row[j++].getContents());
            admin.setSex(row[j++].getContents());
            admin.setEducation(row[j++].getContents());
            admin.setOffice(row[j++].getContents());
            admin.setPhoneNum(row[j++].getContents());
            admin.setIdCard(row[j++].getContents());
            admin.setGraduateInstitutions(row[j++].getContents());
            admin.setMaxGraduate(row[j++].getContents());
            String yorndoctor=row[j++].getContents();
            if("是".equals(yorndoctor)){
            	admin.setYorndoctor("1");
            }else{
            	admin.setYorndoctor("0");
            }
            String name = row[j++].getContents();
            System.out.println(name);
            CourseSubject courseSubject = courseSubjectService.getSubjectByName(name);
            if(courseSubject != null){
            	admin.setMajor(courseSubject.getId());
            }else{
            	throw new RuntimeException("未找到在陪学科");
            }
            admin.setTrainyear(row[j++].getContents());
            String train = row[j++].getContents();
            if("在培".equals(train)){
            	admin.setTrainState("1");
            }else if("毕业".equals(train)){
            	admin.setTrainState("2");
            }else if("暂停培训".equals(train)){
            	admin.setTrainState("3");
            }else if("退出培训".equals(train)){
            	admin.setTrainState("--");
            }
            
            admin.setGrade(row[j++].getContents());
            admin.setCareer(row[j++].getContents());
            admin.setCompany(row[j++].getContents());
            
            //存入数据库
            adminServer.insertLogin(login);
            //测试
            //System.out.println("&&&&&&&&&&"+login.getAdminname());
            //adminServer.selectByNo(login.getAdminname());
            //从login表中查询自增的id设置到admin表中
           // System.out.println("&&&&&&"+adminServer.selectByNo(login.getAdminname()).getId());
            admin.setLogin_id(adminServer.selectByNo(login.getAdminname()).getId());
            adminServer.insert(admin);
        }    
		
		return msg;
		
	}
}
