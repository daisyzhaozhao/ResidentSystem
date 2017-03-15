package cn.edu.ResidentSystem.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.entity.AdminMapper;
import cn.edu.ResidentSystem.model.Admin;
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
	public int countAll() {
		// TODO Auto-generated method stub
		return adminMapper.countAll();
	}
	@Override
	public List<Admin> query(PageBean page) {
		// TODO Auto-generated method stub
		return adminMapper.query(page);
	}
	@Override
	public Admin getId(int id) {
		// TODO Auto-generated method stub
		return adminMapper.selectById(id);
	}

}
