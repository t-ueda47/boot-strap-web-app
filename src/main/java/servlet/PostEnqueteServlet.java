
package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Enquete;
import model.PostEnqueteLogic;

/**
 * 確認画面からの最終送信を受け取り、DB登録を行うサーブレット
 */
@WebServlet("/PostEnqueteServlet")
public class PostEnqueteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 確認画面(enqueteConfirm.jsp) から送信されたパラメータを取得
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");
		String userJob = request.getParameter("userJob");

		// チェックボックスの値（カンマ区切り文字列に整形）
		String[] topicsArr = request.getParameterValues("topics");
		String topics = (topicsArr != null) ? String.join(", ", topicsArr) : "";

		String understanding = request.getParameter("understanding");
		String userComment = request.getParameter("userComment");

		// 2. データモデル（Record）の生成
		Enquete enquete = new Enquete(
				userName,
				userEmail,
				userPassword,
				userJob,
				topics,
				understanding,
				userComment);

		// 3. ビジネスロジック（BO）の実行
		PostEnqueteLogic logic = new PostEnqueteLogic();
		String errorMessage = logic.execute(enquete);

		// 4. 実行結果に応じた画面遷移
		if (errorMessage == null) {
			// 成功：二重投稿防止のため PRGパターンで完了画面へリダイレクト
			response.sendRedirect(request.getContextPath() + "/success.jsp");
		} else {
			// エラー発生時（重複エラー等）：エラーメッセージと入力値を保持して入力画面へ戻す
			request.setAttribute("errorMessage", errorMessage);
			request.setAttribute("enquete", enquete);

			String path = "/WEB-INF/jsp/enquete.jsp";
			request.getRequestDispatcher(path).forward(request, response);
		}
	}
}