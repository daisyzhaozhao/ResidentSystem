package cn.edu.ResidentSystem.services.impl;

import java.io.File;
import java.io.InputStream;

import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.model.Msg;
import cn.edu.ResidentSystem.services.interfaces.ResidencyInf;
import jxl.Workbook;

@Service
public class ResidentService implements ResidencyInf{
	

	@Override
	public Msg importExcel(InputStream in) throws RuntimeException, Exception {
		// TODO Auto-generated method stub
		Msg msg=null;
		String rolMsg="";
		Workbook book = null;
		
		
		
		
		
		return msg;
		
	}
}
