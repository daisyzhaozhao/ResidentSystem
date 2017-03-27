package cn.edu.ResidentSystem.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.entity.AdminMapper;
import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.services.interfaces.AdminInf;
@Service
public class AdminService implements AdminInf{
	@Autowired
	public AdminMapper adminMapper;
	@Override
	public Admin select(String adminname) {
		// TODO Auto-generated method stub 
		return adminMapper.selectByAdminName(adminname);
	}
	@Override
	public int countAll(Admin admin) {
		// TODO Auto-generated method stub 
		return adminMapper.countAll(admin);
	}
	@Override
	public List<Admin> query(Admin admin,PageBean page) {
		// TODO Auto-generated method stub
		return adminMapper.query(admin,page);
	}
	@Override
	public Admin getId(int id) {
		// TODO Auto-generated method stub
		return adminMapper.selectById(id);
	}
	@Override
	public int insert(Admin admin) {
		// TODO Auto-generated method stub
		return adminMapper.insert(admin);
	}
	@Override
	public void insertLogin(Login login) {
		adminMapper.insertLogin(login);
	}
	@Override
	public Login selectByNo(String adminname) {
		// TODO Auto-generated method stub
		return adminMapper.selectByNo(adminname);
	}

}
