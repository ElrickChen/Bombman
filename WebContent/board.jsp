<%@page contentType="text/html" pageEncoding="UTF-8"
	errorPage="error.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="game.record.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Record Board</title>
</head>
<body>
	<%
		ArrayList<recorddata> myList = (ArrayList<recorddata>) request.getServletContext().getAttribute("re");
		for (int i = 0; i < myList.size(); i++) {
	%><strong><%=i + 1%> </strong><%=myList.get(i).toString()%><br />
	<%
		}
	%>
	<br />
	<a href="game.jsp">再玩一次</a> <a href="wel.html">回首頁</a>
</body>
</html>