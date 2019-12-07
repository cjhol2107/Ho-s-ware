<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">

<title>Ho's Board</title>

<link rel='stylesheet' href='//cdn.jsdelivr.net/font-kopub/1.0/kopubdotum.css'>
<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css?ver1.2"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="/resources/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css?ver1.0" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>


<body>



	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="background-color: #3388BF">
		
		<!-- /.navbar-header -->
		
			<ul class="nav navbar-top-links navbar-right">
				
					<li>
					<a href="#" > 
						<div class="top-menu"><i class="fa fa-user"> 프로필</i></div>
					</a>
					</li>
					<li>
						<a href="#"> 
							<div class="top-menu"><i class="fa fa-sign-in"> 로그인</i></div>
						</a>
					</li>
					<li>
						<a href="#"> 
							<div class="top-menu"><i class="fa fa-gear"> 회원가입</i></div>
						</a>  
					</li>  
		 	
				
			</ul>
		
	</nav>
	
	<nav class="navbar navbar-default navbar-static-top" role="navigation">
		<div class="col-lg-12-header">
			<div class="header-default">
		
                <div class="col-xs-6 col-sm-3">
				   <a href="/freeBoard/list"><img class="page-header-logo" src='/resources/img/logo.jpg'></a>
                </div>
                
                <div class="col-xs-6" style="text-align:center">
                	<a class="a-header-main" href="/freeBoard/list">
				  	 	<h2 class="h2-header-main">Ho's GroupWare</h2><br>
				   		<h5 class="h5-header-main">편리한 그룹웨어 시작해보세요!</h5>
					</a> 
                </div>
            </div>
           </div>
	</nav>
	
     
     
     <div class="navbar-default sidebar " role="navigation" style="height:100%">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                      
                        
                        <li>
                            <a href="#"><i class="fa fa-list-alt"></i> 게시판<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="flot.html">자유게시판</a>
                                </li>
                                <li>
                                    <a href="morris.html">공지사항</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="tables.html" ><i class="fa fa-envelope-o"></i>  편지함</a>
                        </li>
                        <li>
                            <a href="forms.html"><i class="fa fa-file-text-o"></i> 전자결재</a>
                        </li>
                        <li>
                            <a href="tables.html"><i class="fa fa-calendar"></i> 일정관리</a>
                        </li>
                        
                        <li>
                            <a href="forms.html"><i class="fa fa-gears"></i> 관리자</a>
                        </li>
                       
                       
                       
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
           
     

	<div id="page-wrapper" style="padding-left:250px">

		