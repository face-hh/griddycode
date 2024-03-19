export function animate(animationName, animationDuration, fontSizeIncrease) {
    const container = document.querySelector('.container');

    // Check if container exists
    if (!container) {
        console.error("Couldn't find container. Thrown by Cheugy");
        return;
    }

    const elements = Array.from(container.querySelectorAll('h1, p'));
    const styleElement = document.createElement('style');
    document.head.appendChild(styleElement);
    const stylesheet = styleElement.sheet;

    const keyframes = `
        @keyframes ${animationName} {
            0%, 100% {
                font-size: calc(initial + 1em);
            }
            50% {
                font-size: ${fontSizeIncrease}em;
            }
        }
    `;

    // Insert the keyframes into the stylesheet
    stylesheet.insertRule(keyframes, stylesheet.cssRules.length);

    elements.forEach(element => {
        const words = element.textContent.split(' ');
        const randomIndex = Math.floor(Math.random() * words.length);
        const originalWord = words[randomIndex];

        const animatedWord = `
            <span
                class="text-element"
                style="animation: ${animationName} ${animationDuration}s cubic-bezier(0.68, -0.55, 0.27, 1.55) forwards;"
            >${originalWord}</span>
        `;

        words[randomIndex] = animatedWord;
        element.innerHTML = words.join(' ');

        const animatedElement = element.querySelector('.text-element');

        // Check if animatedElement exists
        if (!animatedElement) {
            console.error("Couldn't find animated element. Thrown by Cheugy");
            return;
        }

        animatedElement.addEventListener('animationend', () => {
            words[randomIndex] = originalWord;
            element.innerHTML = words.join(' ');
        });
    });
}