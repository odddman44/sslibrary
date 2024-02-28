<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import = "sslibrary.frontweb.vo.CustomerDao"
	import = "sslibrary.frontweb.vo.Customer"    
    %>
   
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone");

boolean isInsert = false;

// id, password, name, email, phone 중 하나라도 "" 공백이면, sql 테이블에 입력되지 않고 "등록실패" 메시지가 출력되도록 코드 수정
if( id!=null && id.length()>0 && password!=null && password.length()>0 && name!=null && name.length()>0 && email!=null && email.length()>0 && phone!=null && phone.length()>0 ){
	CustomerDao dao = new CustomerDao();
	dao.insertCustomer(new Customer(0, id, password, name, email, phone));
	isInsert = true;
}else{
	isInsert = false;
}
%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <style>
        * { box-sizing:border-box; }

        form {
            width:400px;
            height:700px;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid #8D6E63;
            border-radius: 10px;
        }

        .input-field {
            width: 300px;
            height: 40px;
            border : 1px solid #8D6E63;
            border-radius:5px;
            padding: 0 10px;
            margin-bottom: 10px;
        }
        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }

        .ancient {
            background-color: #8D6E63;
            color : white;
            width:300px;
            height:50px;
            font-size: 17px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }

        .title {
            font-size : 30px;
            margin-top: 40px;     
        }

        .msg {
            height: 30px;
            text-align:center;
            font-size:16px;
            color:red;
            margin-bottom: 20px;
        }
        
    </style>
    <title>회원가입</title>

</head>
<body>
    <form name="frm">
    <div class="title">회원가입</div>
    <div id="msg" class="msg"> </div> 
    <label for="">아이디</label>
    <input class="input-field" type="text" name="id" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label for="">패스워드</label>
    <input class="input-field" type="text" name="password" placeholder="8~12자리의 영대소문자와 숫자 조합">
    <label for="">이름</label>
    <input class="input-field" type="text" name="name" placeholder="홍길동">
    <label for="">이메일</label>
    <input class="input-field" type="text" name="email" placeholder="example@fastcampus.co.kr"> 
    <label for="">핸드폰번호</label>
    <input class="input-field" type="text" name="phone" placeholder="010-3049-3928">
    <input class="ancient" type="submit" value="등록"/>
    </form>
    
   <script>
       function isInsert {
    	   	
    	   var isInsert = <%=isInsert%>;
    	   
            if(frm.id.value.length<3) {
                alert('id의 길이는 3이상이어야 합니다.');
                return false;
            }
            
            if(frm.password.value.length<3) {
                alert('패스워드의 길이는 3이상이어야 합니다.');
                return false;
            }
            if(frm.name.value.length==0) {
                alert('이름을 입력하세요.');
                return false;
            }
            if(frm.email.value.length==0) {
                alert('이메일을 입력하세요.');
                return false;
            }
            if(frm.phone.value.length==0) {
                alert('전화번호를 입력하세요.');
                return false;
            }

           return true;
       }
   </script>
<script>
var isInsert = <%=isInsert%>;
if(isInsert){
	alert("등록성공")
		location.href="SSHindex.jsp";
	}
</script>
</body>
</html>