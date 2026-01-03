import React from "react";

export default function IceList({ ices }) {
if (ices.length === 0) {
return <p className="text-center">該当するあいすがありません 🍨</p>;
}

return (
    <ul className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 rounded-xl gap-4">
        {ices.map(ice => (
            <li
                key={ice.id}
                className="bg-white shadow rounded-xl p-4"
            >
                <p className="font-kiwi">
                    <a href={`/ice_creams/${ice.id}`}
                    className="hover:underline">
                        {ice.name}
                    </a>
                </p>
                <p className="text-sm text-gray-500">
                    {ice.calorie_value} kcal
                </p>
                {ice.image_url && (
                    <img src={ice.image_url} alt={ice.name} className="mt-2 w-full h-40 object-cover rounded-lg" />
                )}
            </li>
        ))}
    </ul>
    );
}