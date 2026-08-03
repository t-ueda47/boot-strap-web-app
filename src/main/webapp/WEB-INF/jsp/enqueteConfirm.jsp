<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>アンケート内容確認</title>

<!-- Bootstrap 5 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- Bootswatch Morph テーマ -->
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

	<!-- 見出し -->
	<div class="text-center my-4">
		<h1 class="text-primary fw-bold">ご入力内容の確認</h1>
		<p class="text-muted">Please confirm your entry</p>
	</div>

	<!-- メインコンテンツ -->
	<div class="container text-center justify-content-center"
		style="max-width: 700px;">

		<div class="card shadow-sm text-start mb-4">
			<div class="card-body p-4">
				<h4 class="card-title text-primary fw-bold mb-4">📋 入力内容一覧</h4>

				<table class="table table-bordered align-middle">
					<tbody>
						<!-- 1. お名前 -->
						<tr>
							<th style="width: 30%;" class="bg-light fw-bold">お名前</th>
							<td>
								<% 
									String userName = (String) request.getAttribute("userName");
									if (userName != null && !userName.trim().isEmpty()) {
								%>
									<%= userName %>
								<% } else { %>
									<span class="text-muted">（未入力）</span>
								<% } %>
							</td>
						</tr>

						<!-- 2. ご職業 -->
						<tr>
							<th class="bg-light fw-bold">ご職業</th>
							<td>
								<%
									String userJob = (String) request.getAttribute("userJob");
									if ("1".equals(userJob)) {
								%>学生<% 
									} else if ("2".equals(userJob)) {
								%>社会人<% 
									} else if ("3".equals(userJob)) {
								%>その他<% 
									} else {
								%><span class="text-muted">（未選択）</span><% 
									} 
								%>
							</td>
						</tr>

						<!-- 3. 知りたい内容 -->
						<tr>
							<th class="bg-light fw-bold">知りたい内容</th>
							<td>
								<%
									String[] topics = (String[]) request.getAttribute("topics");
									if (topics != null && topics.length > 0) {
								%>
									<ul class="mb-0 ps-3">
									<% for (String topic : topics) { %>
										<li>
											<% if ("html".equals(topic)) { %>HTML5 / 新標準マニアック構造
											<% } else if ("css".equals(topic)) { %>CSS3 / Flexbox・グリッドレイアウト
											<% } else if ("js".equals(topic)) { %>JavaScript / 5系連動モダンコーディング
											<% } else { %><%= topic %><% } %>
										</li>
									<% } %>
									</ul>
								<% } else { %>
									<span class="text-muted">（選択なし）</span>
								<% } %>
							</td>
						</tr>

						<!-- 4. 理解度 -->
						<tr>
							<th class="bg-light fw-bold">理解度</th>
							<td>
								<%
									String understanding = (String) request.getAttribute("understanding");
									if ("1".equals(understanding)) {
								%>😣 理解できなかった<% 
									} else if ("2".equals(understanding)) {
								%>🤔 だいたい理解できた<% 
									} else if ("3".equals(understanding)) {
								%>😊 理解できた<% 
									} else {
								%><span class="text-muted">🟢 回答しない</span><% 
									} 
								%>
							</td>
						</tr>

						<!-- 5. ご意見・お気づきの点 -->
						<tr>
							<th class="bg-light fw-bold">ご意見・お気づきの点</th>
							<td>
								<%
									String userComment = (String) request.getAttribute("userComment");
									if (userComment != null && !userComment.trim().isEmpty()) {
								%>
									<div style="white-space: pre-wrap;"><%= userComment %></div>
								<% } else { %>
									<span class="text-muted">（なし）</span>
								<% } %>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- ボタン領域 -->
				<div class="d-flex justify-content-between mt-4">
					<button type="button" class="btn btn-outline-secondary fw-bold" onclick="history.back()">
						⬅ 入力画面へ戻る
					</button>

					<form action="EnqueteComplete" method="post">
						<button type="submit" class="btn btn-primary fw-bold text-white">
							送信を確定する 🚀
						</button>
					</form>
				</div>

			</div>
		</div>

	</div>

	<!-- フッター -->
	<footer class="bg-dark text-white text-center py-4 mt-5">
		<div class="container">
			<p class="m-0 small opacity-75">&copy; H2O space - Creative Web Design Seminar 2026</p>
		</div>
	</footer>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>