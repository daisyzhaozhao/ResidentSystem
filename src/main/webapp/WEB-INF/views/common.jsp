<%@page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" ></c:set>
<link href="${ctx}/css/indexstyle.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/main.css" rel="stylesheet" type="text/css" />	
<script src="${ctx}/js/easyui/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${ctx}/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
<link href="${ctx}/js/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/plupload-2.1.0/js/plupload.full.min.js"
	type="text/javascript"></script>
<script src="${ctx}/js/jquery.form.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.serializeJson.js" type="text/javascript"></script>