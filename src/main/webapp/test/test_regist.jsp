<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<style>
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    margin: 0;
    padding-bottom: 10px;
}

.layout-box {
    width: 900px; 
    display: flex; 
    align-items: flex-start;
    background-color: #fff;
    box-sizing: border-box;
}

.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding: 0 20px;
    overflow-y: auto;
}

.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.1em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 15px;
}

.error-msg {
    color: red;
    font-size: 13px;
    margin-bottom: 10px;
}

.search-filter-form {
    display: flex;
    align-items: flex-end; 
    gap: 15px;             
    background-color: #fff;
    padding: 15px;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
    margin-bottom: 20px;
    flex-wrap: wrap;       
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 4px;              
}

.filter-label {
    font-size: 12px;
    color: #333;
    font-weight: normal;  
}

.filter-select {
    padding: 6px 10px;
    border: 1px solid #bcbcbc;
    border-radius: 4px;
    font-size: 13px;
    color: #333;
    background-color: #fff;
    min-width: 90px;
    box-sizing: border-box;
}

.select-subject {
    min-width: 160px;
}

.filter-select:focus {
    outline: none;
    border-color: #5a9bd5;
}

.btn-search {
    background: #6c757d;
    color: #fff;
    border: none;
    padding: 6px 18px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    height: 31px;         
    box-sizing: border-box;
}

.btn-search:hover {
    background: #5a6268;
}

.result-section {
    margin-top: 10px;
}

.info-text {
    font-size: 14px;
    margin-bottom: 10px;
    font-weight: normal;
    color: #000;
}

.score-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 15px;
    font-size: 13px;
    border: 1px solid #bcbcbc; 
}

.score-table th,
.score-table td {
    border-left: none;   
    border-right: none;  
    border-top: 1px solid #bcbcbc;   
    border-bottom: 1px solid #bcbcbc;
    padding: 8px 10px;
    text-align: left;
}

.score-table th {
    background-color: #fff;
    font-weight: bold;
}

.point-input-container {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.input-point {
    width: 200px; 
    padding: 4px 6px;
    border: 1px solid #bcbcbc;
    border-radius: 2px;
    font-size: 13px;
    box-sizing: border-box;
}

.field-error-msg {
    color: #ff9900;
    font-size: 11px;
    margin: 0;
    font-weight: normal;
}

.btn-submit-done {
    background: #6c757d;
    color: #fff;
    border: none;
    padding: 8px 15px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
}

.btn-submit-done:hover {
    background: #5a6268;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">成績管理</h2>

            <c:if test="${not empty error}">
                <div class="error-msg">${error}</div>
            </c:if>

            <form action="TestRegist.action" method="post" class="search-filter-form">
                
                <div class="filter-group">
                    <label class="filter-label">入学年度</label>
                    <select name="ent_year" class="filter-select">
                        <option value="">--------</option>
                        <c:forEach begin="0" end="4" var="i">
                            <option value="${currentYear - i}" <c:if test="${param.ent_year == currentYear - i or ent_year == currentYear - i}">selected</c:if>>
                                ${currentYear - i}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">クラス</label>
                    <select name="class_num" class="filter-select">
                        <option value="">--------</option>
                        <c:forEach var="c" items="${classList}">
                            <option value="${c.classNum}" <c:if test="${param.class_num eq c.classNum or class_num eq c.classNum}">selected</c:if>>
                                ${c.classNum}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">科目</label>
                    <select name="subject_cd" class="filter-select select-subject">
                        <option value="">--------</option>
                        <c:forEach var="s" items="${subjectList}">
                            <option value="${s.cd}" <c:if test="${param.subject_cd eq s.cd or subject_cd eq s.cd}">selected</c:if>>
                                ${s.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">回数</label>
                    <select name="no" class="filter-select">
                        <option value="">--------</option>
                        <c:forEach begin="1" end="10" var="i">
                            <option value="${i}" <c:if test="${param.no == i or no == i}">selected</c:if>>
                                ${i}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn-search">検索</button>
            </form>

            <c:if test="${not empty studentList}">
                <div class="result-section">
                    
                    <p class="info-text">
                        科目：
                        <c:forEach var="s" items="${subjectList}">
                            <c:if test="${s.cd eq subject_cd or param.subject_cd eq s.cd}">${s.name}</c:if>
                        </c:forEach>
                        （${not empty no ? no : param.no}回）
                    </p>

                    <form action="TestRegistExecute.action" method="post">
                        
                        <input type="hidden" name="ent_year" value="${not empty ent_year ? ent_year : param.ent_year}">
                        <input type="hidden" name="class_num" value="${not empty class_num ? class_num : param.class_num}">
                        <input type="hidden" name="subject_cd" value="${not empty subject_cd ? subject_cd : param.subject_cd}">
                        <input type="hidden" name="no" value="${not empty no ? no : param.no}">

                        <table class="score-table">
                            <thead>
                                <tr>
                                    <th>入学年度</th>
                                    <th>クラス</th>
                                    <th>学生番号</th>
                                    <th>氏名</th>
                                    <th>点数</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="st" items="${studentList}" varStatus="status">
                                    <tr>
                                        <td>${st.entYear}</td>
                                        <td>${st.classNum}</td>
                                        <td>
                                            ${st.no}
                                            <input type="hidden" name="student_no" value="${st.no}">
                                        </td>
                                        <td>${st.name}</td>
                                        <td>
                                            <div class="point-input-container">
                                                
                                                <c:set var="pointValue" value="" />
                                                
                                                <c:forEach var="t" items="${testList}">
                                                    <c:if test="${t.student.no eq st.no}">
                                                        <c:set var="pointValue" value="${t.point == -1 ? '' : t.point}" />
                                                    </c:if>
                                                </c:forEach>
                                                
                                                <c:if test="${not empty inputPoints}">
                                                    <c:set var="pointValue" value="${inputPoints[status.index] == -1 ? '' : inputPoints[status.index]}" />
                                                </c:if>
                                                
                                                <input type="text" name="point" value="${pointValue}" class="input-point">
                                                
                                                <c:if test="${not empty errors[status.index]}">
                                                    <span class="field-error-msg">※ ${errors[status.index]}</span>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <button type="submit" class="btn-submit-done">登録して終了</button>
                    </form>
                </div>
            </c:if>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />