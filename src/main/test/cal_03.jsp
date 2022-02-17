<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	double val1 = Double.parseDouble(request.getParameter("val1"));
	double val2 = Double.parseDouble(request.getParameter("val2"));
	String calsort = request.getParameter("calsort");
	
	switch (calsort){
		case "plus":
			out.print(val1 + val2);
			break;
		case "minus":
			out.print(val1 - val2);
			break;
		case "multi":
			out.print(val1 * val2);
			break;
		case "divide":
			out.print(val1 / val2);
			break;
	}
%>
