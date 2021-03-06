package com.kh.lgtw.mail.controller;

import static com.kh.lgtw.common.CommonUtils.getServerTime;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.annotation.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.common.Pagination;
import com.kh.lgtw.common.model.vo.Attachment;
import com.kh.lgtw.employee.model.service.EmployeeService;
import com.kh.lgtw.employee.model.vo.Employee;
import com.kh.lgtw.mail.aws.AwsS3;
import com.kh.lgtw.mail.aws.JavaMailSender;
import com.kh.lgtw.mail.model.service.MailService;
import com.kh.lgtw.mail.model.vo.Absence;
import com.kh.lgtw.mail.model.vo.Mail;

@Controller
//@RestController
public class MailController {
	@Autowired private MailService ms;
	@Autowired private EmployeeService es;
	@Autowired private JavaMailSender mailSender; 

	private AwsS3 s3;

	private HttpStatus httpStatus;
	private SimpleMailMessage simpleMailMessage;
	
	// 전체 메일 리스트
	@RequestMapping("mail.ma")
	public String mailHome() {
		return "redirect:allList.ma";
	}
	
	@RequestMapping("/mail")
	public String mailHome2() {
		return "redirect:allList.ma";
	}
	
	// 전체 메일함 조회
	@RequestMapping("allList.ma")
	public String selectMailList(HttpServletRequest request, HashMap<String, Object> listCondition, Model model) {
		// 페이징 처리 
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		if(request.getParameter("listType") != null) {
			listCondition.put("listType", request.getParameter("listType"));
		}
		
		// 로그인 회원 메일 조회
		String empMail = ((Employee)request.getSession().getAttribute("loginEmp")).getEmail();
		listCondition.put("empMail", empMail);
		
		// System.out.println("listCondition : " + listCondition);
		
		// int listCount = ms.getMailListCount();
		int listCount = ms.getMailSearchListCount(listCondition);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		// 조건 처리 안되어 있는 리스트 조회 
		// ArrayList<Mail> list = ms.selectMailList(pi);
		ArrayList<Mail> list = ms.selectSearchMailList(pi, listCondition);

		if(list != null) {
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("listType", listCondition.get("listType"));
			return "mail/mailAllList"; 
		}else {
			model.addAttribute("msg", "리스트 조회에 실패!");
			
			return "common/errorPage";
		}
	}
	
	// 메일 검색
		@RequestMapping("mail/search") 
		public String selectSearchMailList(@RequestParam HashMap<String, Object> listCondition, 
					Model model, HttpServletRequest request) {
			// 페이징 설정
			int currentPage = 1;
			if(request.getParameter("currentPage") != null) {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			int listCount = ms.getMailSearchListCount(listCondition);
			// System.out.println("검색 listCount : " + listCount);
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			// 로그인 회원 메일 조회
			String empMail = ((Employee)request.getSession().getAttribute("loginEmp")).getEmail();
			listCondition.put("empMail", empMail);

			// 이름으로 검색했을 때 사원 메일 검색
			List<String> sMail = null;
			if(listCondition.get("sName") != null) {
				sMail = es.selectEmpEamilForName((String)listCondition.get("sName"));
				listCondition.put("sMail", sMail);
				if(sMail.size() <= 0) {
					model.addAttribute("list", null);
					model.addAttribute("listCondition", listCondition);
					return "mail/mailAllList";
				}
			}
			// System.out.println("sMail : " + sMail);
			System.out.println("listConition : " + listCondition);
			
			// 검색한 메일 리스트 조회
			ArrayList<Mail> list = ms.selectSearchMailList(pi, listCondition);
			// System.out.println("메일 리스트 조회  : " + list);

			if(list != null) {
				model.addAttribute("list", list);
				model.addAttribute("pi", pi);
				model.addAttribute("listCondition", listCondition);
				model.addAttribute("listType", listCondition.get("listType"));
				
				return "mail/mailAllList";
			}else {
				model.addAttribute("msg", "리스트 조회에 실패!");
				
				return "common/errorPage";
			}
		}
	
	// 메일쓰기페이지
	@RequestMapping("mail/writeForm")
	public String writeMailForm() {
		return "mail/sendMailForm";
	}
	
	// 메일 전송 완료 
	@RequestMapping("mail/sendFin")
	public String sendFin(int mailNo, Model model) {

		Mail mailDetail = ms.selectMailDetail(mailNo);
		model.addAttribute("mailDetail", mailDetail);

		return "mail/sendMailFin";
	}
	
	// 메일 상세페이지
	@RequestMapping("mail/detail.ma")
	public String mailDetail(int mailNo, Model model) {
		
		Mail mDetail = ms.selectMailDetail(mailNo);
		System.out.println("mDetail : " + mDetail);
		model.addAttribute("mail", mDetail);
		
		return "mail/mailDetail";
	}
	
	// 읽음 처리 수정하기 
	@RequestMapping("mail/readDetail.ma")
	public String readOneMail(int mailNo) {
		return ms.readOneMail(mailNo);
	}
	 
	
	// 메일상태처리
	@RequestMapping(value="mail/updateStatus",  produces="application/json; charset=utf8")
	@ResponseBody
	public ResponseEntity<String> updateMailStatus(@RequestBody Map<String, Object> map) { 
		int result = 0;
		String body = "";
		try {
			result = ms.updateMailStatus(map);
			
			body = String.valueOf(result);
			httpStatus = HttpStatus.OK;
		} catch (Exception e) {
			body = e.getMessage();
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;  // error로 이동
		}
		// new ResponseEntity</*내가 보낼 타입*/>(success 에 들어가는 값, 3항연산자를 해서 값이 넘어 갔을때는 -> 내가 statsus를 지정 status);
		return new ResponseEntity<String>(body, httpStatus);
	}	
	
	// 메일보내기
	// 프로세스 
	// DB에 저장하고 내부메일일 경우 -> 바로 리턴하고 아니면 전송 실행!
	@RequestMapping(value="/mail/send", method=RequestMethod.POST, headers="Content-Type=multipart/form-data")
	public String sendMail(Mail mail, Model model, HttpServletRequest request,
					@RequestParam(name="mailAttachment", required=false) MultipartFile mailAttachment) {
		boolean existAtt = !(mailAttachment.getOriginalFilename()).equals("");
		String mailDomain = mail.getReciveMail()
						.substring(mail.getReciveMail().indexOf('@'));
		
		String signUrl ="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile29.uf.tistory.com%2Fimage%2F99DE764E5A80F3B70257D4";
		// String signUrl = "https://lgtw-attachment.s3.ap-northeast-2.amazonaws.com/%EC%A7%80%ED%95%98%EC%B2%A0%ED%87%B4%EA%B7%BC.jpg";
		mail.setmContent(mail.getmContent() + "<br><br><img src='" + signUrl + "' width='500px;'/>");

		String filePath = "", root = "", changeName ="", originFileName ="", ext ="";
		Attachment mailAtt = new Attachment();
		int mailNo = 0;
		
		// 데이터에베이스에 정보 저장
		if(existAtt) { // 첨부파일이 존재하는 메일  
			// 첨부파일 저장 처리
			root = request.getSession().getServletContext().getRealPath("resources");

			// 파일 저장 위치 
			filePath = root + "\\uploadFiles\\mail\\sendFiles";

			originFileName = mailAttachment.getOriginalFilename();
			System.out.println("ext : " + originFileName.lastIndexOf("."));
			// 확장자가 없는 파일일경우 -1이 나온다. 
			if(originFileName.indexOf(".") > 0) {
				ext = originFileName.substring(originFileName.lastIndexOf("."));
			}

			// 파일이름 : 보내는 사람 메일-서버시간 
			changeName = mail.getSendMail() + "_" + getServerTime();

			mailAtt.setOriginName(originFileName);
			mailAtt.setChangeName(changeName);
			mailAtt.setFilePath(filePath);
			mail.setmSize((int) mailAttachment.getSize());  // mail의 파일 사이즈 지정해주기 원래는 long형

			// System.out.println("Controller mailAttachment : " + mailAttachment);
			try {
				// 파일 저장 및 DB에 저장
				mailAttachment.transferTo(new File(filePath + "\\" + changeName + ext));
				ms.sendMail(mail, mailAtt);
				mailNo = ms.selectMailNo();
			} catch (IllegalStateException | IOException e) {
				new File(filePath + "\\" + changeName + ext).delete(); 
				model.addAttribute("msg", "데이터베이스에 첨부파일을 포함한 메일 저장 실패!!");
				return "common/errorPage";		
			}
		}else {
			// 첨부파일이 존재하지 않는 메일
			ms.sendMail(mail);
			mailNo = ms.selectMailNo();
		}
		
		if(mailDomain.equals("@lgtw.ga")) {
			System.out.println("내부 전송 메일이니 종료!");
			return "redirect:/mail/sendFin?mailNo=" + mailNo;
		}
		
		simpleMailMessage = new SimpleMailMessage();	
		simpleMailMessage.setFrom(mail.getSendMail());
		simpleMailMessage.setTo(mail.getReciveMail());
		simpleMailMessage.setSubject(mail.getmTitle());
		simpleMailMessage.setText(mail.getmContent());
		
		System.out.println("simpleMailMessage : " + simpleMailMessage);

		// 전송요청 
		if(existAtt) { // 첨부파일이 존재하면
			// System.out.println("mailAttachment : " + mailAttachment);
			
			File attachment;
			try {
				// mulitpart형식이 아닌 일반 file형태로 변환
				attachment = new File(filePath + "\\" + changeName + ext);
				mailSender.send(simpleMailMessage, attachment);
			} catch (IllegalStateException e) {
				new File(filePath + "\\" + changeName + ext).delete(); 
				model.addAttribute("msg", "첨부파일을 포함한 외부메일 발송 실패!");
				return "common/errorPage";		
			}
		}else { // 첨부파일이 존재하지 않으면
			System.out.println("첨부파일 없는 외부메일 전송시작!");
			mailSender.send(simpleMailMessage);
		}
		return "redirect:/mail/sendFin?mailNo=" + mailNo;
	}
	
	// 예약메일 보내기
	@RequestMapping("sendReserve.ma")
	public String sendReserveMail() {
		return "";
	}
	
	// 받은메일함
	@RequestMapping("receiveList.ma")
	public String selectReceiveMailList() {
		return null;
	}
	
	// 보낸메일함
	@RequestMapping("mail/sendList.ma")
	public String selectSencMailList() {
		return null;
	}
	
	// 임시보관함
	@RequestMapping("outBoxList.ma")
	public String selectOutBoxList() {
		return null;
	}
	
	// 휴지통
	@RequestMapping("trashList.ma")
	public String selectTrashMailList() {
		return null;
	}
	
	// 환경설정 페이지로 이동
	@RequestMapping("setting.ma")
	public String mailSettingHome(HttpSession session, Model model) {

		int empNo = ((Employee) session.getAttribute("loginEmp")).getEmpNo();

		ArrayList<Absence> list = ms.selectAbcenceList(empNo);

		System.out.println("list : " + list);
		model.addAttribute("absenceList", list);

		return "mail/settings";
	}
		 
	// 부재중 추가
	@RequestMapping("mail/put/absence")
	public String insertAbsenceMail(Absence absence, Model model, HttpSession session) {
		System.out.println("absence : " + absence);
		// 세션에 있는 로그인 user정보 absence에 추가
		int empNo = ((Employee) session.getAttribute("loginEmp")).getEmpNo();
		absence.setEmpNo(empNo);
		
		int result = ms.insertAbsenceMail(absence);
		System.out.println("result : " + result);
		
		if(result > 0) {
			return "redirect:/setting.ma";  // 부재중 조회 구현시 리다이렉트 
		}else {
			model.addAttribute("msg", "부재중 정보 추가 실패!");
			return "common/errorPage"; 
		}
	}
	
	// 부재중 정보 수정
	@RequestMapping(value="/mail/updateAbsence/{ aNo }", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody String updateAbsence(@PathVariable int aNo) {
		int result ;// = ms.updateAbsence(aNo);
		return "";
	}
	
	// s3 버킷으로 들어오 메시지를 DB에 넣어주는 메소드
	@RequestMapping("mail/s3")
	public String runS3Method() {
		s3 = new AwsS3();
		// **** 프로세스  **** 
		// 리스트를 조회할때 버킷을 조회해서 받은 파일이 존재하면 -> eml파일로 복사후 삭제과정
		// eml파일로 복사후 eml형식을 받아와 메시지 객체에 저장한다. 
		List<S3ObjectSummary> objects = s3.getObjects("lgtw-mail");
		System.out.println("버킷 객체 리스트 가져오기 : " + objects);
		
		if(objects.size() <= 0) {
			System.out.println("버킷에 객체가 존재하지 않습니다.");
			return "redirect:/allList.ma";
		}
		
		for(S3ObjectSummary object : objects) {
			// 객체의 내용을 출력
			s3.downloadObject(object.getBucketName(), object.getKey());
			
			// eml파일로 복사 
			s3.updateObjectForEmlExt(object.getKey());
			
			// 확인을 완료하면 버킷에서 삭제한다. 
			s3.deleteObject(object.getBucketName(), object.getKey());
		}
		
		List<S3ObjectSummary> emlObjects = s3.getObjects("lgtw-mail-eml");
		System.out.println("eml 리스트 가져오기 : " + emlObjects);
		
		for(S3ObjectSummary object : emlObjects) {
			// 객체의 내용을 출력
			s3.downloadObject(object.getBucketName(), object.getKey());
			
			// eml파일 처리하는 메소드 
			Message message= s3.getEmlFile(object.getKey());
			// System.out.println("\n\n\n\n\n메시지 객체 분석해보자 medssage:  " + message.toString() + "\n\n\n\n");
			
			Mail reciveMail = new Mail();
			try {
				MimeMultipart mm = (MimeMultipart) message.getContent();
				MimeBodyPart mb = (MimeBodyPart) mm.getBodyPart(1);
				//System.out.println(mb.getFileName());
//				for(int i = 0; i < message.getReplyTo().length; i++) {
//					System.out.println(i + "번째 : " + message.getReplyTo()[i]);
//				}
//				System.out.println();
//				for(int i = 0; i < message.getFrom().length; i++) {
//					System.out.println(i + "번째 : " + message.getFrom()[i]);
//				}
				
				String from = String.valueOf(message.getFrom()[0]);
				System.out.println("String 변환 후 : " + from );
				from = from.substring(from.indexOf('<') + 1, from.indexOf('>'));
				System.out.println("자른 후 from : " + from);
				
				reciveMail.setObjContent(mb.getContent());
				reciveMail.setmTitle(message.getSubject());
				reciveMail.setmSize(message.getSize());
				reciveMail.setSendStringDate(message.getSentDate());
				reciveMail.setSendMail(from);
				reciveMail.setReciveMail(message.getAllRecipients()[0].toString());
			} catch (IOException | MessagingException e) {
				System.out.println("eml을 DB에 저장하기 실패!");
				System.out.println("에러 메시지 : " + e.getMessage());
			}

			// 메시지 객체에 저장해서 데이터를 불러온 후에 데이터베이스에 맞춰서 저장
			ms.insertReciveMail(reciveMail);
			
			// eml파일 삭제
			s3.deleteObject(object.getBucketName(), object.getKey());
		}
		
		// 리스트 조회
		return "redirect:/allList.ma";
	}
	
	// 첨부파일 다운로드하기
	@RequestMapping("mail/attDownload")
	public String mailAttDownload(HttpServletRequest request, HttpServletResponse response) {
		// attNo를 받아서 DB에서 조회해서 일을 불러온다.
		System.out.println("들어오나 ");
		System.out.println("request : " + request.getParameter("no"));
		Attachment mailAtt = ms.downloadMailAtt(36);
	   // Contract file = as.downloadFile(no);
	   
	   //폴더에서 파일을 읽어들일 스트림 생성
	   BufferedInputStream buf = null;
	   
	   //클라이언트로 내보낼 출력스트림 생성
	   ServletOutputStream downOut = null;
	   try {
	      downOut = response.getOutputStream();
	      
	      File downFile = new File(mailAtt.getFilePath() + "/" + mailAtt.getChangeName());
	      
	      response.setContentType("text/plain; charset=UTF-8");
	      
	      //한글 파일명에 대한 인코딩 처리
	      //강제적으로 다운로드 처리
	      response.setHeader("Content-Disposition", "contract; filename=\"" + 
	               new String(mailAtt.getOriginName().getBytes("UTF-8"), "ISO-8859-1") + "\""); 
	      
	      response.setContentLength((int)downFile.length());
	      
	      FileInputStream fin = new FileInputStream(downFile);
	      
	      buf = new BufferedInputStream(fin);
	      
	      int readBytes = 0;
	      
	      while((readBytes = buf.read()) != -1) {
	         downOut.write(readBytes);
	      }
	      
	      downOut.close();
	      buf.close();
	   } catch (IOException e) {
	      e.printStackTrace();
	   }
		return "mail/mailDetail";
	}
	
	@ResponseBody
	@RequestMapping("mail/countReciveMail")
	public ResponseEntity<String> selectReciveCount(HttpSession session) {
		String empMail = ((Employee) session.getAttribute("loginEmp")).getEmail();
		System.out.println("empMail : " + empMail);
		int count = ms.selectReciveMail(empMail);
		System.out.println("count : " + count);
		
		return new ResponseEntity<String>(count + "", httpStatus.OK);
	}
	
	//----------------------------------------------------------------------------------------
	// 서명 추가
	@RequestMapping("put/sign.ma")
	public String insertSign() {
		return "";
	}
	
	// 서명정보 조회 
	@RequestMapping("sign.ma")
	public String selectSignList() {
		return "";
	}
}

