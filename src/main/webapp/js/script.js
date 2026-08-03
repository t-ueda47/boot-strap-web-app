/**
 * アンケートフォーム フロントエンド処理
 * 入力状況に応じてプログレスバーを動的に更新する
 */
document.addEventListener("DOMContentLoaded", function() {

    // HTMLから要素を取得
    const nameInput = document.getElementById("userName");       // お名前
    const emailInput = document.getElementById("userEmail");     // メールアドレス（追加）
    const passInput = document.getElementById("userPassword");   // パスワード（追加）
    const jobSelect = document.getElementById("userJob");         // ご職業
    const q1Checkboxes = document.querySelectorAll('input[type="checkbox"]'); // 知りたい内容（複数）
    const q2Radios = document.querySelectorAll('input[name="understanding"]'); // 理解度（複数）
    const messageInput = document.getElementById("userComment");  // ご意見欄

    // プログレスバーの要素を取得
    const progressBar = document.querySelector(".progress-bar");

    // 進捗計算＆バー更新メソッド
    function calculateProgress() {
        let completedCount = 0;
        const totalItems = 7; // 評価対象の項目数（5 -> 7 に変更）

        // 1. お名前（入力されているか）
        if (nameInput.value.trim() !== "") {
            completedCount++;
        }

        // 2. メールアドレス（入力されているか）
        if (emailInput.value.trim() !== "") {
            completedCount++;
        }

        // 3. パスワード（入力されているか）
        if (passInput.value.trim() !== "") {
            completedCount++;
        }

        // 4. ご職業（選択されているか）
        if (jobSelect.value !== "") {
            completedCount++;
        }

        // 5. 知りたい内容（1つ以上チェックされているか）
        const checkedBoxes = document.querySelectorAll('input[type="checkbox"]:checked');
        if (checkedBoxes.length > 0) {
            completedCount++;
        }

        // 6. 理解度（「回答しない：value="0"」以外が選択されているか）
        const selectedRadio = document.querySelector('input[name="understanding"]:checked');
        if (selectedRadio && selectedRadio.value !== "0") {
            completedCount++;
        }

        // 7. ご意見欄（入力されているか）
        if (messageInput.value.trim() !== "") {
            completedCount++;
        }

        // 進捗率（%）の計算
        const currentProgress = Math.round((completedCount / totalItems) * 100);

        // --------------------------------------------------
        // 計算結果を画面上の進捗バーに反映
        // --------------------------------------------------
        progressBar.style.width = currentProgress + "%";
        progressBar.setAttribute("aria-valuenow", currentProgress); // この1行も入れておくと親切

        if (currentProgress === 100) {
            // 100%（すべて入力完了）になったら、色をミントグリーンから水色（Info）へ変身
            progressBar.classList.remove("bg-success");
            progressBar.classList.add("bg-info");
            progressBar.textContent =
                "アンケート入力率: 100%（完璧です！送信してください）";
        } else {
            // 100%未満なら元のミントグリーン。0%のときは文字が見えなくなるので空にする
            progressBar.classList.remove("bg-info");
            progressBar.classList.add("bg-success");
            progressBar.textContent =
                currentProgress > 0
                    ? "アンケート入力率: " + currentProgress + "%"
                    : "";
        }

    }

    // イベントリスナーの登録
    nameInput.addEventListener("input", calculateProgress);
    emailInput.addEventListener("input", calculateProgress);
    passInput.addEventListener("input", calculateProgress);
    jobSelect.addEventListener("change", calculateProgress);
    
    q1Checkboxes.forEach((cb) => {
        cb.addEventListener("change", calculateProgress);
    });

    q2Radios.forEach((radio) => {
        radio.addEventListener("change", calculateProgress);
    });

    messageInput.addEventListener("input", calculateProgress);

    // 画面読み込み時の初期表示設定（初期化）
    calculateProgress();
	
	
    // --------------------------------------------------
    // フォーム送信時の制御
    // --------------------------------------------------
    const form = document.querySelector("form");
    if (form) {
        form.addEventListener("submit", function (event) {
            // まずはデフォルトの送信動作をキャンセル
            event.preventDefault();

            // 100%（bg-infoクラスがついているか）判定
            const isComplete = progressBar.classList.contains("bg-info");

            if (!isComplete) {
                // 100%未達成の場合
                alert("⚠️ 未入力の項目があります。\nすべての項目に入力・選択を行ってから送信してください。");
            } else {
                // 100%達成の場合
                alert("🚀 ご回答ありがとうございます！\nあなたの意見が、これからのITスクールをより良くします！");
        
                // サーブレットへ送信
                form.submit();
            }
        });
    }
	
});