<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// エラー発生時の入力値の復元処理（nullの場合は空文字に変換）
	String errorMessage = (String) request.getAttribute("errorMessage");
	String userName = request.getAttribute("userName") != null ? (String) request.getAttribute("userName") : "";
	String userEmail = request.getAttribute("userEmail") != null ? (String) request.getAttribute("userEmail") : "";
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ご利用アンケート</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.3/dist/morph/bootstrap.min.css">
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container">
			<span class="navbar-brand fw-bold">🎓 IT School Special Form</span>

			<div class="ms-auto">
				<a href="index.html" class="btn btn-secondary btn-sm fw-bold">HOME へ戻る</a>
			</div>
		</div>
	</nav>

	<!-- 見出し-->
	<div class="text-center my-4">
		<h1 class="text-primary fw-bold">ご利用アンケート</h1>
		<p class="text-muted">Let us know your thoughts!</p>
	</div>

	<!-- プログレスバー -->
	<div class="container text-center justify-content-center"
		style="max-width: 700px;">

		<div class="progress mb-4" style="height: 25px;">
			<div id="progressBar"
				class="progress-bar progress-bar-striped progress-bar-animated bg-success fw-bold"
				role="progressbar" style="width: 0%;" aria-valuenow="0"
				aria-valuemin="0" aria-valuemax="100">アンケート入力率: 0%</div>
		</div>

		<div class="alert alert-light text-start shadow-sm mb-4" role="alert">
			<h4 class="alert-heading fw-bold">📢 受講生の皆様へ</h4>
			<p class="mb-0">
				この度は、本書をご利用頂きありがとうございます。恐れ入りますが、以下のフォームにご記入頂き、送信して頂けると幸いです。</p>
		</div>

		<div class="card shadow-sm text-start">
			<div class="card-body p-4">

				<%-- エラーメッセージが存在する場合のみ赤色のアラートを表示 --%>
				<% if (errorMessage != null) { %>
					<div class="alert alert-danger shadow-sm mb-4 fw-bold" role="alert">
						⚠️ <%= errorMessage %>
					</div>
				<% } %>

				<form id="enqueteForm" action="EnqueteForm" method="post">
					<!-- お名前 -->
					<div class="mb-3">
						<label for="userName" class="form-label fw-bold">お名前</label>
						<input type="text" class="form-control" id="userName" name="userName"
							placeholder="山田 太郎" value="<%= userName %>">
					</div>

					<!-- メールアドレス -->
					<div class="mb-3">
						<label for="userEmail" class="form-label fw-bold">メールアドレス</label>
						<input type="email" class="form-control" id="userEmail" name="userEmail"
							placeholder="example@example.com" value="<%= userEmail %>">
					</div>

					<!-- パスワード -->
					<div class="mb-3">
						<label for="userPassword" class="form-label fw-bold">パスワード</label>
						<input type="password" class="form-control" id="userPassword" name="userPassword"
							placeholder="パスワードを入力してください">
					</div>

					<!-- ご職業 -->
					<div class="mb-3">
						<label for="userJob" class="form-label fw-bold">ご職業</label>
						<select class="form-select" id="userJob" name="userJob">
							<option value="" selected>選択してください</option>
							<option value="1">学生</option>
							<option value="2">社会人</option>
							<option value="3">その他</option>
						</select>
					</div>

					<div class="mb-4">
						<label class="form-label fw-bold">知りたい内容（複数回答可）</label>

						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkHtml"
								name="topics" value="html"> <label
								class="form-check-label" for="checkHtml">HTML5 /
								新標準マニアック構造</label>
						</div>

						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkCss"
								name="topics" value="css"> <label
								class="form-check-label" for="checkCss">CSS3 /
								Flexbox・グリッドレイアウト</label>
						</div>

						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkJs"
								name="topics" value="js"> <label
								class="form-check-label" for="checkJs">JavaScript /
								5系連動モダンコーディング</label>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label fw-bold text-danger">理解度はいかがですか？</label>

						<div class="bg-light p-3 rounded">
							<div class="row g-2">
								<div class="col-6">
									<div class="form-check">
										<input class="form-check-input" type="radio"
											name="understanding" id="radio1" value="1"> <label
											class="form-check-label" for="radio1">😣 理解できなかった</label>
									</div>
								</div>
								<div class="col-6">
									<div class="form-check">
										<input class="form-check-input" type="radio"
											name="understanding" id="radio2" value="2"> <label
											class="form-check-label" for="radio2">🤔 だいたい理解できた</label>
									</div>
								</div>
								<div class="col-6">
									<div class="form-check">
										<input class="form-check-input" type="radio"
											name="understanding" id="radio3" value="3"> <label
											class="form-check-label" for="radio3">😊 理解できた</label>
									</div>
								</div>
								<div class="col-6">
									<div class="form-check">
										<input class="form-check-input" type="radio"
											name="understanding" id="radio4" value="0"> <label
											class="form-check-label" for="radio4">🟢 回答しない</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="mb-4">
						<label for="userComment" class="form-label fw-bold">ご意見・お気づきの点</label>
						<textarea class="form-control" id="userComment" name="userComment"
							rows="4" placeholder="ここが分かりやすかった！など自由にご記入ください。"></textarea>
					</div>

					<div class="d-grid">
						<button type="submit" class="btn btn-primary fw-bold text-white">
							🚀 輝く未来へアンケートを送信する</button>
					</div>

				</form>
			</div>
		</div>

	</div>

	<!-- フッター -->
	<footer class="bg-dark text-white text-center py-4 mt-5">
		<div class="container">
			<p class="m-0 small opacity-75">&copy; H2O space - Creative Web
				Design Seminar 2026</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<script src="js/script.js"></script>
</body>
</html>