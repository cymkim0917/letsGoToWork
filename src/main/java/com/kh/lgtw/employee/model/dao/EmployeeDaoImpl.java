package com.kh.lgtw.employee.model.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.common.model.vo.Attachment;
import com.kh.lgtw.employee.model.exception.LoginException;
import com.kh.lgtw.employee.model.util.ExcelRead;
import com.kh.lgtw.employee.model.util.ExcelReadOption;
import com.kh.lgtw.employee.model.vo.Attendance;
import com.kh.lgtw.employee.model.vo.DeptHistory;
import com.kh.lgtw.employee.model.vo.DeptVo;
import com.kh.lgtw.employee.model.vo.Employee;
import com.kh.lgtw.employee.model.vo.EmployeeResult;
import com.kh.lgtw.employee.model.vo.ExcelEmp;
import com.kh.lgtw.employee.model.vo.JobVo;
import com.kh.lgtw.employee.model.vo.PromotionHistory;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{
	
	// 로그인 확인
	@Override
	public Employee loginCheck(SqlSession sqlSession, Employee employee) throws LoginException {
		return sqlSession.selectOne("Employee.loginCheck", employee);
	}
	
	// 비밀번호 확인
	@Override
	public String selectEncPassword(SqlSession sqlSession, Employee employee) {
		return sqlSession.selectOne("Employee.selectEncPassword", employee);
	}
	
	// 사원추가
	@Override
	public int inSertEmpOne(SqlSession sqlSession, Employee employee) {
		return sqlSession.insert("Employee.insertEmpOne",employee);
	}

	@Override
	public int empExcelUpload(SqlSession sqlSession, File destFile) {
		
		
		ExcelReadOption excelReadOption = new ExcelReadOption();
		
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		
		excelReadOption.setOutputColums("아이디","비밀번호","이름","생년월일","성별","핸드폰번호","주소","이메일");
		
		excelReadOption.setStartRow(2);
		
		List<Map<String,String>>excelContent = ExcelRead.read(excelReadOption);
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("excelContent", excelContent);
		
		System.out.println("엑셀:"+paramMap.toString());
		
		return sqlSession.insert("ExcelEmp.insertEmpExcel",paramMap);
	}

	@Override
	public List<ExcelEmp> excelEmpInsert(SqlSession sqlSession, List<ExcelEmp> list, Attachment attach) {
		
		for(int i = 0; i<list.size(); i++) {
			System.out.println("포문시작");
			sqlSession.insert("ExcelEmp.insertEmpExcel", list.get(i));
			sqlSession.insert("Employee.insertEmpProfile", attach);
			sqlSession.insert("ExcelEmp.insertexcelEmpDept", list.get(i));
			sqlSession.insert("ExcelEmp.insertexcelEmpJob", list.get(i));
		}
		
		System.out.println("포문완료");
		
		return list;
	}

	// 사원이름으로 이메일 찾기 
	@Override
	public List<String> selectEmpEmailForName(SqlSession sqlSession, String sName) {
		return sqlSession.selectList("Employee.selectEmpEmailForName", sName);
	}

	@Override
	public ArrayList<DeptVo> selectDeptList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.selectDeptList");
	}


	@Override
	public int insertEmpQuick(SqlSession sqlSession, Employee employee) {
		return sqlSession.insert("Employee.insertEmpQuick", employee);
	}

	@Override
	public int insertDeptHistory(SqlSession sqlSession, DeptVo dpVo, JobVo jobVo) {
		sqlSession.insert("Employee.insertJobHistory", jobVo);
		return sqlSession.insert("Employee.insertDeptHistory", dpVo);
	}

	@Override
	public ArrayList<EmployeeResult> selectEmpListAdmin(SqlSession sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Employee.selectEmpListAdmin",null,rowBounds);
	}


	@Override
	public ArrayList<JobVo> selectJobAdmin(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.selectJobAdmin");
	}

	@Override
	public int insertEmpProfile(SqlSession sqlSession, Attachment attach) {
		return sqlSession.insert("Employee.insertEmpProfile", attach);
	}

	@Override
	public int getEmpListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("Employee.selectEmpListCount");
	}

	@Override
	public int deleteEmpList(SqlSession sqlSession, int empNo) {
		return sqlSession.update("Employee.deleteEmpList", empNo);
	}

	@Override
	public ArrayList<EmployeeResult> dbEmpList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.dbEmpList");
	}

	@Override
	public List<EmployeeResult> excelEmpUpdate(SqlSession sqlSession, List<EmployeeResult> list) {
		
		for(int i = 0; i<list.size(); i++) {
			System.out.println("포문시작");
			sqlSession.update("Employee.updateEmpExcel", list.get(i));
			sqlSession.update("Employee.updateExcelDept", list.get(i));
			sqlSession.update("Employee.updateExcelJob", list.get(i));
		}
		
		
		
		System.out.println("포문완료");
		
		return list;
	}

	@Override
	public PromotionHistory selectEmpJob(SqlSession sqlSession, Employee employee) {
		return sqlSession.selectOne("Employee.selectEmpJob", employee);
	}

	@Override
	public DeptHistory selectEmpDept(SqlSession sqlSession, Employee employee) {
		return sqlSession.selectOne("Employee.selectEmpDept", employee);
	}

	@Override
	public Attachment selectProfile(SqlSession sqlSession, Employee employee) {
		return sqlSession.selectOne("Employee.selectProfile", employee);
	}

	@Override
	public String selectUpCheckPwd(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.selectOne("Employee.selectUpCheckPwd",employee);
	}

	@Override
	public int updateEmpOne(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.update("Employee.updateEmpOne", employee);
	}

	@Override
	public int updateEmpOneDept(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.update("Employee.updateEmpOneDept", employee);
	}

	@Override
	public int updateEmpOneJob(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.update("Employee.updateEmpOneJob", employee);
	}

	@Override
	public void updateEmpAttach(SqlSession sqlSession, Attachment attach) {
		sqlSession.update("Employee.updateEmpAttach", attach);
	}

	@Override
	public ArrayList<EmployeeResult> selectEmpResult(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.dbEmpList");
	}

	@Override
	public ArrayList<DeptVo> selectOrgDept(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.orgDept");
	}

	@Override
	public ArrayList<Attachment> selectAttachList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.attachList");
	}

	@Override
	public ArrayList<EmployeeResult> searchEmpUser(SqlSession sqlSession, PageInfo pi, EmployeeResult employee) {
		return (ArrayList)sqlSession.selectList("Employee.searchEmpUser",employee);
	}

	@Override
	public int getSearchEmpCount(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.selectOne("Employee.getSearchEmpCount", employee);
	}

	@Override
	public ArrayList<EmployeeResult> allEmpList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.allEmpList");
	}

	@Override
	public int insertPrsnlManager(SqlSession sqlSession, ArrayList<Object> empList) {
		
		int result= 0;
		
		for(int i = 0; i<empList.size(); i++) {
			
			int empNo = Integer.parseInt((String)empList.get(i));
			
			result += sqlSession.update("Employee.insertPrsnlManager",empNo);
			System.out.println("추가중"+i+empNo);
		}
		
		return result;
	}

	@Override
	public ArrayList<EmployeeResult> selectPrnlEmp(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.selectPrsnlEmp");
	}

	@Override
	public int deletePrsnlManager(SqlSession sqlSession, ArrayList<Object> empList) {
		int result= 0;
		
		for(int i = 0; i<empList.size(); i++) {
			
			int empNo = Integer.parseInt((String)empList.get(i));
			
			result += sqlSession.update("Employee.deletePrsnlManager", empNo);
			System.out.println("삭제중"+i+empNo);
			
		}
		
		return result;
	}

	@Override
	public ArrayList<EmployeeResult> selectEmpList(SqlSession sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getLimit());
		
		return (ArrayList)sqlSession.selectList("Employee.selectEmpList",null,rowBounds);
	}

	@Override
	public int checkEmpWork(SqlSession sqlSession, Attendance attend) {
		return sqlSession.selectOne("Employee.checkEmpWork",attend);
	}
	
	//휴가 추가 - 욱
	@Override
	public int holidayInsertAdmin(SqlSession sqlSession) {
		
		return sqlSession.insert("Employee.insertHolidayAdmin");
	}
	
	//휴가 신청 조회 - 욱
	@Override
	public ArrayList<HashMap<String, Object>>  showHolidayApply(SqlSession sqlSession, int empNo) {
		return (ArrayList) sqlSession.selectList("Employee.showHolidayApply",empNo);
	}

	@Override
	public int insertEmpWork(SqlSession sqlSession, Attendance attend) {
		return sqlSession.insert("Employee.insertEmpWork", attend);
	}
	
	//휴가 신청 - 욱
	@Override
	public int applyHoliday(SqlSession sqlSession, HashMap<String, Object> params) {
		
		sqlSession.insert("Employee.applyHoliday", params);
		
		ArrayList<Object> DateList = (ArrayList<Object>) params.get("holidayDate");
		ArrayList<Object> TimeList = (ArrayList<Object>) params.get("holidayTime");
		
		int result = 0;
		
		for(int i=0; i<DateList.size(); i++) {
			params.put("holidayDate", DateList.get(i));
			params.put("holidayTime", TimeList.get(i));
			result += sqlSession.insert("Employee.applyHolidayDate",params);
		}
		
		return result;
	}
	//휴가 관리자 승인 리스트 조회 - 욱
	@Override
	public ArrayList<HashMap<String, Object>> getAdminHoliday(SqlSession sqlSession, HashMap<String,Object> parmas) {
		ArrayList list = (ArrayList) sqlSession.selectList("Employee.getAdminHoliday", parmas);
		return list;
	}
	

	@Override
	public int insertLeaveEmp(SqlSession sqlSession, ArrayList<Employee> list) {
		int result = 0;
		
		for(int i =0; i<list.size(); i++) {
			result += sqlSession.update("Employee.insertLeaveEmp",list.get(i));
		}
		
		System.out.println("결과 출력 : " + result);
		
		return result;
	}

	@Override
	public ArrayList<EmployeeResult> selectLeaveEmpAdmin(SqlSession sqlSession) {
		
		return (ArrayList)sqlSession.selectList("Employee.selectLeaveEmpAdmin");
	}

	@Override
	public int insertEmpOffWork(SqlSession sqlSession, Attendance attend) {
		return sqlSession.update("Employee.insertEmpOffWork", attend);
	}

	@Override
	public int insertNoWork(SqlSession sqlSession, Attendance attend) {
		return sqlSession.insert("Employee.insertNoWork",attend);
	}

	@Override
	public int checkEmpOffWork(SqlSession sqlSession, Attendance attend) {
		return sqlSession.selectOne("Employee.checkEmpOffWork",attend);
	}
	
	//휴가 상세 조회
	@Override
	public ArrayList<HashMap<String, Object>> holidayDetail(SqlSession sqlSession, HashMap<String, Object> params) {
		return (ArrayList)sqlSession.selectList("Employee.holidayDetail", params);
	}
	
	//휴가 결제 - 욱
	@Override
	public int appHoliday(SqlSession sqlSession, HashMap<String, Object> params) {
		String status = (String) params.get("status");
		int result = 0;
		
		if(status.equals("cancle")) {
			result = sqlSession.insert("Employee.appHoliday",params);
		}else if(status.equals("reCancle")) {
			result = sqlSession.update("Employee.appHolidayUpdate",params);
		}else if(status.equals("apply")) {
			result = sqlSession.insert("Employee.appHolidayInsert",params);
		}
		
		
		return result;
	}

	@Override
	public ArrayList<Attendance> selectAttendanceList(SqlSession sqlSession, int empNo) {
		return (ArrayList)sqlSession.selectList("Employee.selectAttendanceList", empNo);
	}

	@Override
	public int deleteLeaveEmp(SqlSession sqlSession, ArrayList<Object> empList) {
		int result= 0;
		
		for(int i = 0; i<empList.size(); i++) {
			
			int empNo = Integer.parseInt((String)empList.get(i));
			
			result += sqlSession.update("Employee.deleteLeaveEmp",empNo);
			System.out.println("추가중"+i+empNo);
		}
		
		
		return result;
	}

	@Override
	public int insertDeptHead(SqlSession sqlSession, ArrayList<EmployeeResult> list) {
		int result = 0;
		
		for(int i =0; i<list.size(); i++) {
			result += sqlSession.update("Employee.insertDeptHead",list.get(i));
		}
		
		System.out.println("결과 출력 : " + result);
		
		return result;
	}

	@Override
	public ArrayList<DeptVo> deptExcelList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("Employee.selectDeptList");
	}

	@Override
	public List<DeptVo> excelDeptUpdate(SqlSession sqlSession, List<DeptVo> list) {
		for(int i = 0; i<list.size(); i++) {
			System.out.println("포문시작");
			sqlSession.insert("Employee.insertDeptExcel", list.get(i));
		}
		
		System.out.println("포문완료");
		
		return list;

	}
	
	//내 휴가 조회 - 욱
	@Override
	public HashMap<String, Object> getHolidayList(SqlSession sqlSession, Integer empNo) {
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("applyList", sqlSession.selectList("Employee.applyList",empNo));
		hmap.put("myHoliList", sqlSession.selectList("Employee.myHoliList",empNo));
		
		return hmap;
	}

	@Override
	public int getSearchEmpAdminCount(SqlSession sqlSession, EmployeeResult employee) {
		return sqlSession.selectOne("Employee.searchEmpAdminCount",employee);
	}

	@Override
	public ArrayList<EmployeeResult> searchEmpUserAdmin(SqlSession sqlSession, PageInfo pi, EmployeeResult employee) {
		return (ArrayList)sqlSession.selectList("Employee.searchEmpAdmin", employee);
	}



}
