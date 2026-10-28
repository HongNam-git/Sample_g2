<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />

<style>
/* 全体レイアウト */
.main-layout {
    display: flex; 
    justify-content: center;
    font-family: "MS Gothic", "MS UI Gothic", sans-serif;
    margin: 0;
}

/* sidebarとmain contentを含む領域 */
.layout-box {
    width: 900px; 
    display: flex; 
      
    min-height:0;
    height: fit-content;
    align-items: stretch;
    background-color: #ffffff;
    box-sizing: border-box;
}

/* main content(メニュー文字) */
.main-tilter {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    
    border-left: 1px solid #bcbcbc;
    padding-left: 20px;
}

/* メニュー見出し */
.menu-header {
    background-color: #f2f2f2;
    padding: 10px 15px;
    font-weight: bold;
    border-bottom: 1px solid #bcbcbc;
}

/* メニューカード配置 */
.menu-grid {
    padding: 50px 20px;
    display: flex;
    justify-content: center;
    gap: 15px;
    align-items: flex-start;
}

/* 各機能カード */
.card {
    width: 200px;
    height: 120px;
    border: 1px solid #ccc;
    
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    
    box-shadow: 4px 4px 8px rgba(0,0,0,0.1);
    border-radius: 8px;
    transition: transform 0.2s;
}

/* カード背景色 */
.card-student { background-color: #f8cecc; }
.card-score { background-color: #d5e8d4; }
.card-subject { background-color: #e1d5e7; }

/*link デザイン */
.card a {
    color: #0000ff;
    text-decoration: underline;
    margin: 2px 0;
}

/* マウスオーバー時 */
.card a:hover {
    color: #0056b3;
}
</style>

<div class="main-layout">
    <div class="layout-box">
        
        <!-- sidebar -->
        <jsp:include page="../sidebar.jsp" />
		
		<!-- メイン画面 -->
        <main class="main-tilter">
            <div class="menu-header">メニュー</div>
            
            <div class="menu-grid">
            
            	<!-- 学生管理 -->
                <div class="card card-student">
                    <a href="../student/StudentList.action">学生管理</a>
                </div>
				
				<!-- 成績管理 -->
                <div class="card card-score">
                    <span style="font-weight:bold; margin-bottom:5px;">成績管理</span>
                    <a href="../test/TestRegist.action">成績登録</a>
                    <a href="../test/TestList.action">成績参照</a>
                </div>
				
				<!-- 科目管理 -->
                <div class="card card-subject">
                    <a href="../subject/SubjectList.action">科目管理</a>
                </div>
            </div>
        </main>

    </div>
</div>

<jsp:include page="../footer.jsp" />