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
    margin-bottom: 15px;
}

/* 🟢 統一完了メッセージ（緑色の帯スタイル） */
.done-message-box {
    background-color: #a3cfbb;  /* 学生管理の完了メッセージと同じ緑色の背景色 */
    color: #0f5132;            /* 濃い緑の文字 */
    padding: 12px 20px;
    font-size: 14px;
    margin-bottom: 25px;
    border-radius: 4px;
    box-sizing: border-box;
}

/* リンクエリア */
.action-link-box {
    font-size: 14px;
    margin-bottom: 20px;
}

.action-link-box a {
    color: #0000ff;
    text-decoration: underline;
}

/* 「戻る」と「科目一覧」の間に少し余白を空ける */
.link-spacer {
    margin: 0 10px;
    color: #333333;
    text-decoration: none !important;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">科目情報登録</h2>

            <div class="done-message-box">
                登録が完了しました
            </div>

            <div class="action-link-box">
                <a href="SubjectCreate.action">戻る</a>
                <span class="link-spacer"></span>
                <a href="SubjectList.action">科目一覧</a>
            </div>

        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />