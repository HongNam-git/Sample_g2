<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>

.main-layout{
    display:flex;
    justify-content:center;
    font-family:'Helvetica Neue', Arial, sans-serif;
    margin-bottom:40px;
}

.layout-box{
    width:900px;
    display:flex;
    background:#fff;
}

.main-content{
    flex:1;
    padding:0 20px;
    border-left:1px solid #bcbcbc;
}

.page-title{
    background:#f2f2f2;
    padding:10px 15px;
    margin-bottom:20px;
    font-size:22px;
    font-weight:bold;
    border-bottom:1px solid #bcbcbc;
}

/* ===== search ===== */

.search-box{
    border:1px solid #ddd;
    border-radius:5px;
    padding:15px 18px;
}

.search-row{
    display:flex;
    align-items:flex-end;
    gap:15px;
    flex-wrap:wrap;
}

.search-label{
    font-weight:bold;
    min-width:80px;
}

.field-group{
    display:flex;
    flex-direction:column;
}

label{
    font-size:12px;
    color:#666;
}

select, input[type="text"]{
    padding:6px 8px;
    border:1px solid #ccc;
    border-radius:4px;
    min-width:120px;
}
.input-text:focus {
    outline: none; 
    border: 2px solid #007bff;
    box-shadow: 0 0 4px rgba(0, 123, 255, 0.3);
}

.btn-search{
    background:#555;
    color:#fff;
    border:none;
    padding:7px 16px;
    border-radius:4px;
}

/* ===== messages ===== */

.error-message{
    color:#ff9900;
    margin-top:10px;
}

.guide-message{
    color:#00a8e8;
    margin-top:15px;
}

/* ===== student ===== */

.student-info{
    margin-top:15px;
}

/* ===== table ===== */

.score-table{
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
}

.score-table th,
.score-table td{
    border-bottom:1px solid #ddd;
    padding:10px;
    background:#fff;
    text-align:left;
}

</style>

<div class="main-layout">

<div class="layout-box">

<jsp:include page="../sidebar.jsp" />

<main class="main-content">

<h2 class="page-title">成績参照</h2>



<div class="search-box">

    <!-- 科目 -->
    <form action="TestListSubjectExecute.action" method="post">

        <div class="search-row">

            <div class="search-label">科目情報</div>

            <div class="field-group">
                <label>入学年度</label>
                <select name="ent_year">
                    <option value="">--------</option>
                    <c:forEach begin="0" end="4" var="i">
                        <option value="${currentYear - i}">
                            ${currentYear - i}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="field-group">
                <label>クラス</label>
                <select name="class_num">
                    <option value="">--------</option>
                    <c:forEach var="c" items="${classList}">
                        <option value="${c.classNum}">
                            ${c.classNum}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="field-group">
                <label>科目</label>
                <select name="subject_cd">
                    <option value="">--------</option>
                    <c:forEach var="s" items="${subjectList}">
                        <option value="${s.cd}">
                            ${s.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <button type="submit" class="btn-search">検索</button>

        </div>

    </form>

    <c:if test="${not empty subject_error}">
        <div class="error-message">${subject_error}</div>
    </c:if>

    <hr>

    <!-- 学生 -->
    <form action="TestListStudentExecute.action" method="post">

        <div class="search-row">

            <div class="search-label">学生情報</div>

            <div class="field-group">
                <label>学生番号</label>
                <input type="text" name="student_no" value="${student_no}">
            </div>

            <button type="submit" class="btn-search">検索</button>

        </div>

    </form>

</div>

<!-- ===================== RESULT ===================== -->

<c:if test="${not empty student_error}">
    <div class="error-message">
        ${student_error}
    </div>
</c:if>

<c:if test="${not empty student}">
    <div class="student-info">
        氏名：${student.name}（${student.no}）
    </div>
</c:if>

<c:if test="${not empty testList}">
    <table class="score-table">

        <tr>
            <th>科目名</th>
            <th>科目コード</th>
            <th>回数</th>
            <th>点数</th>
        </tr>

        <c:forEach var="t" items="${testList}">
            <tr>
                <td>${t.subjectName}</td>
                <td>${t.subjectCd}</td>
                <td>${t.num}</td>
                <td>${t.point}</td>
            </tr>
        </c:forEach>

    </table>
</c:if>

<c:if test="${empty student and empty student_error}">
    <div class="guide-message">
        学生番号を入力して検索してください
    </div>
</c:if>

</main>

</div>

</div>

<jsp:include page="../footer.jsp" />