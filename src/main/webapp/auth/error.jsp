<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<style>

.main-layout{
    display:flex;
    width:100%;
    min-height:300px;
}

.error-wrapper-before-login{
    width:350px;
    margin:50px auto;
    font-family:'Helvetica Neue', Arial, sans-serif;
    text-align:center;
}

.error-wrapper-after-login{
    padding:20px 40px;
    flex-grow:1;
    font-family:'Helvetica Neue', Arial, sans-serif;
}

.error-message{
    font-size:14px;
    color:black;
}

.error-number{
    color:red;
    font-size:20px;
    font-weight:bold;
    margin-right:8px;
    vertical-align:middle;
}

</style>

<c:choose>

    <c:when test="${not empty sessionScope.teacher}">

        <div class="main-layout">

            <jsp:include page="../sidebar.jsp" />

            <div class="error-wrapper-after-login">
                <p class="error-message">
                    <span class="error-number"></span>エラーが発生しました
                </p>
            </div>

        </div>

    </c:when>

    <c:otherwise>

        <div class="error-wrapper-before-login">
            <p class="error-message">
                エラーが発生しました
            </p>
        </div>

    </c:otherwise>

</c:choose>

<jsp:include page="../footer.jsp" />