import React from "react";
import { createRoot } from "react-dom/client";
import CalorieSelector from "../calorie_selector/CalorieSelector";

const mount = () => {
    // カロリーセレクターのコンテナ要素を取得
    const container = document.getElementById("calorie-selector");
    if (container) {
        createRoot(container).render(<CalorieSelector />);
    }
};

document.addEventListener("turbo:load", mount);