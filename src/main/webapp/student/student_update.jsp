<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>
/* 全体レイアウト */
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    margin-bottom: 20px;
    padding-bottom: 10px;
}

/* メイン枠 */
.layout-box {
    width: 900px; 
    display: flex; 
    align-items: flex-start;
    background-color: #fff;
    box-sizing: border-box;
}

/* メイン領域 */
.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    border-left: 1px solid #bcbcbc;
    padding: 0 20px;
    overflow-y: auto;
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

/* フォーム領域 */
.update-form-box {
    width: 95%;
    margin: 0 auto 20px;
}

/* 入力グループ */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

/* ラベル */
.form-label {
    font-size: 13px;
    font-weight: bold;
}

/* 読み取り専用 */
.input-readonly-text {
    width: 100%;
    padding: 6px 5px;
    border: none;
    background: transparent;
    font-size: 14px;
    pointer-events: none;
}

/* 入力・選択 */
.input-text, .select-box {
    width: 100%;
    padding: 6px;
    border: 1px solid #bcbcbc;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

.input-text:focus {
    outline: none;
}

/* チェックボックス */
.checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    margin-bottom: 20px; 
}

/* 送信ボタン */
.button-submit {
    background: #007bff;
    color: #fff;
    border: none;
    padding: 8px 15px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
}

.button-submit:hover {
    background: #0056b3;
}

/* エラーメッセージ */
.error-inline {
    color: red;
    font-size: 12px;
}

/* 戻るリンク */
.back-link-box {
    margin-top: 10px;
}

.back-link-box a {
    color: blue;
    font-size: 13px;
}

/* エラー時の入力強調 */
.input-error-blue {
    border: 2px solid #5a9bd5 !important;
}
    
</style>

<div class="main-layout">
    <div class="layout-box">

        <!-- サイドバー -->
        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <!-- 画面タイトル -->
            <h2 class="menu-header">学生情報変更</h2>

            <div class="update-form-box">
                <form action="StudentUpdateExecute.action" method="post">

                    <!-- 入学年度 -->
                    <div class="form-group">
                        <label class="form-label">入学年度</label>
                        <input type="text" name="ent_year" value="${student.entYear}" class="input-readonly-text" readonly>
                        <span class="error-inline">${entYearError}</span>
                    </div>

                    <!-- 学生番号 -->
                    <div class="form-group">
                        <label class="form-label">学生番号</label>
                        <input type="text" name="no" value="${student.no}" class="input-readonly-text" readonly>
                    </div>

                    <!-- 氏名 -->
                    <div class="form-group">
                        <label class="form-label">氏名</label>
                        <input type="text" name="name"
                               value="${student.name}"
                               class="input-text ${not empty nameError ? 'input-error-blue' : ''}"
                               required maxlength="30"
                               oninvalid="this.classList.add('input-error-blue'); this.setCustomValidity('このフィールドに入力してください')"
                               oninput="this.classList.remove('input-error-blue'); this.setCustomValidity('')">
                        <span class="error-inline">${nameError}</span>
                    </div>

                    <!-- クラス -->
                    <div class="form-group">
                        <label class="form-label">クラス</label>
                        <select name="class_num" class="select-box">
                            <c:forEach var="c" items="${classList}">
                                <option value="${c.classNum}" <c:if test="${student.classNum == c.classNum}">selected</c:if>>
                                    ${c.classNum}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="error-inline">${classError}</span>
                    </div>

                    <!-- 在学中 -->
                    <div class="checkbox-group">
                        <label class="form-label">在学中</label>
                        <input type="checkbox" name="is_attend" <c:if test="${student.attend}">checked</c:if>>
                    </div>

                    <!-- 送信ボタン -->
                    <input type="submit" value="変更" class="button-submit">
                </form>

                <!-- 戻る -->
                <div class="back-link-box">
                    <a href="StudentList.action">戻る</a>
                </div>
            </div>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />