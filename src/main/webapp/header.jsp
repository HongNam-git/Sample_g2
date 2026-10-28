<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="bean.Teacher" %>

<%
Teacher teacher =
    (Teacher) session.getAttribute("teacher");
%>

<style>

.header-box {
    width: 900px;
    margin: 20px auto;
    background-color: #e6f2ff;
    border: 1px solid #bcbcbc;
    padding: 20px;

    box-sizing: border-box;

    font-family: 'Helvetica Neue', Arial, sans-serif;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header-box h1 {
    margin: 0;
    font-size: 32px;
}

/* 右上 */
.header-right {
    font-size: 14px;
}

/* ログアウトリンク */
.logout-link {
    margin-left: 15px;
    color: blue;
    text-decoration: underline;
}

</style>

<div class="header-box">

    <!-- タイトル -->
    <h1>得点管理システム</h1>

    <!-- 右上 -->
    <div class="header-right">

        <%
        if (teacher != null) {
        %>

            <%= teacher.getName() %> 様

            <a class="logout-link"
               href="<%= request.getContextPath() %>/auth/Logout.action">

                ログアウト

            </a>

        <%
        }
        %>

    </div>

</div>