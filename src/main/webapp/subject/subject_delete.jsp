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

/* フォーム全体のレイアウト */
.delete-form {
    width: 95%;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
}

/* 確認メッセージ */
.confirm-message {
    font-size: 14px;
    color: #333333;
    margin-top: 0;
    margin-bottom: 20px;
    line-height: 1.5;
}

/* ボタンエリア */
.button-box {
    margin-bottom: 15px;
}

/* 削除ボタン（画像のような赤色デザインに変更） */
.btn-submit {
    background-color: #dc3545; /* 画像のような警告・削除を表す赤色に変更 */
    color: #ffffff;
    border: none;
    padding: 6px 24px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    transition: background-color 0.2s; /* ホバー時の変化をなめらかに */
}
.btn-submit:hover {
    background-color: #bd2130; /* ホバー時は少し暗い赤色に */
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

            <h2 class="menu-header">科目情報削除</h2>

            <form action="SubjectDeleteExecute.action" method="post" class="delete-form">
                
                <input type="hidden" name="cd" value="<c:out value="${subject.cd}" />" />
                <input type="hidden" name="name" value="<c:out value="${subject.name}" />" />

                <p class="confirm-message">
                    「<c:out value="${subject.name}" />(<c:out value="${subject.cd}" />)」を削除してもよろしいですか
                </p>

                <div class="button-box">
                    <button type="submit" class="btn-submit">削除</button>
                </div>

            </form>

            <div class="back-link-box">
                <a href="SubjectList.action">戻る</a>
            </div>

        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />