<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../header.jsp" />

<style>

.main-layout{
    display:flex;
    justify-content:center;
    font-family:'Helvetica Neue', Arial, sans-serif;
    margin:0;
}

.layout-box{
    width:900px;
    display:flex;
    min-height:0;
    height:fit-content;
    align-items:stretch;
    background-color:#ffffff;
    box-sizing:border-box;
}

.main-tilter{
    flex-grow:1;
    display:flex;
    flex-direction:column;
    border-left:1px solid #bcbcbc;
    padding-left:20px;
    padding-right:20px;
}

.menu-header{
    background-color:#f2f2f2;
    padding:10px 15px;
    font-size:1.2em;
    font-weight:bold;
    border-bottom:1px solid #bcbcbc;
    margin-top:0;
    margin-bottom:8px;
}

.register-link-box{
    width:95%;
    margin:0 auto 10px auto;
    display:flex;
    justify-content:flex-end;
    box-sizing:border-box;
}

.register-link-box a{
    color:#0000ff;
    text-decoration:underline;
    font-size:14px;
}

.filter-box{
    width:95%;
    border:1px solid #d0d0d0;
    background-color:#ffffff;
    padding:8px 20px;
    margin:0 auto 10px auto;
    box-sizing:border-box;
    border-radius:4px;
}

.error-message{
    color:red;
    font-size:13px;
    margin-bottom:10px;
    line-height:1.6;
}

.search-filter-form{
    display:flex;
    align-items:flex-end;
    gap:20px;
    font-size:13px;
}

.filter-group{
    display:flex;
    flex-direction:column;
    gap:5px;
}

.filter-group select{
    width:150px;
    padding:5px;
    border:1px solid #bcbcbc;
    border-radius:4px;
}

.checkbox-group{
    display:flex;
    align-items:center;
    gap:5px;
}

.button-search{
    background-color:#666666;
    color:#ffffff;
    border:none;
    padding:6px 12px;
    border-radius:4px;
    font-size:13px;
    cursor:pointer;
    margin-left:40px;
}

.button-search:hover{
    background-color:#444444;
}

.result-count{
    width:95%;
    margin:0 auto 10px auto;
    font-size:13px;
}

.student-table{
    width:100%;
    border-collapse:collapse;
    font-size:13px;
    margin-bottom:20px;
}

.student-table th,
.student-table td{
    border-bottom:1px solid #e0e0e0;
    padding:6px 10px;
    text-align:left;
}

.student-table tbody tr:hover{
    background-color:#f5f9ff;
}

.student-table td.attend-cell{
    font-size:22px;
    font-weight:300;
    text-align:center;
}

.student-table td.action-cell{
    text-align:center;
}

.student-table td.action-cell a{
    color:#0000ff;
    text-decoration:underline;
}

.no-data-msg{
    margin-top:10px;
    font-size:13px;
}

.back-link-box{
    margin-top:10px;
    margin-bottom:20px;
}

.back-link-box a{
    color:#0000ff;
    text-decoration:underline;
    font-size:13px;
}

</style>

<div class="main-layout">

    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">学生管理</h2>

            <div class="register-link-box">
                <a href="StudentCreate.action">新規登録</a>
            </div>

            <div class="filter-box">

                <c:if test="${not empty error}">
                    <div class="error-message">
                        ${error}
                    </div>
                </c:if>

                <form action="StudentList.action"
                      method="get"
                      class="search-filter-form">

                    <div class="filter-group">
                        <label>入学年度</label>

                        <select name="f1">

                            <option value="">
                                --------
                            </option>

                            <c:forEach var="year" items="${ent_year}">
                                <option value="${year}"
                                    ${year == f1 ? 'selected' : ''}>
                                    ${year}
                                </option>
                            </c:forEach>

                        </select>
                    </div>

                    <div class="filter-group">
                        <label>クラス</label>

                        <select name="f2">

                            <option value=""
                                ${empty f2 ? 'selected' : ''}>
                                --------
                            </option>

                            <c:forEach var="cNum" items="${classList}">
                                <option value="${cNum.classNum}"
                                    ${f2 == cNum.classNum ? 'selected' : ''}>
                                    ${cNum.classNum}
                                </option>
                            </c:forEach>

                        </select>
                    </div>

                    <div class="checkbox-group">

                        <input type="checkbox"
                               name="f3"
                               value="t"
                               ${f3 == 't' ? 'checked' : ''}>

                        <label>在学中</label>

                    </div>

                    <button type="submit" class="button-search">
                        絞込み
                    </button>

                </form>

            </div>

            <c:if test="${not empty list}">
                <div class="result-count">
                    検索結果：${total}件
                </div>
            </c:if>

            <c:if test="${not empty list}">

                <table class="student-table">

                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>クラス</th>
                            <th>在学中</th>
                            <th></th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="s" items="${list}">

                            <tr>

                                <td>${s.entYear}</td>
                                <td>${s.no}</td>
                                <td>${s.name}</td>
                                <td>${s.classNum}</td>

                                <td class="attend-cell">

                                    <c:choose>

                                        <c:when test="${s.attend}">
                                            ○
                                        </c:when>

                                        <c:otherwise>
                                            ×
                                        </c:otherwise>

                                    </c:choose>

                                </td>

                                <td class="action-cell">
                                    <a href="StudentUpdate.action?no=${s.no}">
                                        変更
                                    </a>
                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                </table>

            </c:if>

            <c:if test="${empty list}">
                <div class="no-data-msg">
                    学生の情報が存在しませんでした
                </div>
            </c:if>

            <div class="back-link-box">
                <a href="../auth/menu.jsp">戻る</a>
            </div>

        </main>

    </div>

</div>

<jsp:include page="../footer.jsp" />