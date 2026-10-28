<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>

.main-layout {
    display: flex;
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    padding-bottom: 10px;
    margin-bottom: 100px;
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
}

/* 画面タイトル */
.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 20px;
}

/* 完了メッセージ領域 */
.done-content-box {
    width: 100%;
    margin: 0 auto 20px;
}

/* 成功メッセージ */
.alert-success {
    background-color: #8fbc8f;
    color: #333;
    padding: 5px 15px;
    font-size: 14px;
    margin-bottom: 30px;
    box-sizing: border-box;
    width: 100%;
}

/* リンクエリア（横並び） */
.back-link-wrapper {
    display: flex;
    gap: 25px;
    margin-top: 70px;
}

/* リンクスタイル */
.back-link-box a {
    color: #0066cc;
    font-size: 14px;
    text-decoration: none;
}

.back-link-box a:hover {
    text-decoration: underline;
}

</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">学生情報登録</h2>

            <div class="done-content-box">

                <%-- 成功メッセージ --%>
                <div class="alert-success">
                    登録が完了しました
                </div>

                <%-- リンク（横並び） --%>
                <div class="back-link-wrapper">

                   <div class="back-link-box">
                        <a href="${pageContext.request.contextPath}/auth/menu.jsp">戻る</a>
                    </div>

                    <div class="back-link-box">
                        <a href="StudentList.action">学生一覧</a>
                    </div>
                </div>

            </div>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />