<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-store");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html" charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.min.css" />
<script src="js/all.min.js"></script>

<title>Style test</title>
<script>
	var xhrObject; //XMLHttpRequest 객체를 저장할 변수를 전역변수로 선언
 
	function createXHR() //XMLHttpRequest객체를 생성하는 메소드
	{
		if (window.ActiveXObject) //웹브라우저가 IE5.0, IE6.0 인 경우
		{
			xhrObject = new ActiveXObject("Microsoft.XMLHTTP"); //XMLHttpRequest객체 생성
		} else if (window.XMLHttpRequest) // 웹브라우저가 IE7.0, 파이어폭스, 사파리, 오페라등의 경우
		{
			xhrObject = new XMLHttpRequest();
		}	
	}

	function getData() {

		var form_name = "form_main";
		var user_id = document.forms[form_name].elements["txt_user_id"].value;

		createXHR(); // createXHR()메소드 호출

// 		var url = "./testFile.jsp"; // 요청 URL설정
		var url = "./testDB.jsp"; // 요청 URL설정
		//var url = "./getUserInfo.jsp"; //요청 URL 설정
		var reqparam = "user_id=" + user_id;
		xhrObject.onreadystatechange = resGetData; // 응답결과를 처리메소드인 resultProcess()메소드 설정
		xhrObject.open("Post", url, "true") //서버의 요청설정 - url변수에 설정도니 리소르를 요청할 준비
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); //POST방식의 경우 반드시 설정
		xhrObject.send(reqparam); // 서버로 요청을 보냄
	}

	function resGetData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length;
				var res = "<table class='table table-striped'>" +
				"<thead class='thead-dark'>"+
				"<tr>"+ 
				"<th>"+"아이디"+"</th>" +
				"<th>" +"이름" + "</th>" +
				"<th>" + "전화번호" + "</th>" +
				"<th>" + "학년" + "</th>" + 
				"<th>"+"날짜"+"</th>"+
				"<th>"+"수정/삭제"+"</th>"+							
				"</tr>"+
				"</thead>"
				var resDiv = document.getElementById("div_res");

				if(num < 1) {
					res += "<tr><td>검색 결과가 없습니다.</td></tr>";
				} else {
					for (var i = 0; i < num; i++) {
						var user_id = objRes.datas[i].ID;
						var user_name = objRes.datas[i].NAME;
						var user_phone = objRes.datas[i].PHONE;
						var user_grade = objRes.datas[i].GRADE;
						var user_wTime = objRes.datas[i].WRITE_TIME;

						res += "<tr>";
						res += "<td>" + user_id + "</td>"
						res += "<td>" + user_name + "</td>"
						res += "<td>" + user_phone + "</td>"
						res += "<td>" + user_grade + "</td>"
						res += "<td>" + user_wTime + "</td>"
						res += "<td><button type='button' class ='btn btn-danger mx-2' onClick='javascipt:delData(\""+user_id+"\");'>"+"삭제"+"</button>"+
						"<button type='button' class='btn btn-info mx-auto' data-toggle='modal' data-target='#updateUserModal'>"+"수정"+"</button></td>"
												
						res += "</tr>"

							
					}
				}
				res += "</table>"
				resDiv.innerHTML = res;
			}
		}
	}

	function searchData() {
		
// 		var form_name = "form_main";
// 		var user_id = document.forms[form_name].elements["txt_user_id"].value;

// 		if (user_id == "") {
// 			alert("user_id를 입력해주세요");
// 			document.forms[form_name].elements["txt_user_id"].focus();
// 			return;
// 		} else {
			getData();
// 		}
	}

	function insertData() {
		
		var form_name = "form_main";
		var user_id = document.forms[form_name].elements["txt_user_id"].value;
		
		var add = "save";
// 		var id = document.button[add].elements["id"].value;

		if (user_id == "") {
			alert("id를 입력해주세요");
			document.forms[form_name].elements["txt_user_id"].focus();
// 			document.button[add].elements["id"].value;	
			return;
		} else {
			addData();
		}
	}

	function addData() {
		
// 		var form_name = "form_main";
// 		var user_id = document.forms[form_name].elements["txt_user_id"].value;
// 		var user_name = document.forms[form_name].elements["txt_user_name"].value;
// 		var user_tel = document.forms[form_name].elements["txt_user_tel"].value;
// 		var user_grade = document.forms[form_name].elements["txt_user_grade"].value;
		
		var form_name2 = "main2";
		var user_id = document.forms[form_name2].elements["id"].value;
		var user_name = document.forms[form_name2].elements["name"].value;
		var user_tel = document.forms[form_name2].elements["tel"].value;
		var user_grade = document.forms[form_name2].elements["grade"].value;

		
		//var id = document.forms[form_name2].elements["id"].value;
		

		createXHR(); // createXHR()메소드 호출

// 		var url = "./testFile.jsp"; // 요청 URL설정
		var url = "./testDB2.jsp"; // 요청 URL설정
		//var url = "./getUserInfo.jsp"; //요청 URL 설정
// 		var reqparam = "user_id=" + user_id;
		var reqparam = "user_id=" + user_id;
		reqparam += "&user_name=" + user_name;
		reqparam += "&user_tel=" + user_tel;
		reqparam += "&user_grade=" + user_grade;

		xhrObject.onreadystatechange = resAddData; // 응답결과를 처리메소드인 resultProcess()메소드 설정
		xhrObject.open("Post", url, "true") //서버의 요청설정 - url변수에 설정도니 리소르를 요청할 준비
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); //POST방식의 경우 반드시 설정
		xhrObject.send(reqparam); // 서버로 요청을 보냄
		
	}

	function resAddData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.length;

				if(num < 1) {
					res += "<tr><td>검색 결과가 없습니다.</td></tr>";
				} else {

					var result_ok = objRes[0].RESULT_OK;
					if(result_ok == "1")
						alert("입력성공");
					else if(result_ok == "0")
						alert("입력실패");

					getData();
					
				}

				
// 				var res = "<table class='table table-striped'>" +
			
// 				resDiv.innerHTML = res;
			}
		}
	}

	function delData(user_id) {

// 		var form_name = "form_main";
// 		var user_id = document.forms[form_name].elements["txt_user_id"].value;

		createXHR(); // createXHR()메소드 호출

		var url = "./testDB3.jsp"; // 요청 URL설정
		
		var reqparam = "user_id=" + user_id;
		xhrObject.onreadystatechange = resdelData; // 응답결과를 처리메소드인 resultProcess()메소드 설정
		xhrObject.open("Post", url, "true") //서버의 요청설정 - url변수에 설정도니 리소르를 요청할 준비
		xhrObject.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8"); //POST방식의 경우 반드시 설정
		xhrObject.send(reqparam); // 서버로 요청을 보냄
	}
	function enterKey() {
	if(window.event.keyCode==13){
		searchData();
		}	
	}

	function resdelData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.length;

				if(num < 1) {
					res += "<tr><td>검색 결과가 없습니다.</td></tr>";
				} else {

					var result_ok = objRes[0].RESULT_OK;
					if(result_ok == "1")
						alert("삭제성공");
					else if(result_ok == "0")
						alert("삭제실패");

					getData();
					
				}

				
// 				var res = "<table class='table table-striped'>" +
			
// 				resDiv.innerHTML = res;
			}
		}
	}
</script>

</head>

<body>

<!--textfield-->
	<section>
		<div class = "container">
			<div id = "div_main">
				<table id = "table" class ="table">
					<form name = 'form_main' onSubmit = 'javascript:return false'>
						<tr>
							<td width = '25'></td>
							<td class = 'form_td'>아이디<input type = 'text' name = 'txt_user_id' class='input' onkeyup="enterKey()">
							</td>
							<td width = '25'></td>
							<td class = 'form_td'>이름<input type = 'text' name = 'txt_user_name'  class='input'>
							</td>
							<td width = '25'></td>
							<td class = 'form_td'>전화번호<input type = 'text' name = 'txt_user_tel' class='input'>
							</td>
							<td width = '25'></td>
							<td class = 'form_td'>학년<input type = 'text' name = 'txt_user_grade'  class='input'>
							</td>
						</tr>
					</form>
				</table>
			</div>
		</div>
	</section>
<!--button-->
	
	<section>
		<div class = "container">				
			
			
<!-- 			<img src="./img/del.gif" width='120' height='50' onClick='javascript:delData();'> -->
		</div>
	</section>
<!--modal-->
	<section id="actions" class="py-4 mb-4">	
      <div class="container">
        <div class="row">
          <div class="col-md-3 mx-auto">
            <a
              href="#"
              class="btn btn-primary btn-block"
              data-toggle="modal"
              data-target="#addUserModal"
              ><i class="fas fa-plus"></i> 추가
            </a>
          </div>
          <div class="col-md-3 mx-auto">
          <button type="button"  class="btn btn-success btn-block" onClick='javascript:searchData()'>검색</button>
<!--           <img src="./img/search.gif" width='120' height='50' onClick='javascript:searchData();'> -->
          </div>
<!--           <div class="col-md-3 mx-auto"> -->
<!--           <button type="button"  class="btn btn-primary btn-block" onClick='javascript:insertData()'>추가</button> -->
<!--           <img src="./img/insert.gif" width='120' height='50' onClick='javascript:insertData();'> -->
          </div>
        </div>
      </div>
    </section>	
	<section>
		<div class="container">
			<div id = 'div_res' class='row'>
				<div class='col-md-12'>
					<table class='table'>
						<tr>
						<td>결과물</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</section>
<!--modal-->
	<div class="modal fade" id="addUserModal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title">Add User</h5>
            <button class="close" data-dismiss="modal">
              <span>&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form name = "main2" onSubmit = 'javascript:return false'>
              <div class="form-group">
                <label for="ID">아이디</label>
                <input type="text" class="form-control" name="id" />
              </div>
              <div class="form-group">
                <label for="Name">이름</label>
                <input type="text" class="form-control" name="name" />
              </div>
              <div class="form-group">
                <label for="Tel">전화번호</label>
                <input type="text" class="form-control" name="tel" />
              </div>
              <div class="form-group">
                <label for="Grade">학년</label>
                <input type="text" class="form-control"name="grade" />
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button class="btn btn-primary" data-dismiss="modal" onClick='javascript:addData();'>Insert</button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="updateUserModal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header bg-success text-white">
            <h5 class="modal-title">Update User</h5>
            <button class="close" data-dismiss="modal">
              <span>&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form name = "main2" onSubmit = 'javascript:return false'>
              <div class="form-group">
                <label for="ID">아이디</label>
                <input type="text" class="form-control" name="id"/>
              </div>
              <div class="form-group">
                <label for="Name">이름</label>
                <input type="text" class="form-control" name="name" />
              </div>
              <div class="form-group">
                <label for="Tel">전화번호</label>
                <input type="text" class="form-control" name="tel" />
              </div>
              <div class="form-group">
                <label for="Grade">학년</label>
                <input type="text" class="form-control" name="grade"/>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button class="btn btn-success" data-dismiss="modal" onClick='javascript:updateUserData();'>Update</button>
          </div>
        </div>
      </div>
    </div>
	<script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>    
</body>
</html>