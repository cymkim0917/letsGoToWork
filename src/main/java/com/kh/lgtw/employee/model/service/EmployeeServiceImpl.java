package com.kh.lgtw.employee.model.service;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.common.model.vo.Attachment;
import com.kh.lgtw.employee.model.dao.EmployeeDao;
import com.kh.lgtw.employee.model.exception.LoginException;
import com.kh.lgtw.employee.model.vo.Attendance;
import com.kh.lgtw.employee.model.vo.DeptHistory;
import com.kh.lgtw.employee.model.vo.DeptVo;
import com.kh.lgtw.employee.model.vo.Employee;
import com.kh.lgtw.employee.model.vo.EmployeeResult;
import com.kh.lgtw.employee.model.vo.ExcelEmp;
import com.kh.lgtw.employee.model.vo.JobVo;
import com.kh.lgtw.employee.model.vo.PromotionHistory;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired SqlSession sqlSession; 
	@Autowired private EmployeeDao empDao;
	@Autowired private BCryptPasswordEncoder passwordEncoder;
	
	// 로그인 확인용
	@Override
	public Employee loginCheck(Employee employee) throws LoginException {
		Employee loginEmp = null;
		
		String encPassword = empDao.selectEncPassword(sqlSession, employee);
		
		System.out.println("비밀번호 : " + encPassword);
		System.out.println("암호 2 : " + employee.getEmpPwd());	
		String pass =  passwordEncoder.encode(employee.getEmpPwd());
		System.out.println(pass);
		
		if(passwordEncoder.matches(employee.getEmpPwd(), encPassword)) {
			loginEmp = empDao.loginCheck(sqlSession, employee);
		}else {
			throw new LoginException("로그인실패!");
		}
		
		return loginEmp;
	}
	
	@Override
	public int insertEmpOne(Employee employee, Attachment attach, DeptVo dpVo, JobVo jobVo) {
		
		int result = 0;
		
		 int empInsert = empDao.inSertEmpOne(sqlSession, employee);
		
		 if(empInsert > 0) {
			 int deptHistory = empDao.insertDeptHistory(sqlSession, dpVo, jobVo);
			 int empPro = empDao.insertEmpProfile(sqlSession, attach);
		 }
		
		return result;
	}

	@Override
	public int empExcelUpload(File destFile) {
		return empDao.empExcelUpload(sqlSession, destFile);
	}

	@Override
	public List<ExcelEmp> xlsEmpInsert(MultipartHttpServletRequest request, MultipartFile excelFile) {
		System.out.println("엑셀 XLS");
		return null;
	}
	
	//Emp 엑셀 insert
	@Override
	public List<ExcelEmp> xlsxEmpInsert(MultipartHttpServletRequest request, MultipartFile excelFile, Attachment attach) {
		
		System.out.println("엑셀 XLSX");
		
		List<ExcelEmp> list = new ArrayList<>();
		
		MultipartFile file = request.getFile("excelFile");
		
		XSSFWorkbook workbook = null;
		
		try {
			
			workbook = new XSSFWorkbook(file.getInputStream());
			
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			ExcelEmp excelEmp;
			
			String filePath = "스트링"+file.getOriginalFilename();
			
			System.out.println("서비스 엑셀파일 확인" + filePath);
			
		for(int sheetIndex = 0; sheetIndex<workbook.getNumberOfSheets(); sheetIndex++) {
			System.out.println("시트 확인"+workbook.getNumberOfSheets());
			System.out.println(sheetIndex);
			System.out.println(workbook.getNumberOfSheets());
			
			curSheet =workbook.getSheetAt(sheetIndex);
			
			for(int rowIndex = 0; rowIndex<curSheet.getPhysicalNumberOfRows(); rowIndex++) {
				System.out.println("로우 확인"+curSheet.getPhysicalNumberOfRows());
				if(rowIndex!=0) {
					curRow=curSheet.getRow(rowIndex);
					
					excelEmp = new ExcelEmp();
					
					String value;
					
					if(curRow.getCell(0)!=null) {
						for(int cellIndex=0; cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
							curCell = curRow.getCell(cellIndex);
							
							System.out.println("셀타입 확인:"+curCell.getCellType());
							
							if(true) {
								value="";
								
								switch (curCell.getCellType()) {
								case FORMULA: value = curCell.getCellFormula(); break;
								case NUMERIC:
									if (HSSFDateUtil.isCellDateFormatted(curCell)){ 
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
									value= formatter.format(curCell.getDateCellValue());  break;
									}else{
									 value = curCell.getNumericCellValue() + "";
									 break;
									}
								case STRING: value = curCell.getStringCellValue() + ""; break;
								case BLANK: value = curCell.getBooleanCellValue() + ""; break;
								case ERROR: value = curCell.getErrorCellValue() + ""; break;
								default: value = new String(); break;
								} // end switch
								
								switch(cellIndex) {
								case 0 : excelEmp.setEmpId(value); break;
								case 1 : excelEmp.setEmpPwd(passwordEncoder.encode(value)); break;
								case 2 : excelEmp.setEmpName(value); break;
								case 3 : excelEmp.setEmail(value); break;
								case 4 : excelEmp.setEmpPhone(value); break;
								case 5 : excelEmp.setEnrollDate(Date.valueOf(value));break;
								case 6 : excelEmp.setEmpBirth(value); break;
								case 7 : excelEmp.setGender(value); break;
								case 8 : excelEmp.setOtherInfo(value); break;
								case 9 : excelEmp.setDeptName(value); break;
								case 10 : excelEmp.setJobName(value); break;
								case 11 : excelEmp.setStatus(value); break;
								default: break;
								}
							}
						}
						
						list.add(excelEmp);
					}
				}
			}
			
		}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		List<ExcelEmp> daoList = new ArrayList<>();
		
		for(int i = 0; i<list.size(); i++) {
			System.out.println("서비스 리스트 확인 : " +list.get(i).getEmpName());
			System.out.println("부서 직급 확인 :" + list.get(i).getDeptName()+","+list.get(i).getJobName());
			
		}
		
		daoList = empDao.excelEmpInsert(sqlSession, list, attach);
		
		return daoList;
	}

	// 이름으로 사원 이메일 찾기 
	@Override
	public List<String> selectEmpEamilForName(String sName) {
		return empDao.selectEmpEmailForName(sqlSession, sName);
	}
  
	@Override
	public ArrayList<DeptVo> selectDeptList() {
		return empDao.selectDeptList(sqlSession);
	}

	@Override
	public int insertEmpQuick(Employee employee, DeptVo dpVo, JobVo jobVo, Attachment attach) {
		int result=0;
		
		int empNum = empDao.insertEmpQuick(sqlSession, employee);
		
		if(empNum>0) {
			int deptHistory = empDao.insertDeptHistory(sqlSession, dpVo, jobVo);
			int profile = empDao.insertEmpProfile(sqlSession, attach);
			
			result=1;
		}
		
		return result;
	}

	@Override
	public ArrayList<EmployeeResult> selectEmpListAdmin(PageInfo pi) {
		return empDao.selectEmpListAdmin(sqlSession,pi);
	}

	@Override
	public HashMap<String, Object> selectJopDeptAdmin() {
		
		HashMap<String, Object> hmap = null;
		
		ArrayList<DeptVo> deptList = empDao.selectDeptList(sqlSession);
		ArrayList<JobVo> jobList = empDao.selectJobAdmin(sqlSession);
		
		hmap = new HashMap<String, Object>();
		hmap.put("deptList", deptList);
		hmap.put("jobList", jobList);
		
		return hmap;
	}

	@Override
	public int getEmpListCount() {
		return empDao.getEmpListCount(sqlSession);
	}

	@Override
	public int deleteEmpList(int empNo) {
		return empDao.deleteEmpList(sqlSession,empNo);
	}

	@Override
	public int insertEmpOneNoAttach(Employee employee, DeptVo dpVo, JobVo jobVo) {
		int empNum = empDao.inSertEmpOne(sqlSession, employee);
		int result = 0;
		
		if(empNum>0) {
			int deptHistory = empDao.insertDeptHistory(sqlSession, dpVo, jobVo);
			result=1;
		}
		
		
		return result;
	}

	@Override
	public void dbEmpList(HttpServletResponse response) {
		ArrayList<EmployeeResult> list = empDao.dbEmpList(sqlSession);
		
		SXSSFWorkbook wb = new SXSSFWorkbook();
		Sheet sheet = wb.createSheet();
		
		sheet.setColumnWidth(0, 3000);
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 5000);
		sheet.setColumnWidth(4, 5000);
		sheet.setColumnWidth(5, 7000);
		sheet.setColumnWidth(6, 7000);
		sheet.setColumnWidth(7, 3000);
		
		Row row = null;
		Cell cell = null;
		
		row = sheet.createRow(0);
		cell = row.createCell(0);
		cell.setCellValue("사번");
		cell = row.createCell(1);
		cell.setCellValue("아이디");
		cell = row.createCell(2);
		cell.setCellValue("직원 이름");
		cell = row.createCell(3);
		cell.setCellValue("부서");
		cell = row.createCell(4);
		cell.setCellValue("직급");
		cell = row.createCell(5);
		cell.setCellValue("내선번호");
		cell = row.createCell(6);
		cell.setCellValue("휴대전화");
		cell = row.createCell(7);
		cell.setCellValue("상태(근무:Y/휴직:H/퇴사:N)");
		
		for(int i = 0; i<list.size(); i++) {
			row = sheet.createRow(i+1);
				cell = row.createCell(0);
				cell.setCellValue(list.get(i).getEmpNo());
				cell = row.createCell(1);
				cell.setCellValue(list.get(i).getEmpId());
				cell = row.createCell(2);
				cell.setCellValue(list.get(i).getEmpName());
				cell = row.createCell(3);
				cell.setCellValue(list.get(i).getDeptName());
				cell = row.createCell(4);
				cell.setCellValue(list.get(i).getJobName());
				cell = row.createCell(5);
				cell.setCellValue(list.get(i).getOfficeTel());
				cell = row.createCell(6);
				cell.setCellValue(list.get(i).getEmpPhone());
				cell = row.createCell(7);
				cell.setCellValue(list.get(i).getStatus());
		}
		
		try {
			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			response.setHeader("Content-Disposition", String.format("attachment; filename=\"dataEmp.xlsx\""));
			wb.write(response.getOutputStream());
			wb.dispose();
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<EmployeeResult> xlsEmpUpdate(MultipartHttpServletRequest request, MultipartFile excelFile) {
		return null;
	}

	@Override
	public List<EmployeeResult> xlsxEmpUpdate(MultipartHttpServletRequest request, MultipartFile excelFile) {
		//System.out.println("엑셀 XLSX");
		
		List<EmployeeResult> list = new ArrayList<>();
		
		MultipartFile file = request.getFile("excelFile");
		
		XSSFWorkbook workbook = null;
		
		try {
			
			workbook = new XSSFWorkbook(file.getInputStream());
			
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			EmployeeResult employeeResult;
			
			String filePath = "스트링"+file.getOriginalFilename();
			
			//System.out.println("서비스 엑셀파일 확인" + filePath);
			
		for(int sheetIndex = 0; sheetIndex<workbook.getNumberOfSheets(); sheetIndex++) {
			//System.out.println("시트 확인"+workbook.getNumberOfSheets());
			//System.out.println(sheetIndex);
			//System.out.println(workbook.getNumberOfSheets());
			
			curSheet =workbook.getSheetAt(sheetIndex);
			
			for(int rowIndex = 0; rowIndex<curSheet.getPhysicalNumberOfRows(); rowIndex++) {
				//System.out.println("로우 확인"+curSheet.getPhysicalNumberOfRows());
				if(rowIndex!=0) {
					curRow=curSheet.getRow(rowIndex);
					
					employeeResult = new EmployeeResult();
					
					String value;
					
					if(curRow.getCell(0)!=null) {
						for(int cellIndex=0; cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
							curCell = curRow.getCell(cellIndex);
							
							//System.out.println("셀타입 확인:"+curCell.getCellType());
							
							if(true) {
								value="";
								
								switch (curCell.getCellType()) {
								case FORMULA: value = curCell.getCellFormula(); break;
								case NUMERIC:
									if (HSSFDateUtil.isCellDateFormatted(curCell)){ 
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
									value= formatter.format(curCell.getDateCellValue());  break;
									}else{
									 value = (int)curCell.getNumericCellValue() + "";
									 break;
									}
								case STRING: value = curCell.getStringCellValue() + ""; break;
								case BLANK: value = curCell.getBooleanCellValue() + ""; break;
								case ERROR: value = curCell.getErrorCellValue() + ""; break;
								default: value = new String(); break;
								} // end switch
								
								switch(cellIndex) {
								case 0 : employeeResult.setEmpNo(Integer.valueOf(value)); break;
								case 1 : employeeResult.setEmpId(value); break;
								case 2 : employeeResult.setEmpName(value); break;
								case 3 : employeeResult.setDeptName(value); break;
								case 4 : employeeResult.setJobName(value); break;
								case 5 : employeeResult.setOfficeTel(value); break;
								case 6 : employeeResult.setEmpPhone(value); break;
								case 7 : employeeResult.setStatus(value); break;
								default: break;
								}
							}
						}
						
						list.add(employeeResult);
						
					}
				}
			}
			
		}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		List<EmployeeResult> daoList = new ArrayList<>();
		
		daoList = empDao.excelEmpUpdate(sqlSession, list);
		
		
		return daoList;
	}

	@Override
	public HashMap<String, Object> selectEmpDeptJob(Employee employee) {
		HashMap<String, Object> hmap = null;
		
		PromotionHistory jobHistory = empDao.selectEmpJob(sqlSession, employee);
		DeptHistory dpHistory = empDao.selectEmpDept(sqlSession, employee);
		
		hmap = new HashMap<String, Object>();
		hmap.put("jobHistory", jobHistory);
		hmap.put("dpHistory", dpHistory);
		
		return hmap;
	}

	@Override
	public Attachment selectProfile(Employee employee) {
		return empDao.selectProfile(sqlSession, employee);
	}

	@Override
	public int updatePwdCheck(EmployeeResult employee) {
		int result =0;
		String encPassword = empDao.selectUpCheckPwd(sqlSession, employee);
		
		System.out.println(employee.getEmpId());
		
		System.out.println("비밀번호 : " + encPassword);
		System.out.println("암호 2 : " + employee.getEmpPwd());	
		String pass =  passwordEncoder.encode(employee.getEmpPwd());
		System.out.println(pass);
		
		if(passwordEncoder.matches(employee.getEmpPwd(), encPassword)) {
			result=1;
		}else {
			result=0;
		}
		
		
		return result;
	}

	@Override
	public int updateEmpOne(EmployeeResult employee, Attachment attach) {
		int result = 0;
		int updateEmp = empDao.updateEmpOne(sqlSession,employee);
		
		if(updateEmp>0) {
			 empDao.updateEmpOneDept(sqlSession,employee);
			 empDao.updateEmpOneJob(sqlSession,employee);
			 empDao.updateEmpAttach(sqlSession, attach);
			
			result = 1;
		}
		
		
		return result;
	}

	@Override
	public HashMap<String, Object> selectLevelCaptain() {
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		
		ArrayList<JobVo> jobList = empDao.selectJobAdmin(sqlSession);
		ArrayList<DeptVo> deptList = empDao.selectDeptList(sqlSession); 
		ArrayList<EmployeeResult> empResult = empDao.selectEmpResult(sqlSession);
		
		
		hmap.put("jobList", jobList);
		hmap.put("deptList", deptList);
		hmap.put("empList", empResult);
		
		
		return hmap;
	}

	@Override
	public ArrayList<DeptVo> selectOrgDept() {
		return empDao.selectOrgDept(sqlSession);
	}
	
	@Override
	public void deptExcelList(HttpServletResponse response) {
		
		ArrayList<DeptVo> list = empDao.deptExcelList(sqlSession);
		
		SXSSFWorkbook wb = new SXSSFWorkbook();
		Sheet sheet = wb.createSheet();
		
		sheet.setColumnWidth(0, 5000);
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 7000);
		
		Row row = null;
		Cell cell = null;
		
		row = sheet.createRow(0);
		
		cell = row.createCell(0);
		cell.setCellValue("부서코드(부서코드는 규칙을 보고 따라 지정해주세요)");
		cell = row.createCell(1);
		cell.setCellValue("부서명");
		cell = row.createCell(2);
		cell.setCellValue("상위부서");
		cell = row.createCell(3);
		cell.setCellValue("부서코드 규칙 : D로 시작하고 1레벨은 D1-0, 2레벨은 D2-0으로 입력하여 주세요/상위 부서는 부서코드를 입력해주세요");
		
		for(int i = 0; i<list.size(); i++) {
			row = sheet.createRow(i+1);
				cell = row.createCell(0);
				cell.setCellValue(list.get(i).getDeptCode());
				cell = row.createCell(1);
				cell.setCellValue(list.get(i).getDeptName());
				cell = row.createCell(2);
				cell.setCellValue(list.get(i).getTopDept());
		}
		
		try {
			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			response.setHeader("Content-Disposition", String.format("attachment; filename=\"deptList.xlsx\""));
			wb.write(response.getOutputStream());
			wb.dispose();
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public ArrayList<Attachment> selectAttachList() {
		return empDao.selectAttachList(sqlSession);
	}

	@Override
	public ArrayList<EmployeeResult> searchEmpUser(PageInfo pi, EmployeeResult employee) {
		return empDao.searchEmpUser(sqlSession, pi, employee);
	}

	@Override
	public int getSearchEmpCount(EmployeeResult employee) {
		return empDao.getSearchEmpCount(sqlSession,employee);
	}

	@Override
	public ArrayList<EmployeeResult> allEmpList() {
		
		return empDao.allEmpList(sqlSession);
	}

	@Override
	public int insertPrsnlManager(ArrayList<Object> empList) {
		return empDao.insertPrsnlManager(sqlSession, empList);
	}

	@Override
	public ArrayList<EmployeeResult> selectPrnlEmp() {
		ArrayList<EmployeeResult> empPrnl = new ArrayList<EmployeeResult>();
		empPrnl = empDao.selectPrnlEmp(sqlSession);
		
		return empPrnl;
	}

	@Override
	public int deletePrsnlManager(ArrayList<Object> empList) {
		return empDao.deletePrsnlManager(sqlSession, empList);
	}

	@Override
	public ArrayList<EmployeeResult> selectEmpList(PageInfo pi) {
		return empDao.selectEmpList(sqlSession,pi);
	}

	@Override
	public int checkEmpWork(Attendance attend) {
		return empDao.checkEmpWork(sqlSession, attend);
	}

	@Override
	public int insertEmpWork(Attendance attend) {
		
		return empDao.insertEmpWork(sqlSession, attend);
	}

	
	@Override
	public int holidayInsertAdmin() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<HashMap<String, Object>>  showHolidayApply(int empNo) {
		return empDao.showHolidayApply(sqlSession, empNo);
	}
	
	//휴가 신청 - 욱
	@Override
	public int applyHoliday(HashMap<String, Object> params) {
		 return empDao.applyHoliday(sqlSession, params);
	}

	//휴가 관리자 승인 리스트 - 욱
	@Override
	public ArrayList<HashMap<String, Object>> getAdminHoliday(HashMap<String,Object> parmas) {
		return empDao.getAdminHoliday(sqlSession, parmas);
	}
	

	

	@Override
	public int insertLeaveEmp(ArrayList<Employee> list) {
		return empDao.insertLeaveEmp(sqlSession, list);
	}

	@Override
	public ArrayList<EmployeeResult> selectLeaveEmpAdmin() {
		
		ArrayList<EmployeeResult> list = new ArrayList<EmployeeResult>();
		
		list = empDao.selectLeaveEmpAdmin(sqlSession);
		
		return list;
	}

	@Override
	public int insertEmpOffWork(Attendance attend) {
		return empDao.insertEmpOffWork(sqlSession, attend);
	}

	@Override
	public int insertNoWork(Attendance attend) {
		return empDao.insertNoWork(sqlSession, attend);
	}

	@Override
	public int checkEmpOffWork(Attendance attend) {
		return empDao.checkEmpOffWork(sqlSession,attend);
	}
	
	//휴가 상세 조회 - 욱
	@Override
	public ArrayList<HashMap<String, Object>> holidayDetail(HashMap<String, Object> params) {
		return empDao.holidayDetail(sqlSession, params);
	}
	//휴가 결제 - 욱
	@Override
	public int appHoliday(HashMap<String, Object> params) {
		return empDao.appHoliday(sqlSession, params);
	}

	@Override
	public ArrayList<Attendance> selectAttendanceList(int empNo) {
		ArrayList<Attendance> list = new ArrayList<Attendance>();
		
		list = empDao.selectAttendanceList(sqlSession, empNo);
		
		return list;
	}

	@Override
	public int deleteLeaveEmp(ArrayList<Object> empList) {
		return empDao.deleteLeaveEmp(sqlSession,empList);
	}

	@Override
	public int insertDeptHead(ArrayList<EmployeeResult> list) {
		return empDao.insertDeptHead(sqlSession,list);
	}

	@Override
	public List<DeptVo> xlsxdeptUpdate(MultipartHttpServletRequest request, MultipartFile excelFile) {
		
		List<DeptVo> list = new ArrayList<>();
		
		MultipartFile file = request.getFile("excelFile");
		
		XSSFWorkbook workbook = null;
		
		try {
			
			workbook = new XSSFWorkbook(file.getInputStream());
			
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			DeptVo deptVo;
			
			String filePath = "스트링"+file.getOriginalFilename();
			
			//System.out.println("서비스 엑셀파일 확인" + filePath);
			
		for(int sheetIndex = 0; sheetIndex<workbook.getNumberOfSheets(); sheetIndex++) {
			//System.out.println("시트 확인"+workbook.getNumberOfSheets());
			//System.out.println(sheetIndex);
			//System.out.println(workbook.getNumberOfSheets());
			
			curSheet =workbook.getSheetAt(sheetIndex);
			
			for(int rowIndex = 0; rowIndex<curSheet.getPhysicalNumberOfRows(); rowIndex++) {
				//System.out.println("로우 확인"+curSheet.getPhysicalNumberOfRows());
				if(rowIndex!=0) {
					curRow=curSheet.getRow(rowIndex);
					
					deptVo = new DeptVo();
					
					String value;
					
					if(curRow.getCell(0)!=null) {
						for(int cellIndex=0; cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
							curCell = curRow.getCell(cellIndex);
							
							//System.out.println("셀타입 확인:"+curCell.getCellType());
							
							if(true) {
								value="";
								
								switch (curCell.getCellType()) {
								case FORMULA: value = curCell.getCellFormula(); break;
								case NUMERIC:
									if (HSSFDateUtil.isCellDateFormatted(curCell)){ 
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
									value= formatter.format(curCell.getDateCellValue());  break;
									}else{
									 value = (int)curCell.getNumericCellValue() + "";
									 break;
									}
								case STRING: value = curCell.getStringCellValue() + ""; break;
								case BLANK: value = curCell.getBooleanCellValue() + ""; break;
								case ERROR: value = curCell.getErrorCellValue() + ""; break;
								default: value = new String(); break;
								} // end switch
								
								switch(cellIndex) {
								case 0 : deptVo.setDeptCode(value); break;
								case 1 : deptVo.setDeptName(value); break;
								case 2 : deptVo.setTopDept(value); break;
								default: break;
								}
							}
						}
						
						list.add(deptVo);
						
					}
				}
			}
			
		}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		List<DeptVo> daoList = new ArrayList<>();
		
		daoList = empDao.excelDeptUpdate(sqlSession, list);
		
		
		return daoList;
	}
	
	//내 휴가 조회 - 욱
	@Override
	public HashMap<String, Object> getHolidayList(Integer empNo) {
		return empDao.getHolidayList(sqlSession,empNo);
	}



}
