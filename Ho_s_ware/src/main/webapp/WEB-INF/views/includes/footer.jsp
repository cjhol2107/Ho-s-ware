<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>
    <script src="/resources/dist/js/sb-admin-2.js"></script>
	<script src="/resources/naver_editor/js/HuskyEZCreator.js" charset="utf-8"></script>
	
<script>
	// 사이드메뉴 열림방지(모바일)
    $(document).ready(function() {
        $(".sidebar-nav")
        .attr("class","sidebar-nav navbar-collapse collapse")
        .attr("aria-expanded",'false')
        .attr("style","height:1px");
    });
</script>

</body>
</html>