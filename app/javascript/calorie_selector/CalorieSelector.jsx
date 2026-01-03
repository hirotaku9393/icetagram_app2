import React, { useEffect, useState } from "react";
import CalorieSlider from "./CalorieSlider";
import IceList from "./IceList";

export default function CalorieSelector() {
const [ices, setIces] = useState([]);
const [calorieLimit, setCalorieLimit] = useState(200);

useEffect(() => {
fetch("/api/ice_creams")
.then(res => res.json())
.then(data => setIces(data));
}, []);

const filteredIces = ices.filter(
ice => ice.calorie_value <= calorieLimit
);

return (
<div>
<CalorieSlider
calorieLimit={calorieLimit}
onChange={setCalorieLimit}
/>
<IceList ices={filteredIces} />
</div>
);
}