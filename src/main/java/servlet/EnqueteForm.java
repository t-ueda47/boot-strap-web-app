package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * アンケート入力画面（JSP）を表示するための画面遷移制御サーブレット
 */
@WebServlet("/EnqueteForm")
public class EnqueteForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * index.html などのリンク（GETリクエスト）から呼び出されるメソッド
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// フォワード先（WEB-INF配下のJSP）のパスを指定
		String path = "/WEB-INF/jsp/enquete.jsp";

		// リクエストディスパッチャーを取得してJSPへフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}

	/**
	 * enquete.jsp からのフォーム送信（POSTリクエスト）を処理するメソッド
	 * データを受け取り、確認画面（enqueteConfirm.jsp）へ送る
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. フォームからの送信パラメータを取得
		// ※ SetEncodingFilter により文字コード設定(UTF-8)は自動適用済み
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");

		String userJob = request.getParameter("userJob");

		// 複数選択（チェックボックス）は getParameterValues を使用
		String[] topics = request.getParameterValues("topics");

		String understanding = request.getParameter("understanding");
		String userComment = request.getParameter("userComment");

		// 2. ★ここで確認画面に進む前に重複チェックを実行！★
		dao.EnqueteDAO dao = new dao.EnqueteDAO();
		if (dao.checkEmail(userEmail)) {
			// 重複している場合は確認画面へ行かせず、エラーメッセージを持って入力画面へ戻す
			request.setAttribute("errorMessage", "指定されたメールアドレスは既に登録されています。");

			// 入力値を保持したまま戻すための設定（必要に応じて）
			request.setAttribute("userName", userName);
			request.setAttribute("userEmail", userEmail);
			// ... その他の項目も保持 ...

			String path = "/WEB-INF/jsp/enquete.jsp";
			request.getRequestDispatcher(path).forward(request, response);
			return; // ここで処理を終了して確認画面へのフォワードを防ぐ
		}

		// 2. 取得したパラメータをリクエストスコープにセット
		request.setAttribute("userName", userName);
		request.setAttribute("userEmail", userEmail);
		request.setAttribute("userPassword", userPassword);
		request.setAttribute("userJob", userJob);
		request.setAttribute("topics", topics);
		request.setAttribute("understanding", understanding);
		request.setAttribute("userComment", userComment);

		// 3. 確認画面JSP（WEB-INF配下）へフォワード
		String path = "/WEB-INF/jsp/enqueteConfirm.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}
}