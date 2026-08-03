<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>送信完了 | アンケートシステム</title>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

	<div class="container py-5">
		<div class="row justify-content-center">
			<div class="col-md-8 col-lg-6">
				
				<!-- メインカード -->
				<div class="card shadow-lg border-0 rounded-3 text-center">
					
					<!-- カードボディ -->
					<div class="card-body p-5">
						
						<!-- 成功チェックアイコン -->
						<div class="mb-4">
							<i class="bi bi-check-circle-fill text-success display-1"></i>
						</div>

						<h2 class="fw-bold text-dark mb-3">送信が完了しました</h2>
						
						<p class="text-secondary mb-4">
							アンケートにご協力いただき、誠にありがとうございました。<br>
							ご回答内容は正常に保存されました。
						</p>

						<hr class="my-4 text-muted">

						<!-- ナビゲーションボタン -->
						<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
							<a href="EnqueteForm" class="btn btn-primary btn-lg px-4 shadow-sm">
								<i class="bi bi-house-door-fill me-2"></i>入力フォームへ戻る
							</a>
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