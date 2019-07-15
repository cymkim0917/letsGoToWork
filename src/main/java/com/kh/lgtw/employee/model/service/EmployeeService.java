package com.kh.lgtw.employee.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.common.model.vo.Attachment;
import com.kh.lgtw.employee.model.exception.LoginException;
import com.kh.lgtw.employee.model.vo.Attendance;
import com.kh.lgtw.employee.model.vo.DeptVo;
import com.kh.lgtw.employee.model.vo.Employee;
import com.kh.lgtw.employee.model.vo.EmployeeResult;
import com.kh.lgtw.employee.model.vo.ExcelEmp;
import com.kh.lgtw.employee.model.vo.JobVo;

public interface EmployeeService {

	Employee loginCheck(Employee employee) throws LoginException;

	int insertEmpOne(Employee employee, Attachment attach, DeptVo dpVo, JobVo jobVo);

	int empExcelUpload(File destFile);

	List<ExcelEmp> xlsEmpInsert(MultipartHttpServletRequest request, MultipartFile excelFile);

	List<ExcelEmp> xlsxEmpInsert(MultipartHttpServletRequest request, MultipartFile excelFile, Attachment attach);

	List<String> selectEmpEamilForName(String sName);
	
	ArrayList<DeptVo> selectDeptList();
	
    int insertEmpQuick(Employee employee, DeptVo dpVo, JobVo jobVo, Attachment attach);
	
    ArrayList<EmployeeResult> selectEmpListAdmin(PageInfo pi);
	
    HashMap<String, Object> selectJopDeptAdmin();
	
	int getEmpListCount();
	
	int deleteEmpList(int empNo);
	
	int insertEmpOneNoAttach(Employee employee,DeptVo dpVo, JobVo jobVo);

	void dbEmpList(HttpServletResponse response);

	List<EmployeeResult> xlsEmpUpdate(MultipartHttpServletRequest request, MultipartFile excelFile);

	List<EmployeeResult> xlsxEmpUpdate(MultipartHttpServletRequest request, MultipartFile excelFile);

	HashMap<String, Object> selectEmpDeptJob(Employee employee);

	Attachment selectProfile(Employee employee);

	int updatePwdCheck(EmployeeResult employee);

	int updateEmpOne(EmployeeResult employee, Attachment attach);

	HashMap<String, Object> selectLevelCaptain();

	ArrayList<DeptVo> selectOrgDept();

	ArrayList<Attachment> selectAttachList();

	ArrayList<EmployeeResult> searchEmpUser(PageInfo pi, EmployeeResult employee);

	int getSearchEmpCount(EmployeeResult employee);

	ArrayList<EmployeeResult> allEmpList();

	int insertPrsnlManager(ArrayList<Object> empList);

	ArrayList<EmployeeResult> selectPrnlEmp();

	int deletePrsnlManager(ArrayList<Object> empList);

	ArrayList<EmployeeResult> selectEmpList(PageInfo pi);

	int checkEmpWork(Attendance attend);

	int insertEmpWork(Attendance attend);
  
	
	//휴가 추가 - 욱
	int holidayInsertAdmin();
	
	//휴가신청조회 - 욱
	ArrayList<HashMap<String, Object>> showHolidayApply(int empNo);
	
	//휴가 신청 - 욱
	int applyHoliday(HashMap<String, Object> params);
	
	//휴가 신청 리스트 조회 - 욱
	ArrayList<HashMap<String, Object>> getAdminHoliday(HashMap<String,Object> parmas);

	int insertLeaveEmp(ArrayList<Employee> list);

	ArrayList<EmployeeResult> selectLeaveEmpAdmin();

	int insertEmpOffWork(Attendance attend);

	int insertNoWork(Attendance attend);

	int checkEmpOffWork(Attendance attend);
	
	//휴가 상세 조회 - 욱
	ArrayList<HashMap<String, Object>> holidayDetail(HashMap<String, Object> params);
	//휴가 결제 - 욱
	int appHoliday(HashMap<String, Object> params);

	ArrayList<Attendance> selectAttendanceList(int empNo);


}
