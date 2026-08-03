<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// スコープからのデータ取得
	String userName = (String) request.getAttribute("userName");
	String userEmail = (String) request.getAttribute("userEmail");
	String userPassword = (String) request.getAttribute("userPassword");
	String userJob = (String) request.getAttribute("userJob");
	String[] topics = (String[]) request.getAttribute("topics");
	String understanding = (String) request.getAttribute("understanding");
	String userComment = (String) request.getAttribute("userComment");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>アンケート確認画面</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-md-8 col-lg-7">
				
				<!-- メインカード -->
				<div class="card shadow-lg border-0 rounded-3">
					
					<!-- カードヘッダー -->
					<div class="card-header bg-primary text-white text-center py-3 rounded-top">
						<h3 class="card-title fw-bold m-0">
							<i class="bi bi-check2-square me-2"></i>入力内容の確認
						</h3>
					</div>

					<!-- カードボディ -->
					<div class="card-body p-4">
						<p class="text-secondary text-center mb-4">
							以下の内容で送信します。入力内容をご確認の上、「送信する」ボタンを押してください。
						</p>

						<!-- 確認テーブル -->
						<div class="table-responsive">
							<table class="table table-hover table-striped align-middle border">
								<tbody>
									<!-- 1. お名前 -->
									<tr>
										<th style="width: 35%;" class="bg-light fw-bold text-secondary">
											<i class="bi bi-person-fill me-2 text-primary"></i>お名前
										</th>
										<td class="fw-semibold text-dark"><%= userName %></td>
									</tr>

									<!-- 2. メールアドレス -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-envelope-fill me-2 text-primary"></i>メールアドレス
										</th>
										<td class="fw-semibold text-dark"><%= userEmail %></td>
									</tr>

									<!-- 3. パスワード -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-lock-fill me-2 text-primary"></i>パスワード
										</th>
										<td>
											<span class="badge bg-secondary font-monospace fs-6 px-3 py-2">●●●●●●●●</span>
										</td>
									</tr>

									<!-- 4. ご職業 -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-briefcase-fill me-2 text-primary"></i>ご職業
										</th>
										<td class="fw-semibold">
											<%
												if ("1".equals(userJob)) { %>会社員<% }
												else if ("2".equals(userJob)) { %>自営業<% }
												else if ("3".equals(userJob)) { %>学生<% }
												else if ("4".equals(userJob)) { %>その他<% }
												else { out.print(userJob); }
											%>
										</td>
									</tr>

									<!-- 5. 興味のあるトピック -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-journal-bookmark-fill me-2 text-primary"></i>トピック
										</th>
										<td class="fw-semibold">
											<%
												if (topics != null && topics.length > 0) {
													out.print(String.join(", ", topics));
												} else {
													out.print("なし");
												}
											%>
										</td>
									</tr>

									<!-- 6. 理解度 -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-emoji-smile-fill me-2 text-primary"></i>理解度
										</th>
										<td class="fw-semibold">
											<%
												if ("1".equals(understanding)) { %>
													<span class="badge bg-danger-subtle text-danger border border-danger px-3 py-2">😣 理解できなかった</span>
												<% } else if ("2".equals(understanding)) { %>
													<span class="badge bg-warning-subtle text-warning-emphasis border border-warning px-3 py-2">🤔 だいたい理解できた</span>
												<% } else if ("3".equals(understanding)) { %>
													<span class="badge bg-success-subtle text-success border border-success px-3 py-2">😊 よく理解できた</span>
												<% } else {
													out.print(understanding);
												}
											%>
										</td>
									</tr>

									<!-- 7. ご意見・ご要望 -->
									<tr>
										<th class="bg-light fw-bold text-secondary">
											<i class="bi bi-chat-left-text-fill me-2 text-primary"></i>ご意見・ご要望
										</th>
										<td class="text-break">
											<%
												if (userComment != null) {
													out.print(userComment.replace("\n", "<br>"));
												}
											%>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- アクションボタンエリア -->
						<div class="d-grid gap-2 d-md-flex justify-content-md-between mt-4">
							<button type="button" class="btn btn-outline-secondary btn-lg px-4" onclick="history.back()">
								<i class="bi bi-arrow-left me-2"></i>修正する
							</button>

							<!-- DB登録用サーブレットへ隠しデータ（hidden）として受け渡す -->
							<form action="PostEnqueteServlet" method="post" class="m-0">
								<input type="hidden" name="userName" value="<%= userName %>">
								<input type="hidden" name="userEmail" value="<%= userEmail %>">
								<input type="hidden" name="userPassword" value="<%= userPassword %>">
								<input type="hidden" name="userJob" value="<%= userJob %>">
								
								<% if (topics != null) { 
									for (String t : topics) { %>
										<input type="hidden" name="topics" value="<%= t %>">
								<% 	} 
								} %>
								
								<input type="hidden" name="understanding" value="<%= understanding %>">
								<input type="hidden" name="userComment" value="<%= userComment %>">

								<button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
									送信する<i class="bi bi-send-fill ms-2"></i>
								</button>
							</form>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Bootstrap 5 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>