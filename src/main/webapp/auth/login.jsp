<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="jakarta.tags.core"%>

<jsp:include page="../header.jsp" />

<style>
/* 画面全体のレイアウト設定(中央配置）) */
.login-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 10px;
    margin-bottom: 10px;
    font-family: 'Helvetica Neue', Arial, sans-serif;
}

/* ログインボックスの外枠 */
.login-box {
    width: 350px;
    border: 1px solid #bcbcbc;
    background-color: #ffffff;
}

/* ログインタイトルのスタイル */
.login-box h2 {
    background-color: #e2e2e2;
    padding: 6px;
    margin: 0;
    border-bottom: 1px solid #bcbcbc;
    font-weight: bold;
    text-align: center;
    font-size: 1.4em;
}

/* フォーム内の余白設定 */
.login-form {
    padding: 15px 20px;
}

/* 入力項目（ID・パスワード）のスタイル */
.input-item {
    border: 1px solid #bcbcbc;
    margin-bottom: 8px;
    padding: 4px 10px;
    
    border-radius: 6px;
    background-color: #e6f2ff;
}

/* ラベル(ID, パスワード）)のスタイル */
.input-item label {
    display: block;
    font-size: 0.9em;
    color: #666;
}

/* テキスト入力欄のスタイル*/
.input-item input {
    width: 100%;
    border: none;
    outline: none;
    font-size: 1.1em;
    background: transparent;
    padding: 0;
}

/* チェックボックスエリアのスタイル */
.login-check {
    font-size: 0.9em;
    margin: 8px 0;
    text-align: center;
}

/* ログインボタンのスタイル */
.login-button-submit {
    display: block;
    margin: 0 auto;
    width: 140px;

    background-color: #0070c0;
    color: white;

    padding: 10px 20px;

    border: none;
    border-radius: 8px;

    cursor: pointer;
    font-weight: bold;
    font-size: 0.9em;
}

/* ボタンホバー時のエフェクト */
.login-button-submit:hover {
    background-color: #005a9e;
}

/* エラーメッセージの表示スタイル */
.login-error-outside {
    color: black;
    font-size: 0.8em;
    margin-bottom: 5px;
    width: 350px;
    text-align: left;
}

</style>

<div class="login-wrapper">

    <!-- エラーメッセージ -->
    <c:if test="${not empty error}">
        <div class="login-error-outside">
            ${error}
        </div>
    </c:if>

    <div class="login-box">

        <h2>ログイン</h2>

        <form action="LoginExecute.action"
              method="post"
              class="login-form">

            <!-- ログインID -->
            <div class="input-item">

                <label for="id">
                    ＩＤ
                </label>

                <input type="text"
                       name="id"
                       id="id"
                       value="${id}"
                       maxlength="10"
                       style="ime-mode: inactive;"
                       required
                       oninvalid="this.setCustomValidity('このフィールドに入力してください')"
                       oninput="this.setCustomValidity('')">
            </div>

            <!-- パスワード -->
            <div class="input-item">

                <label for="password">
                    パスワード
                </label>

                <input type="password"
                       name="password"
                       id="password"
                       maxlength="30"
                       style="ime-mode: inactive;"
                       required
                       oninvalid="this.setCustomValidity('このフィールドに入力してください')"
                       oninput="this.setCustomValidity('')">
            </div>

            <!-- パスワード表示 -->
            <div class="login-check">

                <input type="checkbox"
                       id="chk_d_ps">

                <label for="chk_d_ps">
                    パスワードを表示
                </label>

            </div>

            <!-- フォーム送信ボタン -->
            <input type="submit"
                   name="login"
                   value="ログイン"
                   class="login-button-submit">
        </form>

    </div>

</div>

<script>
/**
 * チェックボックスの選択状態により、パスワードの表示/非表示を切り替える
 */
document.getElementById("chk_d_ps")
    .addEventListener("change", function () {

        const passInput =
            document.getElementById("password");

        passInput.type =
            this.checked ? "text" : "password";});



</script>

<jsp:include page="../footer.jsp" />