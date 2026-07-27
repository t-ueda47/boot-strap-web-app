<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ご利用アンケート</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.3/dist/minty/bootstrap.min.css">

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container">
			<span class="navbar-brand fw-bold">🎓 IT School Special Form</span>

			<div class="ms-auto">
				<a href="/" class="btn btn-secondary btn-sm fw-bold">HOME へ戻る</a>
			</div>
		</div>
	</nav>

	<div class="text-center my-4">
		<h1 class="text-primary fw-bold">ご利用アンケート</h1>
		<p class="text-muted">Let us know your thoughts!</p>
	</div>

	<div class="container text-center justify-content-center"
		style="max-width: 700px;">

		<div class="progress mb-4" style="height: 25px;">
			<div
				class="progress-bar progress-bar-striped progress-bar-animated bg-success fw-bold"
				role="progressbar" style="width: 0%;" aria-valuenow="0"
				aria-valuemin="0" aria-valuemax="100">アンケート入力率: 60%</div>
		</div>

		<div class="alert alert-info text-start shadow-sm mb-4" role="alert">
			<h4 class="alert-heading fw-bold">📢 受講生の皆様へ</h4>
			<p class="mb-0">
				この度は、本書をご利用頂きありがとうございます。恐れ入りますが、以下のフォームにご記入頂き、送信して頂けると幸いです。</p>
		</div>

		<!-- 名前や職業などの入力部分 -->
		<div class="card shadow-sm text-start">
			<div class="card-body p-4">

				<!-- formに action と method を追加 -->
				<form action="survey" method="post">
					
					<!-- お名前 -->
					<div class="mb-3">
						<label for="userName" class="form-label fw-bold"> お名前 <span
							class="badge bg-danger">必須</span>
						</label> 
						<!-- name="userName" を追加 -->
						<input type="text" class="form-control" id="userName" name="userName"
							placeholder="山田 太郎">
					</div>

					<!-- ご職業 -->
					<div class="mb-3">
						<label for="userJob" class="form-label fw-bold">ご職業</label> 
						<!-- name="userJob" を追加 -->
						<select class="form-select" id="userJob" name="userJob">
							<option value="" selected>選択してください</option>
							<option value="1">学生</option>
							<option value="2">社会人</option>
							<option value="3">その他</option>
						</select>
					</div>

					<!-- 知りたい内容（複数選択） -->
					<div class="mb-4">
						<label class="form-label fw-bold">知りたい内容（複数回答可）</label>

						<!-- すべて name="topics" とそれぞれの value 属性を整理 -->
						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkHtml" name="topics" value="html">
							<label class="form-check-label" for="checkHtml">HTML5 /
								新標準マニアック構造</label>
						</div>

						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkCss" name="topics" value="css">
							<label class="form-check-label" for="checkCss">CSS3 /
								Flexbox・グリッドレイアウト</label>
						</div>

						<div class="form-check form-switch mb-2">
							<input class="form-check-input" type="checkbox" id="checkJs" name="topics" value="js">
							<label class="form-check-label" for="checkJs">JavaScript
								/ 5系連動モダンコーディング</label>
						</div>
					</div>

					<!-- 理解度（単一選択） -->
					<div class="mb-3">
						<label class="form-label fw-bold text-danger">理解度はいかがですか？</label>

						<!-- name="understanding" とそれぞれの value 属性を整理 -->
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
											name="understanding" id="radio4" value="0" checked> <label
											class="form-check-label" for="radio4">🟢 回答しない</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- ご意見欄 -->
					<div class="mb-4">
						<label for="userComment" class="form-label fw-bold">ご意見・お気づきの点</label>
						<!-- name="userComment" を追加 -->
						<textarea class="form-control" id="userComment" name="userComment" rows="4"
							placeholder="ここが分かりやすかった！など自由にご記入ください。"></textarea>
					</div>

					<!-- 送信ボタン -->
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
		
	<!-- 独自JavaScriptの読み込み -->
	<script src="js/script.js"></script>
			
</body>
</html>