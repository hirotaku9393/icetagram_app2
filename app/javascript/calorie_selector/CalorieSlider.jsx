import React from "react";
export default function CalorieSlider({ calorieLimit, onChange }) {
    return (
        <div className="mb-6 text-center">
            <p className="font-kiwi text-lg mb-2">
                🍦 {calorieLimit} kcal 以下
            </p>
            <input
                type="range"
                min="50"
                max="500"
                step="10"
                value={calorieLimit}
                onChange={e => onChange(Number(e.target.value))}
                className="w-full"
            />
        </div>
    );
}