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

/* メインコンテンツとサイドバーを含むコンテナ */
.layout-box {
    width: 900px; 
    display: flex; 
    min-height: 0;
    height: fit-content;
    align-items: stretch;
    background-color: #ffffff;
    box-sizing: border-box;
}

/* メインコンテンツ領域 */
.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding-left: 20px;
    padding-right: 20px;
}

/* 画面タイトル */
.menu-header {
    background-color: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-top: 0;
    margin-bottom: 20px;
}

/* 登録フォーム全体のレイアウト */
.regist-form {
    width: 95%;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 15px;
    box-sizing: border-box;
}

/* フォームの各行 */
.form-row {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

/* ラベルのスタイル */
.form-row label {
    font-size: 13px;
    color: #333333;
    font-weight: bold;
}

/* 入力テキストボックススタイル */
.input-text {
    width: 95%; /* スマートな入力幅に固定 */
    padding: 5px;
    font-size: 13px;
    border: 1px solid #bcbcbc;
    border-radius: 4px;
    box-sizing: border-box;
    background-color: #ffffff;
}

/* エラーメッセージ（オレンジ色） */
.error-message {
    color: #ff9800; 
    font-size: 13px;
    font-weight: bold;
    margin-top: 2px;
}

/* ボタンエリア */
.button-box {
    margin-top: 10px;
    margin-bottom: 15px;
}

/* 登録ボタン（学生管理の絞込みボタンと同じグレーデザイン） */
.btn-submit {
    background-color: #1e88e5;
    color: #ffffff;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
}
.btn-submit:hover {
    background-color: #444444;
}

/* 戻るリンクエリア */
.back-link-box {
    margin-bottom: 20px;
}
.back-link-box a {
    color: #0000ff;
    text-decoration: underline;
    font-size: 14px;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">科目情報登録</h2>

            <form action="SubjectCreateExecute.action" method="post" class="regist-form">
                
                <div class="form-row">
                    <label for="cd">科目コード</label>
                    <input type="text" 
                           id="cd"
                           name="cd" 
                           value="<c:out value="${cd}" />" 
                           placeholder="科目コードを入力してください" 
                           class="input-text"
                           maxlength="3"
                           required>
                    
                    <c:if test="${not empty error_cd}">
                        <div class="error-message">
                            <c:out value="${error_cd}" />
                        </div>
                    </c:if>
                </div>

                <div class="form-row">
                    <label for="name">科目名</label>
                    <input type="text" 
                           id="name"
                           name="name" 
                           value="<c:out value="${name}" />" 
                           placeholder="科目名を入力してください" 
                           class="input-text"
                           maxlength="20"
                           required>
                    
                    <c:if test="${not empty error_name}">
                        <div class="error-message">
                            <c:out value="${error_name}" />
                        </div>
                    </c:if>
                </div>

                <div class="button-box">
                    <button type="submit" class="btn-submit">登録</button>
                </div>

            </form>

            <div class="back-link-box">
                <a href="SubjectList.action">戻る</a>
            </div>

        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />