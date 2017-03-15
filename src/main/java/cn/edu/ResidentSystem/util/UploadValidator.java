package cn.edu.ResidentSystem.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;

import cn.edu.ResidentSystem.model.Msg;
import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.NumberCell;

public class UploadValidator {
	/**
	 * 返回成功信息状态码
	 */
	public static final int SUCCESS=1;
	/**
	 * 返回失败状态码
	 */
	public static final int FAIL=-1;
	/**
	 * 手机号校验正则
	 */
	public static final String PhoneReg="1([\\d]{10})|((\\+[0-9]{2,4})?\\(?[0-9]+\\)?-?)?[0-9]{7,8}";
	/**
	 * 身份证校验正则
	 */
	public static final String IDCardReg="(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])|([a-zA-Z][0-9]{9})";
	/**
	 * 年级校验格式正则
	 */
	public static final String GradeReg="[0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3}";
	/**
	 * 邮箱校验正则
	 */
	public static final String EmailReg="^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
	/**
	 * 年资校验正则
	 */
	public static final String YearCapitalReg="^[1-3]{1}$";
	/**
	 * 错误信息提示<br/>
	 * error0:必填项不能为空！<br/>
	 * error1:手机号输入格式有误！<br/>
	 * error2:身份证号格式输入有误！<br/>
	 * error3:年级格式输入有误!<br/>
	 * error4:时间格式不正确!<br/>
	 * error5:导入人员身份不符！<br/>
	 * error6:身份证已存在，无法导入！<br/> 
	 * error7:邮箱格式不正确<br/>
	 * error8:此专业不存在！<br/>
	 * error9:导入失败，身份不匹配!<br/>
	 * error10:无法执行修改操作，请重新校验后上传！<br/>
	 * error11:上传文件不合法，请核对后重新上传!<br/>
	 * error12:年资输入不合法，正确范围为1-3年!<br/>
	 */
	public static final Map<String,String> ErrorList=new HashMap<String,String>(){
		private static final long serialVersionUID = 1L;
		{
			put("Null","必填项不能为空！");
			put("error1","手机号输入格式有误！");
			put("error2","身份证号格式输入有误！");
			put("error3","年级格式输入有误!");
			put("error4","时间格式不正确!");
			put("error5","导入人员身份不符！");
			put("error6","身份证已存在，无法导入！");
			put("error7","邮箱格式不正确！");
			put("error8","此专业不存在！");
			put("error9","导入失败，身份不匹配");
			put("error10","无法执行修改操作，请重新校验后上传！");
			put("error11", "上传文件不合法，请核对后重新上传！");
			put("error12", "年资输入不合法，正确范围为1-3年!");
		}
	};
	/**
	 * 校验手机号格式
	 * @param phone
	 * @return 若成功返回null，若不匹配，返回状态码和状态信息的Msg对象
	 */
	public static Msg IsPhone(String phone){
		if(phone!=null&&!phone.equals("")){
			if(Pattern.matches(UploadValidator.PhoneReg,phone)){
				return null;
			}else{
				return new Msg(UploadValidator.FAIL,ErrorList.get("error1"));
			}
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
	/**
	 * 校验身份证信息
	 * @param IDCard
	 * @return 若成功返回null，若不匹配，返回状态码和状态信息的Msg对象
	 */
	public static Msg IsIDCard(String IDCard){
		if(IDCard!=null && !IDCard.equals("")){
			if(Pattern.matches(UploadValidator.IDCardReg,IDCard)){
				return null;
			}else{
				return new Msg(UploadValidator.FAIL,ErrorList.get("error2"));
			}
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
	/**
	 * 年级格式校验
	 * @param Grade
	 * @return 若成功返回null，若不匹配，返回状态码和状态信息的Msg对象
	 */
	public static Msg IsGrade(String Grade){
		if(Grade!=null && !Grade.equals("")){
			if(Pattern.matches(UploadValidator.GradeReg,Grade)){
				return null;
			}else{
				return new Msg(UploadValidator.FAIL,ErrorList.get("error3"));
			}
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
	/**
	 * 校验非空
	 * @param str
	 * @return 若成功返回null，若不匹配，返回状态码和状态信息的Msg对象
	 */
	public static Msg IsNull(String str){
		if(str!=null && !str.equals("")){
			return null;
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
	public static Msg IsEmail(String email){
		if(email!=null && !email.equals("")){
			if(Pattern.matches(UploadValidator.EmailReg,email)){
				return null;
			}else{
				return new Msg(UploadValidator.FAIL,ErrorList.get("error7"));
			}
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
	/**
	 * 判断一个单元格是否为日期.<br/>
	  * format1:yyyy年MM月dd日  HH:mm:ss<br/>
		 * format2:yyyy年MM月dd日  HH:mm<br/>
		 * format3:yyyy年MM月dd日  HH<br/>
		 * format4:yyyy年MM月dd日<br/>
		
		 * format5:yyyy-MM-dd HH:mm:ss<br/>
		 * format6:yyyy-MM-dd HH:mm<br/>
		 * format7:yyyy-MM-dd HH<br/>
		 * format8:yyyy-MM-dd<br/>
		
		 * format9:yyyy/MM/dd HH:mm:ss<br/>
		 * format10:yyyy/MM/dd HH:mm<br/>
		 * format11:yyyy/MM/dd HH<br/>
		 * format12:yyyy/MM/dd<br/>
		
		 * format13:yyyyMMdd HH:mm:ss<br/>
		 * format14:yyyyMMdd HH:mm<br/>
		 * format15:yyyyMMdd HH<br/>
		 * format16:yyyyMMdd
		 * 
		 * format17：yyyyMM<br/>
		 * format18：yyyy/MM<br/>
	 	 * format19：yyyy-MM<br/>
	 	 * format20：yyyy年MM月
		 * @param cell( Jxl接口类型的cell )
		 * @param fmt
		 * @return 若为日期则按fmt格式输出日期，否则输出null
	 */
	public static String CellIsDate(Cell cell,String fmt){
		
		try{
         	if(cell.getType()== CellType.DATE){
         		DateCell dc = (DateCell)cell;
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(dc.getDate(), fmt));
            }else if(Pattern.matches(DateValidator.DateReg, cell.getContents().trim())){
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(cell.getContents().trim(),fmt));
            }else if(cell instanceof NumberCell){
            	NumberCell nc=(NumberCell)cell;
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(HSSFDateUtil.getJavaDate(nc.getValue()), fmt));
            }else{
            	return null;
            }
         }catch(Exception e){
        	 e.printStackTrace();
        	 return null;
         }
	}
	/**
	 * 判断一个单元格是否为日期.<br/>
	  * format1:yyyy年MM月dd日  HH:mm:ss<br/>
		 * format2:yyyy年MM月dd日  HH:mm<br/>
		 * format3:yyyy年MM月dd日  HH<br/>
		 * format4:yyyy年MM月dd日<br/>
		
		 * format5:yyyy-MM-dd HH:mm:ss<br/>
		 * format6:yyyy-MM-dd HH:mm<br/>
		 * format7:yyyy-MM-dd HH<br/>
		 * format8:yyyy-MM-dd<br/>
		
		 * format9:yyyy/MM/dd HH:mm:ss<br/>
		 * format10:yyyy/MM/dd HH:mm<br/>
		 * format11:yyyy/MM/dd HH<br/>
		 * format12:yyyy/MM/dd<br/>
		
		 * format13:yyyyMMdd HH:mm:ss<br/>
		 * format14:yyyyMMdd HH:mm<br/>
		 * format15:yyyyMMdd HH<br/>
		 * format16:yyyyMMdd
		 * 
		 * format17：yyyyMM<br/>
		 * format18：yyyy/MM<br/>
	 	 * format19：yyyy-MM<br/>
	 	 * format20：yyyy年MM月
		 * @param cell(poi接口类型的cell)
		 * @param fmt
		 * @return 若为日期则按fmt格式输出日期，否则输出null
	 */
	public static String CellIsDate(org.apache.poi.ss.usermodel.Cell cell, String fmt) {
		// TODO Auto-generated method stub
		try{
			if(cell.getCellType() == org.apache.poi.ss.usermodel.Cell.CELL_TYPE_NUMERIC){
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(HSSFDateUtil.getJavaDate(cell.getNumericCellValue()), fmt));
            }else if(Pattern.matches(DateValidator.DateReg, cell.getStringCellValue().trim())){
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(cell.getStringCellValue().trim(),fmt));
            }else if(HSSFDateUtil.isCellDateFormatted(cell)){
            	return StringUtils.trimToNull(DateValidator.ChangeDateFormat(cell.getDateCellValue(),fmt));
            }else {
            	return null;
            }
         }catch(Exception e){
        	 e.printStackTrace();
        	 return null;
         }
	}
	public static Msg IsYearCapital(String YearCapital){
		if(YearCapital!=null && !YearCapital.equals("")){
			if(Pattern.matches(UploadValidator.YearCapitalReg,YearCapital)){
				return null;
			}else{
				return new Msg(UploadValidator.FAIL,ErrorList.get("error12"));
			}
		}else{
			return new Msg(UploadValidator.FAIL,ErrorList.get("Null"));
		}
	}
}
