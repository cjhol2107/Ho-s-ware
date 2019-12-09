<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">
<link rel='stylesheet' href='//cdn.jsdelivr.net/font-kopub/1.0/kopubdotum.css'>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link href="/resources/vendor/bootstrap/css/bootstrap.min.css?ver1.2" rel="stylesheet">
<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css?ver1.0" rel="stylesheet">
<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="text-center">

	<div class="row" style="margin-top:50px">
	    <img src="/resources/img/error403.png" width="350px" height="350px">
	</div>
	
	<div style="font-size:70px">Error 403</div>
	<h2>Forbidden</h2>
	<h3><small>접근이 제한된 페이지입니다</small></h3>

</div>

</body>

<script>
$("div").remove(".sidebar");
$("nav").remove(".navbar");
$("#page-wrapper").attr("id","");
</script>

</html>