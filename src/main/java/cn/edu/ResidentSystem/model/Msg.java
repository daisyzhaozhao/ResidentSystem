package cn.edu.ResidentSystem.model;

public class Msg {
	/**
	 * 行定位
	 */
	private int row;
	/**
	 * 具体错误定位
	 */
	private int msg;
	
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getMsg() {
		return msg;
	}
	public void setMsg(int msg) {
		this.msg = msg;
	}
	public Msg() {
		super();
	}
	public Msg(int row, int msg) {
		super();
		this.row = row;
		this.msg = msg;
	}
	
	/**
	 * 返回信息状态码
	 */
	private int state=0;
	/**
	 * 具体错误信息
	 */
	private String errorMsg;
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
	public Msg(int state, String errorMsg) {
		this.state = state;
		this.errorMsg = errorMsg;
	}
}
