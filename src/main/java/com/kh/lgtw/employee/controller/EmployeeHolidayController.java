package com.kh.lgtw.employee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.lgtw.employee.model.service.EmployeeService;
import com.kh.lgtw.employee.model.vo.Employee;

@Controller
public class EmployeeHolidayController {
	@Autowired
	private EmployeeService es;
	
	//holiday 페이지 리턴
	@RequestMapping("showHolidayApply.em")
	public String showHolidayApply(HttpSession session, Model model) {
		Employee emp =  (Employee) session.getAttribute("loginEmp");
		
		ArrayList<HashMap<String, Object>> hmap = es.showHolidayApply(emp.getEmpNo());
		
		model.addAttribute("hmap",hmap);
		
		return "employee/holidayApply";
	}
	//holidayAdmin 페이지 리턴
	@RequestMapping("showHolidayApplyAdmin.em")
	public String showHolidayApplyAdmin() {
		return "employee/holidayApplyAdmin";
	}
	
	//휴가 일괄 insert
	@RequestMapping("holidayInsert.em")
	public ResponseEntity<Integer> holidayInsertAdmin() {
		
		return new ResponseEntity<Integer>(es.holidayInsertAdmin(),HttpStatus.OK);
	}
	
	@RequestMapping("applyHoliday.em")
	public String applyHoliday(@RequestParam("holidayDate") List<Object> holidayDate, @RequestParam("holidayTime") List<Object> holidayTime,
							   @RequestParam HashMap<String, Object> params, HttpSession session) {
		Employee emp = (Employee) session.getAttribute("loginEmp");
		
		params.put("holidayDate",holidayDate);
		params.put("holidayTime",holidayTime);
		params.put("empNo",emp.getEmpNo());
		System.out.println(params);
		
		es.applyHoliday(params);
		
		return "redirect:showHolidayList.em";
	}
	
	@RequestMapping("holiday/getAdminHoliday/{empNo}/{textSearch}/{holidayType}/{holdayTime}")
	public ResponseEntity<ArrayList<HashMap<String, Object>>> getAdminHoliday(@PathVariable HashMap<String,Object> parmas){
		ArrayList<HashMap<String, Object>> list = es.getAdminHoliday(parmas);
		return new ResponseEntity<ArrayList<HashMap<String,Object>>>(list, HttpStatus.OK);
	}
	
}
