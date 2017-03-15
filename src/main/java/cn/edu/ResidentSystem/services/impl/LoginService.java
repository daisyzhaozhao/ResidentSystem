package cn.edu.ResidentSystem.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.entity.LoginMapper;
import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.services.interfaces.LoginInf;
@Service
public class LoginService implements LoginInf{
	
	@Autowired
	public LoginMapper loginMapper;

	@Override
	public Login select(String adminname) {
		// TODO Auto-generated method stub
		return loginMapper.selectByLoginName(adminname);
	}

}
