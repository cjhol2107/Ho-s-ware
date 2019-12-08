<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Ho's ware 편리한 그룹웨어</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/jquery/jquery-ui.min.js"></script>
	<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
	<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
	<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
	<link rel="stylesheet" href="/resources/vendor/jquery/jquery-ui.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>

	<meta id="_csrf" name="_csrf" content="${_csrf.token }"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName }"/>

</head>

<body>
 				<!-- userid get -->
    <sec:authentication property="principal" var="pinfo" />
    <sec:authorize access="isAuthenticated()">
    	<input type="hidden" name="user_id" value="${pinfo.username}">
    </sec:authorize>

    <div id="wrapper" style="background-color:white;">
		 <nav class="navbar navbar-default navbar-static-top navbar-top-custom" role="navigation" 
		 	  style="background-color:white; margin-bottom:0px; height:60px; border:0px;">
         	<div class="col-lg-12 text-center" style="padding-top:10px">
         		<a href="/freeBoard/list"><img src='/resources/img/logo1.png'></a>
         	</div>
         </nav>

        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; background-color:white;">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
    		<!-- 드롭다운 메뉴 (유저정보, 로그인정보, 알림) -->
            <ul class="nav navbar-top-links navbar-right ">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    	<sec:authorize access="isAuthenticated()"> 
                    	<sec:authentication property="principal" var="pinfo"/>
                   			<label><c:out value="${pinfo.username }"/> </label>
                   		</sec:authorize>
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    
                    <ul class="dropdown-menu dropdown-user" >
                    	<sec:authorize access="isAnonymous()">
                    		<li>
                    			<a href="/customLogin"><i class="fa fa-sign-in "></i> 로그인</a>
	                        </li>
	                        <li class="divider"></li>
                    		<li>
                    			<a href="/joinPage"><i class="fa fa-gear"></i> 회원가입</a>
	                        </li>
                    	</sec:authorize>
                    	<sec:authorize access="isAuthenticated()"> 
	                        <li>
	                        	<a href="/resources/pdf/test.pdf"><i class="fa fa-user"></i> 프로필</a>
	                        </li>
	                        <li class="divider"></li>
	                        <li>
	                        	<a href="#"><i class="fa fa-gear"></i> 개인정보변경</a>
	                        </li>
                        	<li class="divider"></li>
	                        <li>
	                        	<a href="#" onclick="document.getElementById('logout-form').submit();">
	                        		<i class="fa fa-sign-out"></i> 로그아웃
	                        	</a>
	                        	<!-- 로그아웃form -->
	                        	<form id="logout-form" action='<c:url value='/customLogout'/>' method="POST">
	   								<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
								</form>
	                        </li>
                        </sec:authorize>
                    </ul>
                </li>
                
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                           <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li>
                            <a href="/mail/getReceived">
                                <div>
                                    <i class="fa fa-envelope"></i> 안읽은 쪽지<span class="unreadCnt"> </span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a class="text-center" href="/mail/getReceived">
                                <strong>받은 쪽지함</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>

			<!-- 사이드바 메뉴(게시판, 쪽지, 전자결재, 일정, 관리자메뉴) -->
            <div class="navbar-default sidebar" role="navigation" style="padding-top:35px; background-color:white;">
                <div class="sidebar-nav navbar-collapse white" id="navvar">
                    <ul class="nav white" id="side-menu">
                    	<li></li>
                        <li>
                            <a href="#"><i class="fa fa-list-alt"></i> 게시판<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/freeBoard/list"><i class="fa fa-angle-right"></i> 자유게시판</a>
                                </li>
                                <li>
                                    <a href="/freeBoard/myPage"><i class="fa fa-angle-right"></i> 내가 쓴글</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="#" id="mail"><i class="fa fa-envelope-o"></i> 쪽지함<span class="fa arrow"></span></a>
                        	<ul class="nav nav-second-level">
                        		<li>
                        			<a href="/mail/getReceived"><i class="fa fa-angle-right"></i> 받은쪽지함 <span class="cnt"><c:out value="${getCount.unreadRcvMailCnt }"/></span></a>
                        		</li>
                        		<li>
                        			<a href="/mail/getSent"><i class="fa fa-angle-right"></i> 보낸쪽지함 <span class="cnt"><c:out value="${getCount.sntMailCnt }"/></span></a>
                        		</li>
                        		<li>
                        			<a href="/mail/getToMe"><i class="fa fa-angle-right"></i> 내게쓴쪽지함 <span class="cnt"><c:out value="${getCount.toMeMailCnt }"/></span></a>
                        		</li>
                        	</ul>
                        </li>
                        <li>
                            <sec:authorize access="hasRole('ROLE_USER')">
                            <a href="#" id="abp"><i class="fa fa-file-text-o" ></i> 전자결재<span class="fa arrow"></span></a>
	                        	<ul class="nav nav-second-level approval">
	                        		<li>
	                        			<a href="#" id="yetapv" ><i class="fa fa-angle-right"></i> 미결재 <span class="cnt"><c:out value="${getCount.yetApvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="proceeding"><i class="fa fa-angle-right"></i> 진행중 <span class="cnt"><c:out value="${getCount.prcApvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="approvalList"><i class="fa fa-angle-right"></i> 승인 <span class="cnt"><c:out value="${getCount.apvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="rejectedList"><i class="fa fa-angle-right"></i> 반려 <span class="cnt"><c:out value="${getCount.cmpApvCnt }"/></span></a>
	                        		</li>
	                        	</ul>
                        	</sec:authorize>
                            <sec:authorize access="hasRole('ROLE_MEMBER')">
                            <a href="#" id="abp"><i class="fa fa-file-text-o" ></i> 전자결재<span class="fa arrow"></span></a>
	                        	<ul class="nav nav-second-level approval">
	                        		<li>
	                        			<a href="#" id="yetapv"><i class="fa fa-angle-right"></i> 받은 결재 <span class="cnt"><c:out value="${getCount.yetApvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="proceeding"><i class="fa fa-angle-right"></i> 승인한 결재 <span class="cnt"><c:out value="${getCount.prcApvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="rejectedList_mid"><i class="fa fa-angle-right"></i> 반려한 결재 <span class="cnt"><c:out value="${getCount.cmpApvCnt }"/></span></a>
	                        		</li>
	                        	</ul>
                        	</sec:authorize>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <a href="#" id="abp"><i class="fa fa-file-text-o" ></i> 전자결재<span class="fa arrow"></span></a>
	                        	<ul class="nav nav-second-level approval">
	                        		<li>
	                        			<a href="#" id="yetapv_admin"><i class="fa fa-angle-right"></i> 받은 결재 <span class="cnt"><c:out value="${getCount.prcApvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="approvalList_admin"><i class="fa fa-angle-right"></i> 승인한 결재 <span class="cnt"><c:out value="${getCount.apvCnt }"/></span></a>
	                        		</li>
	                        		<li>
	                        			<a href="#" id="rejectedList_admin"><i class="fa fa-angle-right"></i> 반려한 결재 <span class="cnt"><c:out value="${getCount.fnlRejApvCnt }"/></span></a>
	                        		</li>
	                        	</ul>
                        	</sec:authorize>
                      
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-calendar"></i> 일정관리<span class="fa arrow"></span></a>
                           	<ul class="nav nav-second-level calendar">
                        		<li>
                        			<a href="/calendar/calendarList" id="companyCalendar"><i class="fa fa-angle-right"></i> 사내 일정 </a>
                        		</li>
                        		<li>
                        			<a href="#" id="userCalendar"><i class="fa fa-angle-right"></i> 내 일정 </a>
                        		</li>
                        	</ul>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-users"></i> 사원조회<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level admin">
                        		<li>
                        			<a href="/member/memberList" id="mem_memberList"><i class="fa fa-angle-right"></i> 사원조회</a>
                        		</li>
                        	</ul>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-gears"></i> 관리자<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level admin">
                        		<li>
                        			<a href="/admin/memberList" id="memberEdit"><i class="fa fa-angle-right"></i> 사원관리</a>
                        		</li>
                        	</ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav> 
        
        <form name="approval_form" action="/approval/approvalList" method="get">
			<input type='hidden' id="auth" name='auth' value='${pageMaker.cri.auth }'>
			<input type="hidden" id="listKinds" name="listKinds" value="${kinds }">
		</form>
        
        <script src="/resources/js/header.js"></script>
        
        <!-- Page Content -->
        <div id="page-wrapper" style="padding-left:50px; padding-right:50px; background-color:white;">