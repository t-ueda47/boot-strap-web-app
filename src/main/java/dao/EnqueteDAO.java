package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lombok.extern.slf4j.Slf4j;
import model.Enquete;
import util.DBManager;
import util.PassWordEncryption;

/**
 * アンケートデータの取得と保存（DAO）
 */
@Slf4j
public class EnqueteDAO {

	/**
	 * 入力されたメールアドレスが既に登録済みかチェック
	 * 
	 * @param inputEmail チェック対象のメールアドレス
	 * @return 存在する場合は true、存在しない（またはエラー）場合は false
	 */
	public boolean checkEmail(String inputEmail) {
		String sql = "SELECT COUNT(*) FROM enquettes WHERE user_email = ?";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, inputEmail);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1) > 0; // 1件以上あれば登録済み
				}
			}
		} catch (SQLException e) {
			log.error("メールアドレス重複チェックエラー: {}", inputEmail, e);
		}
		return false;
	}

	/**
	 * アンケートデータをDBに挿入する
	 * ※トランザクションをBO層（Logic）で制御するため、Connectionを引数で受け取ります
	 * 
	 * @param conn DB接続オブジェクト
	 * @param enquete 登録するアンケートデータ（record）
	 * @return 挿入成功なら true
	 * @throws SQLException SQL実行エラー
	 */
	public boolean create(Connection conn, Enquete enquete) throws SQLException {
		String sql = "INSERT INTO enquettes ("
				+ "user_name, user_email, user_password, user_job, topics, understanding, user_comment"
				+ ") VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			// recordのフィールドアクセス（getXXX() ではなく xxx()）
			pstmt.setString(1, enquete.userName());
			pstmt.setString(2, enquete.userEmail());

			// パスワードをBCryptでハッシュ化してセット
			String hashPassword = PassWordEncryption.hash(enquete.userPassword());
			log.info("パスワードハッシュ化完了: {}", hashPassword);
			pstmt.setString(3, hashPassword);

			pstmt.setString(4, enquete.userJob());
			pstmt.setString(5, enquete.topics());
			pstmt.setString(6, enquete.understanding());
			pstmt.setString(7, enquete.userComment());

			int result = pstmt.executeUpdate();
			return result == 1; // 1行追加されていれば成功
		}
	}

	/**
	 * 全アンケートデータの取得（ID昇順）
	 * 
	 * @return アンケート一覧リスト
	 */
	public List<Enquete> findAll() {
		List<Enquete> list = new ArrayList<>();
		String sql = "SELECT * FROM enquettes ORDER BY id ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				// recordの全引数コンストラクタでインスタンス化
				Enquete enquete = new Enquete(
						rs.getInt("id"),
						rs.getString("user_name"),
						rs.getString("user_email"),
						rs.getString("user_password"),
						rs.getString("user_job"),
						rs.getString("topics"),
						rs.getString("understanding"),
						rs.getString("user_comment"));
				list.add(enquete);
			}
		} catch (SQLException e) {
			log.error("全アンケートデータ取得エラー", e);
			return null;
		}
		return list;
	}
}