package cn.edu.ResidentSystem.model;

public class Login {
	 private String adminname;

	 private String adminpass;
	 
	 private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id; 
	}

	public String getAdminname() {
		return adminname;
	}

	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}

	public String getAdminpass() {
		return adminpass;
	}

	public void setAdminpass(String adminpass) {
		this.adminpass = adminpass;
	}
}
