document.addEventListener('turbo:load', () => {
    if (document.URL.match(/new/) || document.URL.match(/edit/)) {
        
            const createImageHTML = (blob) => {
                const imageElement = document.getElementById('new-image'); //ビューで指定したnew-imageのdiv要素を代入
                const blobImage = document.createElement('img'); //img要素を作成
                blobImage.setAttribute('src', blob); //imgのsrc属性にblob
                blobImage.classList.add('h-full', 'w-auto', 'block', 'mx-auto', 'mt-2'); //画像のスタイル調整（Tailwind CSS）
                imageElement.appendChild(blobImage); //div要素にimg要素
            };
            document.getElementById('ice_cream_image').addEventListener('change', (e) =>{
                const imageContent = document.querySelector('#new-image img'); 
                if (imageContent){ 
                    imageContent.remove(); 
                }
                const file = e.target.files[0]; //フォームで選択したファイルを取得
                const blob =window.URL.createObjectURL(file); //選択したファイルのURLを取得
                createImageHTML(blob); //画像表示用の関数を実行
            }); 
            document.addEventListener('turbo:before-cache', () => {
                const previews = document.getElementById('new-image');
                if (previews) previews.innerHTML = "";
            });
        
    }
});

