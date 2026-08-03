package model;

import java.io.Serializable;

/**
 * アンケート情報のデータモデル（Record）
 * ※Serializableはセッションに保存時に必要
 */
public record Enquete(
		int id,
		String userName,
		String userEmail,
		String userPassword,
		String userJob,
		String topics,
		String understanding,
		String userComment) implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 新規登録用コンストラクタ（IDなし）
	 * DB自動採番（AUTO_INCREMENT）前のデータを扱う際に使用します。
	 */
	public Enquete(
			String userName,
			String userEmail,
			String userPassword,
			String userJob,
			String topics,
			String understanding,
			String userComment) {
		this(0, userName, userEmail, userPassword, userJob, topics, understanding, userComment);
	}
}
