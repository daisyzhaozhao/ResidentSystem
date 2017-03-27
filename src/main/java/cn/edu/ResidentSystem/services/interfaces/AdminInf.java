package cn.edu.ResidentSystem.services.interfaces;

import java.util.List;

import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.model.PageBean;

public interface AdminInf {
	public Admin select(String adminname);
	public int countAll(Admin admin);
	public List<Admin> query(Admin admin,PageBean page);
	public Admin getId(int id);
    public int insert(Admin admin);
    public void insertLogin(Login login);
    public Login selectByNo(String adminname);
}
