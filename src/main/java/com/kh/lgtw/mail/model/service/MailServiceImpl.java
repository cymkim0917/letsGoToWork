package com.kh.lgtw.mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.common.model.vo.Attachment;
import com.kh.lgtw.mail.model.dao.MailDao;
import com.kh.lgtw.mail.model.exception.StatusTypeException;
import com.kh.lgtw.mail.model.vo.Absence;
import com.kh.lgtw.mail.model.vo.ListCondition;
import com.kh.lgtw.mail.model.vo.Mail;

@Service
public class MailServiceImpl implements MailService{

	@Autowired private MailDao md;
	@Autowired private SqlSession sqlSession;
	
	// 전체 이메일 갯수 조회
	@Override
	public int getMailListCount() {
		return md.getMailListCount(sqlSession);
	}

	// 페이징 처리한 전체 이메일 리스트 조회
	@Override
	public ArrayList<Mail> selectMailList(PageInfo pi) {
		ArrayList<Mail> list = md.selectMailList(sqlSession, pi);
		
		// 사원의 메일인경우 사원이름을 같이 불러온다.
		for(int i = 0; i < list.size(); i++) {
			Mail mail = list.get(i);
			HashMap<String, Object> empInfo = null;
			
			if(mail.getMailType().equals("받은메일")) {
				empInfo = md.selectSendEmpName(sqlSession, mail.getSendMail());
			}else{
				empInfo = md.selectReciveEmpName(sqlSession, mail.getReciveMail());
			}
			
			if(empInfo == null) {
				continue;
			}
			mail.setDeptName((String)empInfo.get("deptName"));
			mail.setEmpName((String)empInfo.get("empName"));
			mail.setJobName((String)empInfo.get("jobName"));
		}
		return list;
	}

	// 메일 상태 변경
	@Override
	public int updateMailStatus(Map<String, Object> map) throws StatusTypeException {
		return md.updateMailStatus(sqlSession, map);
	}

	// 메일 상세 페이지 조회
	@Override
	public Mail selectMailDetail(int mailNo) {
		return md.selectMailDetail(sqlSession, mailNo); 
	}
	
	// 상세페이지 클릭시 메일 하나 읽음 처리 
	@Override
	public String readOneMail(int mailNo) {
		return md.readOneMail(sqlSession, mailNo);
	}


	// 부재중 설정 추가
	@Override
	public int insertAbsenceMail(Absence absence) {
		return md.insertAbsenceMail(sqlSession, absence);
	}

	// 부재중 리스트 조회
	@Override
	public ArrayList<Absence> selectAbcenceList(int empNo) {
		return md.selectAbsenceList(sqlSession, empNo);
	}

	// 메일 보내기
	@Override
	public int sendMail(Mail mail) {
		return md.sendMail(sqlSession, mail);
	}
	
	// 첨부파일이 있는 메일 전송하기 
	@Override
	public int sendMail(Mail mail, Attachment mailAtt) {
		// 트랜젝션 처리하기 		
		int result1 = md.sendMail(sqlSession, mail);
		int result2 = md.insertAttachment(sqlSession, mailAtt);
		System.out.println("메일 파일 저장 : " + result1 + "  " + result2);
		if(result1 > 0 && result2 > 0) {
			return 1;
		}else {
			return 0;
		}
	}

	// 검색 메일 조회 - HashMap으로 
	@Override
	public ArrayList<Mail> selectSearchMailList(PageInfo pi, HashMap<String, Object> listCondition) {
		ArrayList<Mail> list = md.selectSearchMailList(sqlSession, pi, listCondition); 
		
		// 사원의 메일인경우 사원이름을 같이 불러온다.
		for(int i = 0; i < list.size(); i++) {
			Mail mail = list.get(i);
			HashMap<String, Object> empInfo = null;
			
			if(mail.getSendMail().equals(listCondition.get("empMail"))) {
				// 내가 보낸 메일인 경우 
				empInfo = md.selectReciveEmpName(sqlSession, mail.getReciveMail());
			}else if(mail.getReciveMail().equals(listCondition.get("empMail"))){
				// 내가 받은 메일 인 경우 
				empInfo = md.selectSendEmpName(sqlSession, mail.getSendMail());
			}
			
			if(empInfo == null) {
				continue;
			}
			mail.setDeptName((String)empInfo.get("deptName"));
			mail.setEmpName((String)empInfo.get("empName"));
			mail.setJobName((String)empInfo.get("jobName"));
		}
		return list;
	}

	// 검색 페이징을 위한 조건 리스트 갯수 조회
	@Override
	public int getMailSearchListCount(HashMap<String, Object> listCondition) {
		return md.getMailSearchListCount(sqlSession, listCondition);
	}

	// s3에서 메시지 객체를 불러와 데이터 베이스에 저장
	@Override
	public int insertReciveMail(Mail reciveMail) {
		return md.insertReciveMail(sqlSession, reciveMail);
	}

	// 방금 마지막 메일 번호 가져오기
	@Override
	public int selectMailNo() {
		return md.selectMailNo(sqlSession);
	}

	// 파일 다운로드 
	@Override
	public Attachment downloadMailAtt(int no) {
		return md.downloadMailAtt(sqlSession, no);
	}

	// 메인화면 받은 메일 갯수 
	@Override
	public int selectReciveMail(String empMail) {
		return md.selectReciveMail(sqlSession, empMail);
	}

}