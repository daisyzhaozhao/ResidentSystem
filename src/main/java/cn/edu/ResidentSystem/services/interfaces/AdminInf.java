package cn.edu.ResidentSystem.services.interfaces;

import java.util.List;

import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.PageBean;

public interface AdminInf {
	public Admin select(String adminname);
	public int countAll();
	public List<Admin> query(PageBean page);
	public Admin getId(int id);

}
