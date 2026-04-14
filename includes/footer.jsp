<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer>
    <p>© ESFUMA - EScola de FUtebol da MAdeira - Desde 1998</p>
</footer>

<div class="social-container">

    <div class="social-float certificacao">
        <img src="img/certificacao.png" alt="Certificação">
    </div>

    <div class="social-float bandeira">
        <img src="img/bandeira_etica.png" alt="Bandeira da Ética">
    </div>

</div>

<a href="https://wa.me/351912562328?text=Olá,%20quero%20mais%20informações%20sobre%20a%20ESFUMA"
   class="whatsapp-float" target="_blank">
    <i class="fab fa-whatsapp"></i>
</a>

<script>
// ======================
// HAMBURGER MENU
// ======================
const hamburger   = document.getElementById('hamburger');
const menuMobile  = document.getElementById('menu-mobile');

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('aberto');
    menuMobile.classList.toggle('aberto');
});

// Fecha o menu ao clicar num link
menuMobile.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
        hamburger.classList.remove('aberto');
        menuMobile.classList.remove('aberto');
    });
});

// ======================
// SCROLL SUAVE
// ======================
document.querySelectorAll('a[href^="#"]').forEach(link => {
    link.addEventListener('click', function(e) {
        e.preventDefault();

        const target = document.querySelector(this.getAttribute('href'));
        const offset = 80;

        const start = window.scrollY;
        const end = target.offsetTop - offset;
        const duration = 600;
        let startTime = null;

        function animateScroll(currentTime) {
            if (!startTime) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const progress = Math.min(timeElapsed / duration, 1);
            const ease = progress < 0.5
                ? 2 * progress * progress
                : 1 - Math.pow(-2 * progress + 2, 2) / 2;

            window.scrollTo(0, start + (end - start) * ease);

            if (timeElapsed < duration) requestAnimationFrame(animateScroll);
        }

        requestAnimationFrame(animateScroll);
    });
});

// ======================
// CARDS (accordion)
// ======================
document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('click', () => {
        document.querySelectorAll('.card').forEach(c => {
            if (c !== card) c.classList.remove('active');
        });
        card.classList.toggle('active');
    });
});

// ======================
// REVEAL ANIMATION
// ======================
const reveals = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) entry.target.classList.add('active');
    });
}, { threshold: 0.2 });
reveals.forEach(el => observer.observe(el));

// ======================
// SCROLL SPY + HEADER
// ======================
const sections = document.querySelectorAll("section");
const navLinks = document.querySelectorAll(".menu a");
const header   = document.querySelector(".header");
const hero     = document.querySelector(".hero");

window.addEventListener("scroll", () => {
    const scrollY = window.scrollY;

    // Header encolhe ao scroll
    if (scrollY > 50) {
        header.classList.add("scrolled");
    } else {
        header.classList.remove("scrolled");
    }

    // Scroll spy — marca o link activo
    let current = "";
    sections.forEach(section => {
        const sectionTop = section.offsetTop - 150;
        if (scrollY >= sectionTop && scrollY < sectionTop + section.offsetHeight) {
            current = section.getAttribute("id");
        }
    });

    // Fallback: se chegou ao fundo, marca contactos
    if ((window.innerHeight + scrollY) >= document.body.offsetHeight - 50) {
        current = "contactos";
    }

    navLinks.forEach(link => {
        link.classList.remove("active");
        if (link.getAttribute("href") === "#" + current) link.classList.add("active");
    });

    // Parallax no hero
    if (hero) {
        const rect = hero.getBoundingClientRect();
        if (rect.bottom > 0 && rect.top < window.innerHeight) {
            let offset = rect.top * -0.05;
            hero.style.backgroundPosition = `center calc(35% + ${offset}px)`;
        }
    }
});
</script>

</body>
</html>
