<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* sidebarー全体 */
.sidebar-container {
    width: 200px;
    background-color: #ffffff;
    padding: 20px;
    font-family: 'Helvetica Neue', Arial, sans-serif;
    
    min-height: 200px; 
    display: flex;
    flex-direction: column;
}

/* menu list */
.sidebar-nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    line-height: 2;
}

/* menu link */
.sidebar-nav a {
    color: #007bff;
    text-decoration: underline;
    font-size: 14px;
}

/* 訪問済みlink */
.sidebar-nav a:visited {
    color: #6a0dad;
}

/* マウスオーバー時 */
.sidebar-nav a:hover {
    color: #0056b3;
}

/* 「成績管理」ラベル */
.label-text {
    color: #333;
    font-size: 14px;
    font-weight: normal;
}

/*sub menu*/
.sub-menu {
    padding-left: 15px !important;
}
</style>

<aside class="sidebar-container">
    <nav class="sidebar-nav">
        <ul>
        	<!-- メニュー -->
            <li>
                <a href="${pageContext.request.contextPath}/auth/menu.jsp">メニュー</a>
            </li>
			
			<!-- 学生管理 -->
            <li>
                <a href="${pageContext.request.contextPath}/student/StudentList.action">学生管理</a>
            </li>
			
			<!-- 成績管理 -->
            <li>
                <span class="label-text">成績管理</span>
                <ul class="sub-menu">
                    <li>
                        <a href="${pageContext.request.contextPath}/test/TestRegist.action">成績登録</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/test/TestList.action">成績参照</a>
                    </li>
                </ul>
            </li>
			
			<!-- 科目管理 -->
            <li>
                <a href="${pageContext.request.contextPath}/subject/SubjectList.action">科目管理</a>
            </li>
        </ul>
    </nav>
</aside>