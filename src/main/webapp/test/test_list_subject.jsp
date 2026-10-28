<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>
.main-layout {
    display: flex;
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.layout-box {
    width: 900px;
    display: flex;
    align-items: stretch;
    background-color: #fff;
    box-sizing: border-box;
}

.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding: 0 20px;
    box-sizing: border-box;
}

.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 20px;
}

.search-section {
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    padding: 15px 20px;
    margin-bottom: 20px;
    background-color: #fff;
}

.search-row {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 10px;
    flex-wrap: wrap;
}

.search-label-p {
    font-weight: bold;
    min-width: 80px;
    color: #333;
    margin: 0;
}

.field-group {
    display: flex;
    flex-direction: column;
    gap: 1px;
}

label {
    font-size: 12px;
    color: #666;
    font-weight: normal;
}

select,
input[type="text"] {
    padding: 6px;
    border: 1px solid #ccc;
    border-radius: 4px;
    min-width: 100px;
    box-sizing: border-box;
}

input[type="text"] {
    width: 220px;
}

.btn-search {
    background-color: #5b5b5b;
    color: white;
    border: none;
    padding: 6px 15px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.btn-search:hover {
    background-color: #404040;
}

.error-message {
    color: red;
    font-size: 14px;
    margin-bottom: 15px;
}

.subject-title-div {
    font-size: 14px;
    margin: 3px 0 10px 0;
    color: #333;
}

.result-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    font-size: 14px;
}

.result-table th {
    border-bottom: 1px solid #bcbcbc;
    padding: 8px;
    text-align: left;
    background-color: #fff;
}

.result-table td {
    border-bottom: 1px solid #e0e0e0;
    padding: 8px;
    color: #333;
}

.divider {
    border: none;
    border-top: 1px solid #e0e0e0;
    margin: 20px 0;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">成績一覧（科目）</h2>

            <div class="search-section">

                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <form action="TestListSubjectExecute.action" method="post">
                    <input type="hidden" name="f" value="sj">

                    <div class="search-row">
                        <p class="search-label-p">科目情報</p>

                        <div class="field-group">
                            <label>入学年度</label>
                            <select name="ent_year">
                                <option value="">--------</option>

                                <c:forEach begin="0" end="4" var="i">
                                    <option value="${currentYear - i}"
                                        <c:if test="${ent_year == (currentYear - i)}">selected</c:if>>
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
                                    <option value="${c.classNum}"
                                        <c:if test="${class_num == c.classNum}">selected</c:if>>
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
                                    <option value="${s.cd}"
                                        <c:if test="${subject_cd == s.cd}">selected</c:if>>
                                        ${s.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <button type="submit" class="btn-search" style="margin-top: 18px;">
                            検索
                        </button>
                    </div>
                </form>

                <div class="divider"></div>

                <form action="TestListStudentExecute.action" method="post">
                    <input type="hidden" name="f" value="st">

                    <div class="search-row">
                        <p class="search-label-p">学生情報</p>

                        <div class="field-group">
                            <label>学生番号</label>

                            <input type="text"
                                   name="student_no"
                                   placeholder="学生番号を入力してください"
                                   value="${student_no}"
                                   maxlength="10">
                        </div>

                        <button type="submit" class="btn-search" style="margin-top: 18px;">
                            検索
                        </button>
                    </div>
                </form>

            </div>

            <c:if test="${not empty testList}">

                <div class="subject-title-div">
                    科目：

                    <c:forEach var="s" items="${subjectList}">
                        <c:if test="${s.cd == subject_cd}">
                            ${s.name}
                        </c:if>
                    </c:forEach>
                </div>

                <table class="result-table">

                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>1回</th>
                            <th>2回</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="t" items="${testList}">
                            <tr>

                                <td>${t.entYear}</td>
                                <td>${t.classNum}</td>
                                <td>${t.studentNo}</td>
                                <td>${t.studentName}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty t.getPoint(1) || t.getPoint(1) == -1}">
                                            -
                                        </c:when>
                                        <c:otherwise>
                                            ${t.getPoint(1)}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty t.getPoint(2) || t.getPoint(2) == -1}">
                                            -
                                        </c:when>
                                        <c:otherwise>
                                            ${t.getPoint(2)}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                            </tr>
                        </c:forEach>

                    </tbody>

                </table>

            </c:if>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />