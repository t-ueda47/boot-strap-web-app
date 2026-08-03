package util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;

/**
 * アプリ起動時に1度だけ動き、DBファイルのパス
 * 設定・HikariCPの初期化・CREATE TABLE を
 * 自動実行する。
 */
@Slf4j
@WebListener
public class DBInitializerListener implements ServletContextListener {

	private static HikariDataSource dataSource;

	// DB接続情報
	private final String DB_USER = "sa";
	private final String DB_PASS = "";

	private static String dataFolderPath;

	public static HikariDataSource getDataSource() {
		return dataSource;
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		log.info("--- DBInitializerListener: アプリケーション起動（データベース接続初期化開始） ---");

		// 【1】データ保存先フォルダパスの取得
		ServletContext context = sce.getServletContext();
		dataFolderPath = context.getRealPath("/data");

		if (dataFolderPath == null) {
			log.error("コンテキストパスの取得に失敗しました。");
			throw new RuntimeException("アプリケーションの'/data'パスを取得できませんでした。");
		}

		log.info("データファイルパス: {}", dataFolderPath);

		// 【2】HikariCP（コネクションプール）の初期化
		try {
			HikariConfig config = new HikariConfig();

			// H2 Databaseのファイル接続URL設定
			String jdbcUrl = "jdbc:h2:file:" + dataFolderPath + "/enquetedb";
			log.info("JDBC URL: {}", jdbcUrl);

			config.setJdbcUrl(jdbcUrl);
			config.setUsername(DB_USER);
			config.setPassword(DB_PASS);
			config.setDriverClassName("org.h2.Driver");

			config.setMaximumPoolSize(10);
			config.setConnectionTimeout(10000);

			dataSource = new HikariDataSource(config);
			log.info("--- HikariCPの初期化に成功しました。 ---");

		} catch (Exception e) {
			log.error("HikariCPの初期化に失敗しました。", e);
			throw new RuntimeException("データベース接続プールの初期化に失敗しました。", e);
		}

		// 【3】テーブル初期化（enquettes テーブルの作成）
		try (Connection conn = dataSource.getConnection(); Statement stmt = conn.createStatement()) {

			String sql = "CREATE TABLE IF NOT EXISTS enquettes ("
					+ "id INT PRIMARY KEY AUTO_INCREMENT, "
					+ "user_name VARCHAR(100), "
					+ "user_email VARCHAR(255) UNIQUE, "
					+ "user_password VARCHAR(255), "
					+ "user_job VARCHAR(50), "
					+ "topics VARCHAR(255), "
					+ "understanding VARCHAR(10), "
					+ "user_comment TEXT, "
					+ "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
					+ ");";

			stmt.executeUpdate(sql);
			log.info("初期化完了: 'enquettes' テーブルの準備が完了しました。");

		} catch (SQLException e) {
			log.error("データベースのテーブル初期化に失敗しました。", e);
			throw new RuntimeException("DBテーブル初期化失敗", e);
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		if (dataSource != null) {
			dataSource.close();
			log.info("--- DBInitializerListener: アプリケーション停止（HikariCPクローズ） ---");
		}
	}
}
