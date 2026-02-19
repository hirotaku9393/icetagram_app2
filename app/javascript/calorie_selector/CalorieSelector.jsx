//状態管理とデータの取得を担当するコンポーネント
import React, { useEffect, useState } from "react";
import CalorieSlider from "./CalorieSlider";
import IceList from "./IceList";

export default function CalorieSelector() {
    // APIから取得したアイスクリームのリストを状態として管理
    const [ices, setIces] = useState([]);
    // ユーザーが選択したカロリー上限を状態として管理
    const [calorieLimit, setCalorieLimit] = useState(200);

    // コンポーネントのマウント時にAPIからアイスクリームデータを取得
    useEffect(() => {
        fetch("/api/ice_creams")
            .then(res => res.json())
            .then(data => setIces(data));
    }, []);

    // カロリー上限に基づいてアイスクリームをフィルタリング
    const filteredIces = ices.filter(
        ice => ice.calorie_value <= calorieLimit
    );

    // コンポーネントのレンダリング
    return (
        <div>
            <CalorieSlider
                //CalorieSliderコンポーネントに状態と更新関数を渡す
                calorieLimit={calorieLimit}
                onChange={setCalorieLimit}
            />
        
            <IceList ices={filteredIces} />
            // IceListコンポーネントにフィルタリングされたアイスクリームリストを渡す
        </div>
    );
}
