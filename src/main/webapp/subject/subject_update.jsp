<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../header.jsp" />

<style>
/* システム統一のための共通レイアウト（全体レイアウト） */
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    margin: 0;
}

.layout-box {
    width: 900px; 
    display: flex; 
    min-height: 0;
    height: fit-content;
    align-items: stretch;
    background-color: #ffffff;
    box-sizing: border-box;
}

.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding-left: 20px;
    padding-right: 20px;
}

.menu-header {
    background-color: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-top: 0;
    margin-bottom: 20px;
}

.regist-form {
    width: 95%;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 15px;
    box-sizing: border-box;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.form-label {
    font-size: 13px;
    color: #333;
    font-weight: bold;
}

.readonly-code {
    font-size: 14px;
    color: #333;
    padding: 5px 0;
}

.input-text {
    width: 250px;
    padding: 5px;
    font-size: 13px;
    border: 1px solid #bcbcbc;
    border-radius: 4px;
}

.error-message {
    color: #ff9800;
    font-size: 13px;
    font-weight: bold;
}

.button-box {
    margin-top: 10px;
    margin-bottom: 15px;
}

.btn-submit {
    background-color: #0077cc;
    color: #fff;
    border: none;
    padding: 6px 24px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
}

.btn-submit:hover {
    background-color: #444;
}

.back-link-box a {
    color: #0000ff;
    text-decoration: underline;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">科目情報変更</h2>

            <form action="SubjectUpdateExecute.action" method="post" class="regist-form">

                <!-- 科目コード -->
                <div class="form-group">
                    <label class="form-label">科目コード</label>
                    <span class="readonly-code">${subject.cd}</span>
                    <input type="hidden" name="cd" value="${subject.cd}" />
                </div>

                <!-- エラー -->
                <c:if test="${not empty error_not_found}">
                    <div class="error-message">
                        ${error_not_found}
                    </div>
                </c:if>

                <c:if test="${not empty error_name}">
                    <div class="error-message">
                        ${error_name}
                    </div>
                </c:if>

                <!-- 科目名 -->
                <div class="form-group">
                    <label class="form-label">科目名</label>
                    <input type="text"
                           name="name"
                           class="input-text"
                           value="${not empty name ? name : subject.name}"
                           placeholder="科目名"
                           maxlength="20"
                           required />
                </div>

                <!-- ボタン -->
                <div class="button-box">
                    <button type="submit" class="btn-submit">変更</button>
                </div>

            </form>

            <div class="back-link-box">
                <a href="SubjectList.action">戻る</a>
            </div>

        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />