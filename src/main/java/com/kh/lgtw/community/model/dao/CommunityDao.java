package com.kh.lgtw.community.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.omg.CORBA.Object;

import com.kh.lgtw.approval.model.vo.PageInfo;
import com.kh.lgtw.community.model.vo.Community;
import com.kh.lgtw.community.model.vo.CommunityAttachment;
import com.kh.lgtw.community.model.vo.CommunityComment;
import com.kh.lgtw.community.model.vo.CommunityPost;
import com.kh.lgtw.employee.model.vo.Employee;

public interface CommunityDao {

	ArrayList<Community> SelectCommunity(SqlSessionTemplate sqlSession);

	ArrayList<CommunityPost> CommunityPostList(int bno, SqlSessionTemplate sqlSession);

	ArrayList<CommunityPost> CommunityPostDetails(int contentNO, SqlSessionTemplate sqlSession);

	ArrayList<CommunityPost> SelectTemporaryList(SqlSessionTemplate sqlSession);

	int InsertCommunity(SqlSessionTemplate sqlSession, Community com);

	ArrayList<Community> SelectManagebulletinList(SqlSessionTemplate sqlSession);

	int CommunityPostInsert(SqlSessionTemplate sqlSession, CommunityPost cp, CommunityAttachment ca);

	Community communityUpdateForm(SqlSessionTemplate sqlSession, int bno);

	int communityUpdate(Community com, SqlSessionTemplate sqlSession);

	//게시글 수정 폼 메소드
	CommunityPost communityPostUpdateForm(SqlSessionTemplate sqlSession, int contentno);

	//게시글 수정 메소드 
	int communityPostUpdate(SqlSessionTemplate sqlSession, CommunityPost cp);

	//게시글 삭제 메소드 
	int communityPostDelete(SqlSessionTemplate sqlSession, int contentno);

	//게시판 삭제 메소드 
	int communityDelete(SqlSessionTemplate sqlSession, int bno);

	//게시글 임시저장 Insert 메소드
	int temporayInsert(SqlSessionTemplate sqlSession, CommunityPost cp);
    
	//댓글 목록 조회
	ArrayList<CommunityComment> commentlist(SqlSessionTemplate sqlSession, int contentNO);

	//댓글 생성
	int InsertComment(SqlSessionTemplate sqlSession, CommunityComment cc);

	//댓글 수정
	int UpdateComment(SqlSessionTemplate sqlSession, CommunityComment cc);

	//댓글 삭제
	int DeleteReply(SqlSessionTemplate sqlSession, CommunityComment cc);

	//임시저장 상세 
	CommunityPost TemporaryDetails(SqlSessionTemplate sqlSession, int contentNO);

	int commentListcount(int contentno, SqlSessionTemplate sqlSession);

	ArrayList<HashMap<String, java.lang.Object>> selectcommentList(PageInfo pi, Integer contentno,
			SqlSessionTemplate sqlSession);

	CommunityAttachment AttachmentSelect(SqlSessionTemplate sqlSession, int contentNO);

	//파일 다운로드 메소드
	CommunityAttachment CommunityAttachment(SqlSessionTemplate sqlSession, int contentNO);

	//게시글  카운터
	int selectCommunityPostlistCount(SqlSessionTemplate sqlSession, int bno);

	ArrayList<CommunityPost> CommunityPostPageList(SqlSessionTemplate sqlSession, PageInfo pi);

	ArrayList<HashMap<String, java.lang.Object>> communityPostList(SqlSessionTemplate sqlSession, PageInfo pi, int bno);

	ArrayList<HashMap<String, java.lang.Object>> selectBoardContent(int bno, SqlSessionTemplate sqlSession);

	//게시글 페이징
	/*
	 * ArrayList<HashMap<String, java.lang.Object>>
	 * CommunityPostpageList(SqlSessionTemplate sqlSession, PageInfo pi);
	 */

	/*
	 * CommunityAttachment AttachmentSelect(SqlSessionTemplate sqlSession, int
	 * contentNO);
	 */



	

	

	
	
	
	
	//게시판 생성
	

	
	

	

		

}
