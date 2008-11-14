<%@ include file="/WEB-INF/jsp/include.jsp" %>

<form method="post">
  <h1>
    Report Wizard
  </h1>
  
  <c:forEach var="fgroup" items="${fieldGroups}" varStatus="outer">
    <h2>${fgroup.name}</h2>
    <c:set var="totalFields" value="10"/>
    
    <div class="columns" style="width:100%">
      <c:forEach var="f" items="${fgroup.fields}" begin="0" end="${(totalFields div 2)+((totalFields%2)-1)}" varStatus="inner">
	<c:if test="${f != null}">
	  <div class="column" style="width: 25%">
	    <input type=checkbox name="fieldGroups[${outer.count-1}].fields[${inner.count-1}].selected" <c:if test="${f.isDefault}">checked="checked"</c:if> />${f.displayName}
	  </div>
	</c:if>
      </c:forEach>
    <div class="clearColumns"></div>
  </div>
  <div class="columns" style="width: 100%">
      <c:forEach var="f" items="${fgroup.fields}" begin="${(totalFields div 2)+((totalFields%2))}">
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
      
      
