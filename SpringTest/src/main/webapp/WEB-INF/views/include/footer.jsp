<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
</head>
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<script type="text/javascript">
//반응형 웹사이트 메뉴 펼쳐지는 것 방지
	$(document).ready(function() {
		$('#dataTables-example').DataTable({
			reponsive: true
		});
		$(".sidebar-nav")
		.attr("class", "sidebar-nav navbar-collapse collapse")
		.attr("aria-expanded", 'false')
		.attr("style", "height:1px");
	});
</script>

<body>
	 <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->
</body>
</html>