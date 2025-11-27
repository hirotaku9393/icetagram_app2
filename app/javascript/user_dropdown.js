document.addEventListener('turbo:load', () => {
    const btn = document.getElementById('user-menu-button');
    const menu = document.getElementById('user-menu');

    if (!btn || !menu) return; 


    btn.addEventListener('click', (event) => {
        event.stopPropagation(); 
        menu.classList.toggle('hidden');
    });


    document.addEventListener('click', (event) => {
        if (!menu.contains(event.target) && !btn.contains(event.target)) {
        menu.classList.add('hidden');
        }
    });
});
