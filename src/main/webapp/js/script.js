/**
 * アンケートフォーム フロントエンド処理
 * 画面の部品（HTML要素）を取得する
 */
document.addEventListener("DOMContentLoaded", function() {

    // HTMLからid取得
    const nameInput = document.getElementById("userName");     // お名前の入力欄
    const jobSelect = document.getElementById("userJob");       // ご職業の選択欄
    const q1Checkboxes = document.querySelectorAll('input[type="checkbox"]'); //知りたい内容（複数）
    const q2Radios = document.querySelectorAll('input[name="understanding"]'); //理解度（複数）
    const messageInput = document.getElementById("userComment"); // ご意見欄


    //共通メソッドでのコンソール出力
    function calculateProgress() {
        console.log("お名前の部品:", nameInput.value);
        console.log("ご職業の部品:", jobSelect.value);
        console.log("ご意見・気づきの部品:", messageInput.value);

        // 選択されているラジオボタン要素を1つだけ取得する
        const selectedRadio = document.querySelector('input[name="understanding"]:checked');
        let understandingValue = "未選択";
        if (selectedRadio) {
            // 選択されたボタンに対応する label タグのテキストを取得
			
			const label = document.querySelector('label[for="' + selectedRadio.id + '"]');
            understandingValue = label ? label.textContent.trim() : selectedRadio.value;
        }
        console.log("理解度（ラジオボタン）:", understandingValue);



    }

    // お名前入力欄の入力をリスナーで監視する
    nameInput.addEventListener("input", calculateProgress);
    // ご職業選択
    jobSelect.addEventListener("change", calculateProgress);
    // チェックボックス（知りたい内容）のクリック（ON/OFF）をすべて監視
    q1Checkboxes.forEach((cb) =>
        cb.addEventListener("change", calculateProgress),
    );

    // ラジオボタン（理解度）の選択変更をすべて監視
    q2Radios.forEach((radio) =>
        radio.addEventListener("change", calculateProgress),
    );

    //	ご意見・お気づき点を監視
    messageInput.addEventListener("input", calculateProgress);


});