module.exports = {
    content: [
        "./app/views/**/*.erb",
        "./app/javascript/**/*.js",
        "./app/helpers/**/*.rb"
    ],
    theme: {
        extend: {
            fontFamily: {
                poller: ['"Poller One"', 'sans-serif'],
                kiwi: ['"Kiwi Maru"', 'serif'],
            },
        },
    },
};

