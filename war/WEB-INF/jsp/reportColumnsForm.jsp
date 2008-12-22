<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form method="post">
<jsp:include page="snippets/topnav.jsp"/>
  <h1>
    Report Wizard
  </h1>
  
  <c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
    <h2>${fgroup.name}</h2>

    <c:set var="totalFields" value="${fgroup.fieldCount}"/>
    
    <div class="columns" style="width:100%">
      <c:forEach var="f" items="${fgroup.fields}" begin="0" end="${(totalFields)}" varStatus="inner">
	<c:if test="${f != null}">
	  <div class="column" style="width: 25%">
	    <input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].selected" <c:if test="${f.isDefault}">checked="checked"</c:if> />${f.displayName}
	  </div>
	</c:if>
      </c:forEach>
    <div class="clearColumns"></div>
  </div>
  <BR></c:forEach>
    
    
    <br>
      <br>
	
	<jsp:include page="snippets/navbuttons.jsp"/>
      </form>
      
      
