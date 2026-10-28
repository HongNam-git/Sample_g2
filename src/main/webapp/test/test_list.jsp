<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 共通ヘッダーの読み込み --%>
<jsp:include page="../header.jsp" />

<style>
/* ===== 画面全体のレイアウト設定 ===== */
.main-layout {
    display: flex;
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    padding-bottom: 10px;
    margin-bottom: 40px;
}

/* コンテンツを表示する中央のボックス枠 */
.layout-box {
    width: 900px;
    display: flex;
    align-items: stretch;
    background-color: #fff;
    box-sizing: border-box;
}

/* サイドバーの右側に位置するメインコンテンツエリア */
.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding: 0 20px;
    box-sizing: border-box;
}

/* 画面上部のメニュータイトル（成績参照） */
.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.2em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 20px;
}

/* ===== 検索セクション全体のデザイン ===== */
.search-section {
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    padding: 12px 18px;
    margin-bottom: 15px;
    background-color: #fff;
}

/* 検索項目を横並びにするレイアウト */
.search-row {
    display: flex;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
}

/* 「科目情報」「学生情報」のラベルタイトル */
.search-label-p {
    font-weight: bold;
    min-width: 80px;
    color: #333;
}

/* 各入力項目（ラベルとフォームのセット）の配置 */
.field-group {
    display: flex;
    flex-direction: column;
}

/* 入力項目の上部に表示する小さな見出し */
label {
    font-size: 12px;
    color: #666;
}

/* セレクトボックスとテキスト入力欄の共通デザイン */
select,
input[type="text"] {
    padding: 5px 6px;
    border: 1px solid #ccc;
    border-radius: 4px;
    min-width: 100px;
    box-sizing: border-box;
    outline: none;
}

/* バリデーションエラー時（未入力時）に枠線を青くするスタイル */
.input-blue {
    border: 2px solid #007bff !important;
    box-shadow: 0 0 4px rgba(0, 123, 255, 0.3);
}

/* 検索ボタンの基本デザイン */
.btn-search {
    background-color: #5b5b5b;
    color: #fff;
    border: none;
    padding: 6px 15px;
    border-radius: 4px;
    cursor: pointer;
}

/* 検索ボタンのホバー（マウスが乗ったとき）の効果 */
.btn-search:hover {
    background-color: #404040;
}

/* ===== メッセージ表示用スタイル ===== */
/* 科目検索エラー（オレンジ色） */
.error-message-subject {
    color: #ff9900;
    font-size: 14px;
    margin-top: 5px;
}

/* 画面下部の一般エラー・学生検索エラー（暗いグレー） */
.error-message-bottom {
    color: #333;
    font-size: 14px;
    margin-top: 10px;
}

/* 初期表示時の操作案内メッセージ（水色） */
.guide-message {
    color: #00bcff;
    font-size: 14px;
    margin-top: 10px;
}

/* 科目検索と学生検索を区切る線 */
.divider {
    border-top: 1px solid #e0e0e0;
    margin: 15px 0;
}
</style>

<div class="main-layout">
<div class="layout-box">

<%-- 共通サイドメニュー（ナビゲーション）の読み込み --%>
<jsp:include page="../sidebar.jsp" />

<main class="main-tilter">

<h2 class="menu-header">成績参照</h2>

<div class="search-section">

    <!-- ==========================================
         1. 科目検索フォーム
         ========================================== -->
    <form action="TestListSubjectExecute.action" method="post">
        
        <%-- リクエスト判定用の隠しパラメータ（sj = Subject） --%>
        <input type="hidden" name="f" value="sj">

        <div class="search-row">
            <p class="search-label-p">科目情報</p>

            <%-- 入学年度の選択（現在年度から過去5年分を動的に生成） --%>
            <div class="field-group">
                <label>入学年度</label>
                <select name="ent_year">
                    <option value="">--------</option>
                    <c:forEach begin="0" end="4" var="i">
                        <option value="${currentYear - i}">
                            ${currentYear - i}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <%-- クラスの選択（classListからループ処理で生成） --%>
            <div class="field-group">
                <label>クラス</label>
                <select name="class_num">
                    <option value="">--------</option>
                    <c:forEach var="c" items="${classList}">
                        <option value="${c.classNum}">
                            ${c.classNum}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <%-- 科目の選択（subjectListからループ処理で生成） --%>
            <div class="field-group">
                <label>科目</label>
                <select name="subject_cd">
                    <option value="">--------</option>
                    <c:forEach var="s" items="${subjectList}">
                        <option value="${s.cd}">
                            ${s.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <%-- 科目検索ボタン --%>
            <button type="submit" class="btn-search" style="margin-top:18px;">
                検索
            </button>
        </div>
    </form>

    <%-- 科目検索かつエラーメッセージが存在する場合に表示 --%>
    <c:if test="${param.f eq 'sj' and not empty subject_error}">
        <div class="error-message-subject">
            ${subject_error}
        </div>
    </c:if>

    <%-- 2つの検索フォームの境界線 --%>
    <div class="divider"></div>

    
         <%--2. 学生検索フォーム --%>
         
    <form action="TestListStudentExecute.action" method="post">

        <%-- リクエスト判定用の隠しパラメータ（st = Student） --%>
        <input type="hidden" name="f" value="st">

        <div class="search-row">
            <p class="search-label-p">学生情報</p>

            <div class="field-group">
                <label>学生番号</label>
                
                
                <input type="text"
                       name="student_no"
                       value="${student_no}"
                       maxlength="10"
                       placeholder="学生番号を入力してください"
                       required
                       oninvalid="this.classList.add('input-blue'); this.setCustomValidity('このフィールドに入力してください')"
                       oninput="this.classList.remove('input-blue'); this.setCustomValidity('')">
            </div>

            <%-- 学生検索ボタン --%>
            <button type="submit" class="btn-search" style="margin-top:18px;">
                検索
            </button>
        </div>
    </form>

</div>



<%-- システムエラーや共通エラーメッセージの表示 --%>
<c:if test="${not empty error}">
    <div class="error-message-bottom">${error}</div>
</c:if>

<%-- 学生検索時のエラーメッセージ（学生が見つからない場合など）の表示 --%>
<c:if test="${not empty student_error}">
    <div class="error-message-bottom">${student_error}</div>
</c:if>

<%-- 学生情報の表示（学生検索が成功し、学生データが存在する場合） --%>
<c:if test="${not empty student}">
    <div style="margin-top:15px;">
        氏名：${student.name}（${student.no}）
    </div>
</c:if>

<%-- 成績一覧のテーブル表示（テスト結果リストが存在する場合） --%>
<c:if test="${not empty testList}">
    <table class="score-table">
        <tr>
            <th>科目名</th>
            <th>科目コード</th>
            <th>回数</th>
            <th>点数</th>
        </tr>

        <%-- 取得した成績リストをループ処理で1行ずつ出力 --%>
        <c:forEach var="t" items="${testList}">
            <tr>
                <td>${t.subjectName}</td>
                <td>${t.subjectCd}</td>
                <td>${t.num}</td>
                <td>${t.point}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<%-- 初期表示時のガイダンス（エラーも検索結果も何もデータがない状態のとき） --%>
<c:if test="${empty error and empty student_error and empty student and empty testList}">
    <div class="guide-message">
        科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
    </div>
</c:if>

</main>
</div>
</div>

<%-- 共通フッターの読み込み --%>
<jsp:include page="../footer.jsp" />