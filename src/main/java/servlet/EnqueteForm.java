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
}