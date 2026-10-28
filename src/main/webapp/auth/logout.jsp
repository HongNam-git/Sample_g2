<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 共通ヘッダーの読み込み --%>
<jsp:include page="../header.jsp" />

<style>
/* 全体を中央に配置するcontent */
.logout-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 30px;
    font-family: 'Helvetica Neue', Arial, sans-serif;
}

/* ログアウト画面のメインボックス */
.logout-box {
    width: 650px;
}

/* タイトル部分(ログイン) */
.logout-title {
    background-color: #f2f2f2;
    text-align: left;
    padding: 10px 15px;
    font-size: 1.1em;
    width: 100%;
    box-sizing: border-box;
}

/* コンテンツ全体 (message and link loginを含む)*/
.logout-content {
    padding: 10px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* ログアウト完了メッセージ */
.logout-message {
    color: #000000;
    background-color: #a8d5ba;
    font-size: 0.9em;
    padding: 5px;
    width: 100%;
    box-sizing: border-box;
    text-align: center;
    margin-bottom: 30px;
}

/* ログインリンク */
.logout-link {
    width: 100%;
    text-align: left;
}

/* ログインリンクのデザイン */
.logout-link a {
    color: #0000ff;
    text-decoration: underline;
}
</style>



<div class="logout-wrapper">
    <div class="logout-box">
        <div class="logout-title">
            ログアウト
        </div>
		
        <div class="logout-content">
        	
        	<%-- ログアウト完了メッセージ --%>
            <div class="logout-message">
                ログアウトしました
            </div>
			
			<%-- ログイン画面へのリンク --%>
            <div class="logout-link">
                <a href="login.jsp">ログイン</a>
            </div>
        </div>
    </div>
</div>


<%-- 共通フッターの読み込み --%>
<jsp:include page="../footer.jsp" />