<%@page contentType="text/html" pageEncoding="UTF-8"
	errorPage="error.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Record</title>
</head>
<body>
	<h1>
		消耗時間
		<%=request.getServletContext().getAttribute("ptime")%></h1>
	<h2>
		箱子屍體<%=request.getServletContext().getAttribute("pnumber")%></h2>
	<form method="GET" action="/Bombman/recordboard">
		輸入姓名 <input type="text" name="na" size=6 maxlength=12><br>
		<input type="submit" name="Submit" value="傳送">
	</form>

</body>
</html>
