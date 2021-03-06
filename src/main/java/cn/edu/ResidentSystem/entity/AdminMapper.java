package cn.edu.ResidentSystem.entity;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.ResidentSystem.model.Admin;
import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.model.PageBean;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer adminno);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer adminno);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);

	Admin selectByAdminName(String adminname);
	
	int countAll(@Param("admin")Admin admin);
	
	List<Admin> query(@Param("admin")Admin admin,@Param("page")PageBean page);
	
	Admin selectById(int id);
	
	Login selectByNo(String adminname);
	
	void insertLogin(@Param("login")Login login);
}