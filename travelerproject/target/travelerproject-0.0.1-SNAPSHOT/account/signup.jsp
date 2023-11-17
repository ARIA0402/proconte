<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>サインアップ</title>
</head>
<body>
	<h1>新規アカウントを作成</h1>
	<form action="Signup.action" method="post">
		ユーザー名: <input type="text" name="username" placeholder="UserName"
			required><br> メールアドレス: <input type="email" name="email"
			placeholder="Email" required><br> パスワード: <input
			type="password" name="password" placeholder="Password" required><br>
		<input type="submit" value="サインアップ">
	</form>
</body>
</html>
