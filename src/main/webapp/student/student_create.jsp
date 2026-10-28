<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../header.jsp" />

<style>
/* 全体レイアウト */
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    margin: 0;
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

/* ① 画面タイトル */
.menu-header {
    background: #f2f2f2;
    padding: 10px 15px;
    font-size: 1.1em;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
    margin-bottom: 15px;
}

/* フォーム領域 */
.register-form-box {
    width: 95%;
    margin: 0 auto 20px;
}

/* ②④⑥⑧ 入力グループとラベル */
.form-group {
    display: flex;
    flex-direction: column;
    gap: 2px;             
    margin-bottom: 8px;   
}

.form-label {
    font-size: 13px;
    font-weight: normal; /* Chữ thường, không đậm */
}

/* ③⑤⑦⑨ 入力・選択コントロール */
.input-text, .select-box {
    width: 100%;
    padding: 6px 10px;    
    border: 1px solid #bcbcbc;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
    color: #333;
}

.input-text::placeholder {
    color: #999;
}


.input-text:focus, .select-box:focus, .input-error-blue {
    outline: none;
    border: 1px solid #5a9bd5 !important;
}

/* ⑩ 送信ボタン */
.button-submit {
    background: #6c757d;
    color: #fff;
    border: none;
    padding: 6px 15px;    
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    margin-top: 10px;     
    margin-bottom: 10px;
}

.button-submit:hover {
    background: #5a6268;
}

/* エラーメッセージ */
.error-inline {
    color: #ff9900; 
    font-size: 12px;
    display: block;
    margin-top: 2px;
}

/* ⑪ 戻るリンク */
.back-link-box {
    text-align: left;
    margin-top: 5px;      
}

.back-link-box a {
    color: #0000ff;
    text-decoration: underline;
    font-size: 13px;
}
</style>

<div class="main-layout">
    <div class="layout-box">

        <jsp:include page="../sidebar.jsp" />

        <main class="main-tilter">

            <h2 class="menu-header">学生情報登録</h2>

            <div class="register-form-box">
                <form action="StudentCreateExecute.action" method="post">

                    <div class="form-group">
                        <label class="form-label">入学年度</label>
                        <select name="entYear" class="select-box" required
                                oninvalid="this.classList.add('input-error-blue'); this.setCustomValidity('このフィールドに入力してください')"
                                oninput="this.classList.remove('input-error-blue'); this.setCustomValidity('')">
                            <option value="">--------</option>
                            <option value="2020" <c:if test="${entYear == '2020'}">selected</c:if>>2020</option>
                            <option value="2021" <c:if test="${entYear == '2021'}">selected</c:if>>2021</option>
                            <option value="2022" <c:if test="${entYear == '2022'}">selected</c:if>>2022</option>
                            <option value="2023" <c:if test="${entYear == '2023'}">selected</c:if>>2023</option>
                            <option value="2024" <c:if test="${entYear == '2024'}">selected</c:if>>2024</option>
                            <option value="2025" <c:if test="${entYear == '2025'}">selected</c:if>>2025</option>
                            <option value="2026" <c:if test="${entYear == '2026'}">selected</c:if>>2026</option>
                        </select>
                        <span class="error-inline">${entYearError}</span>
                    </div>

                    <div class="form-group">
                        <label class="form-label">学生番号</label>
                        <input type="text" name="no" value="${no}" 
                               class="input-text ${not empty noError ? 'input-error-blue' : ''}" 
                               placeholder="学生番号を入力してください" 
                               required maxlength="10"
                               oninvalid="this.classList.add('input-error-blue'); this.setCustomValidity('このフィールドに入力してください')"
                               oninput="this.classList.remove('input-error-blue'); this.setCustomValidity('')">
                        <span class="error-inline">${noError}</span>
                    </div>

                    <div class="form-group">
                        <label class="form-label">氏名</label>
                        <input type="text" name="name" value="${name}" 
                               class="input-text ${not empty nameError ? 'input-error-blue' : ''}" 
                               placeholder="氏名を入力してください" 
                               required maxlength="30"
                               oninvalid="this.classList.add('input-error-blue'); this.setCustomValidity('このフィールドに入力してください')"
                               oninput="this.classList.remove('input-error-blue'); this.setCustomValidity('')">
                        <span class="error-inline">${nameError}</span>
                    </div>

                    <div class="form-group">
                        <label class="form-label">クラス</label>
                        <select name="classNum" class="select-box" required
                                oninvalid="this.classList.add('input-error-blue'); this.setCustomValidity('このフィールドに入力してください')"
                                oninput="this.classList.remove('input-error-blue'); this.setCustomValidity('')">
                            <option value="">----</option>
                            <c:forEach var="c" items="${classList}">
                                <option value="${c.classNum}" <c:if test="${classNum == c.classNum}">selected</c:if>>
                                    ${c.classNum}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="error-inline">${classError}</span>
                    </div>

                    <input type="submit" value="登録して終了" class="button-submit">
                </form>

                <div class="back-link-box">
                    <a href="StudentList.action">戻る</a>
                </div>
            </div>

        </main>
    </div>
</div>

<jsp:include page="../footer.jsp" />