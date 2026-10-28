<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>

/* 全体 layout(sidebar+ main ) */
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    
    padding-bottom: 10px;
    margin-bottom: 100px;
}

/* メインコンテナ */
.layout-box {
    width: 900px; 
    display: flex; 
    align-items: stretch ;
    background-color: #fff;
    box-sizing: border-box;
}

/* メインコンテンツ領域 */
.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding: 0 20px;
    overflow-y: auto;
}


/* 画面タイトル(学生変更) */
.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 20px;
    margin-top: 20;
}

/* 完了メッセージ領域 */
.done-content-box {
    width: 100%;
    margin: 0 auto 20px;
}

/* 成功メッセージ */
.alert-success {
    background-color: #8fbc8f; 
    color: #333333;
    padding: 5px 15px;
    font-size: 14px;
    margin-bottom: 30px;
    box-sizing: border-box;
    width: 100%;
}

/* 戻るlink */
.back-link-box {
    margin-top: 70px;
}

.back-link-box a {
    color: #0066cc; /* Màu xanh lá cây/xanh biển link chuẩn */
    font-size: 14px;
    text-decoration: none;
}

.back-link-box a:hover {
    text-decoration: underline;
}
</style>


<%-- main layout--%>
<div class="main-layout">
    <div class="layout-box">
		
		<%-- サイドバー表示 --%>
        <jsp:include page="../sidebar.jsp" />
		
		<%-- メインコンテンツ --%>
        <main class="main-tilter">
			
			<%-- 画面タイトル --%>
            <h2 class="menu-header">学生情報変更</h2>

            <div class="done-content-box">
            
                <%-- 更新完了メッセージ --%>
                <div class="alert-success">
                    変更が完了しました
                </div>
				
				<%-- 一覧画面へのリンク --%>
                <div class="back-link-box">
                    <a href="StudentList.action">学生一覧</a>
                </div>
                
            </div>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />