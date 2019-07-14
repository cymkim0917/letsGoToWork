package com.kh.lgtw.employee.model.vo;

import java.sql.Date;

public class Attendance {
	private Date attendanceDate;
	private int empNo;
	private String startTime;
	private String endTime;
	
	public Attendance() {}
	
	public Attendance(Date attendanceDate, int empNo, String startTime, String endTime) {
		super();
		this.attendanceDate = attendanceDate;
		this.empNo = empNo;
		this.startTime = startTime;
		this.endTime = endTime;
	}

	public Date getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(Date attendanceDate) {
		this.attendanceDate = attendanceDate;
	}

	public int getEmpNo() {
		return empNo;
	}

	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Override
	public String toString() {
		return "Attendance [attendanceDate=" + attendanceDate + ", empNo=" + empNo + ", startTime=" + startTime
				+ ", endTime=" + endTime + "]";
	}
	
}
