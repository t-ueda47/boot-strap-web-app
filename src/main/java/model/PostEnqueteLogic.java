package model;

import java.sql.Connection;
import java.sql.SQLException;

import dao.EnqueteDAO;
import lombok.extern.slf4j.Slf4j;
import util.DBManager;

/**
 * アンケート投稿処理を行うビジネスロジック（BO）
 */
@Slf4j
public class PostEnqueteLogic {

	/**
	 * アンケートの登録処理を実行する
	 * 
	 * @param enquete 登録するアンケートデータ
	 * @return 処理結果メッセージ（成功時は null または空文字、エラー時はエラーメッセージ）
	 */
	public String execute(Enquete enquete) {
		EnqueteDAO dao = new EnqueteDAO();

		// 1. 事前チェック：メールアドレスの重複確認
		if (dao.checkEmail(enquete.userEmail())) {
			log.warn("メールアドレス重複のため登録中断: {}", enquete.userEmail());
			return "指定されたメールアドレスは既に登録されています。";
		}

		// 2. DB登録処理（手動トランザクション制御）
		try (Connection conn = DBManager.getConnection()) {

			// 自動コミットをオフにしてトランザクションを開始
			conn.setAutoCommit(false);

			try {
				// DAOのcreateを呼び出し
				boolean isSuccess = dao.create(conn, enquete);

				if (isSuccess) {
					// 成功したらコミット
					conn.commit();
					log.info("アンケート登録成功: {}", enquete.userEmail());
					return null; // エラーなし（成功）
				} else {
					// 明示的に失敗した場合はロールバック
					conn.rollback();
					log.warn("アンケート登録失敗（0行更新）: {}", enquete.userEmail());
					return "アンケートの登録に失敗しました。";
				}

			} catch (SQLException e) {
				// 例外が発生したら必ずロールバック
				conn.rollback();
				log.error("DB登録処理中に例外が発生したためロールバックしました", e);
				return "データベース処理中にエラーが発生しました。";
			} finally {
				// コネクションプールに戻す前に自動コミットを元の状態に戻す
				conn.setAutoCommit(true);
			}

		} catch (SQLException e) {
			log.error("DB接続エラー", e);
			return "データベース接続エラーが発生しました。";
		}
	}
}