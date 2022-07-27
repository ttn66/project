<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="DWO.Models.WebForm6" %>

<!DOCTYPE html>

<html>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap');
 * {box-sizing: border-box}
 body{
   font-family: 'Noto Sans JP', sans-serif;
 }
 h1, label{
   color: DodgerBlue;
 }
   input[type=text], input[type=password] {
   width: 100%;
   padding: 15px;
   margin: 5px 0 22px 0;
   display: inline-block;
   border: none;
   width:100%;
   resize: vertical;
   padding:15px;
   border-radius:15px;
   border:0;
   box-shadow:4px 4px 10px rgba(0,0,0,0.2);
 }
input[type=text]:focus, input[type=password]:focus {
   outline: none;
 }
hr {
   border: 1px solid #f1f1f1;
   margin-bottom: 25px;
 }
button {
   background-color: #4CAF50;
   color: white;
   padding: 14px 20px;
   margin: 8px 0;
   border: none;
   cursor: pointer;
   width: 100%;
   opacity: 0.9;
 }
button:hover {
   opacity:1;
 }
.cancelbtn {
   padding: 14px 20px;
   background-color: #f44336;
 }
.signupbtn {
   float: left;
   width: 100%;
   border-radius:15px;
   border:0;
   box-shadow:4px 4px 10px rgba(0,0,0,0.2);
 }
.container {
   padding: 16px;
 }
.clearfix::after {
   content: "";
   clear: both;
   display: table;
 }
 #errorText1{
  font-size: 15px;
  font-weight: ;
  color: ;
 }
 #errorText2{
  font-size: 15px;
  font-weight: ;
  color: ;
 }
    </style>
<body>
<form action="">
    
   <div class="container">
    <label for="account"><b>Tên đăng nhập</b></label>
     <input id="account" type="text" placeholder="Nhập tên đăng nhập" name="account" >
    <label for="psw"><b>Mật Khẩu</b></label>
     <input id="psw" type="password" onkeyup="demo1()" placeholder="Nhập Mật Khẩu" name="psw" >
    <div align='left' id='errorText1'></div>
    <label for="psw-repeat"><b>Nhập Lại Mật Khẩu</b></label>
     <input id="psw-repeat" type="password" onkeyup="demo2()" placeholder="Nhập Lại Mật Khẩu" name="psw-repeat" >
     <div align='left' id='errorText2'></div>
    <label>
       <input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Nhớ Đăng Nhập
     </label>
    <div class="clearfix">
       <button id="btsignup" type="submit" class="signupbtn">Sign Up</button>
     </div>
   </div>
 </form>
    <script type="text/javascript" src='script.js'></script>
</body>
   
    <script>
        function Checkpassword(event) {
            event.preventDefault();
            var mess = document.getElementById('errorText');
            var password = document.getElementById('psw').value;
            var patt = new RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");
            var res = patt.test(password);
            if (password == '') {
                mess.innerHTML += 'Không được để trống ';
            }
            else if (password.length > 0 && res == false) {
                mess.innerHTML += 'Mật khẩu chưa đúng định dạng';
            }
        }

        function demo1() {
            var password = document.getElementById('psw').value;
            var mess = document.getElementById('errorText1');
            var patt = new RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");
            var res = patt.test(password);
            if (res == false) {
                mess.innerHTML = 'Mật khẩu bao gồm ít nhất 1 chữ hoa, 1 chữ thường, 1 số, 1 kí tự đặc biệt và ít nhất 8 kí tự';
            } else mess.innerHTML = '';
        }

        function demo2() {
            var PasswordRepeat = document.getElementById('psw-repeat').value;
            var password = document.getElementById('psw').value;
            var mess = document.getElementById('errorText2');
            if (PasswordRepeat != password) {
                mess.innerHTML = 'Nhập đúng với mật khẩu ở trên';
            } else mess.innerHTML = '';
        }


        var btndangki = document.getElementById('btsignup');
        btndangki.onclick = function Validate() {
            var mess = document.getElementById('errorText');
            mess.innerHTML = '';
            Checkpassword(event);
        }
    </script>
</html>
