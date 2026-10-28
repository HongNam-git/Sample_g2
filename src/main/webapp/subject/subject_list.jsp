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
    margin-bottom: 8px;
}

/* 新規登録リンクエリア */
.register-link-box {
    width: 95%;
    margin: 0 auto 10px auto;
    display: flex;
    justify-content: flex-end;
    box-sizing: border-box;
}

/* 新規登録リンク */
.register-link-box a {
    color: #0000ff;
    text-decoration: underline;
    font-size: 14px;
}

/* 📊 科目管理専用：科目一覧テーブル */
.subject-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
    margin-bottom: 20px;
}

/* テーブルのセル */
.subject-table th,
.subject-table td {
    border-bottom: 1px solid #e0e0e0;
    padding: 10px 10px;
    text-align: left;
    vertical-align: middle;
}

/* 行ホバー効果 */
.subject-table tbody tr:hover {
    background-color: #f5f9ff;
}

/* 列ごとの横幅固定 */
.col-code {
    width: 150px;
}

/* 操作列（変更・削除）のセンタリング */
.action-cell {
    text-align: center;
    width: 150px;
}

/* 操作リンク（変更・削除）のスタイル */
.action-cell a {
    color: #0000ff;
    text-decoration: underline;
    margin: 0 8px;
}

/* 戻るリンクエリア */
.back-link-box {
    margin-top: 10px;
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

            <h2 class="menu-header">科目管理</h2>

            <div class="register-link-box">
                <a href="SubjectCreate.action">新規登録</a>
            </div>

            <table class="subject-table">
                <thead>
                    <tr>
                        <th class="col-code">科目コード</th>
                        <th>科目名</th>
                        <th class="action-cell"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="subj" items="${subjectList}">
                        <tr>
                            <td class="col-code"><c:out value="${subj.cd}" /></td>
                            <td><c:out value="${subj.name}" /></td>
                            <td class="action-cell">
                                <a href="SubjectUpdate.action?cd=${subj.cd}">変更</a>
                                <a href="SubjectDelete.action?cd=${subj.cd}">削除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="back-link-box">
                <a href="../auth/menu.jsp">戻る</a>
            </div>

        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />