<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer>
    <div class="footer-grid">
        <div class="footer-col">
            <h4>ESFUMA</h4>
            <p>EScola de FUtebol da MAdeira.<br>Formando homens, atletas e campeões desde 1998.</p>
            <div class="footer-social">
                <a href="https://www.facebook.com/esfumadeira" target="_blank" aria-label="Facebook">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="https://www.instagram.com/esfumadeira/" target="_blank" aria-label="Instagram">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
        </div>
        <div class="footer-col">
            <h4>Links</h4>
            <a href="#inicio">Início</a>
            <a href="#sobre">Missão</a>
            <a href="#treinos">Escalões</a>
            <a href="#contactos">Contactos</a>
        </div>
        <div class="footer-col">
            <h4>Contacto</h4>
            <a href="tel:912562328">912 562 328</a>
            <a href="mailto:esfuminha@gmail.com">esfuminha@gmail.com</a>
            <p>Caminho do Pilar, Funchal</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© ESFUMA &middot; EScola de FUtebol da MAdeira - Desde 1998</p>
    </div>
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

<button id="backToTop" aria-label="Voltar ao topo">
    <i class="fas fa-chevron-up"></i>
</button>

<script>
// ======================
// PRELOADER
// ======================
window.addEventListener('load', () => {
    setTimeout(() => {
        const preloader = document.getElementById('preloader');
        if (preloader) preloader.classList.add('hidden');
    }, 900);
});

// ======================
// BACK TO TOP
// ======================
const backToTopBtn = document.getElementById('backToTop');
window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
        backToTopBtn.classList.add('visible');
    } else {
        backToTopBtn.classList.remove('visible');
    }
});
backToTopBtn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// ======================
// MENU DE PÁGINAS
// ======================
const pagesBtn      = document.getElementById('pages-btn');
const pagesDropdown = document.getElementById('pages-dropdown');

pagesBtn.addEventListener('click', (e) => {
    e.stopPropagation();
    pagesDropdown.classList.toggle('open');
    pagesBtn.classList.toggle('open');
});

document.addEventListener('click', (e) => {
    if (!pagesDropdown.contains(e.target) && e.target !== pagesBtn) {
        pagesDropdown.classList.remove('open');
        pagesBtn.classList.remove('open');
    }
});

// ======================
// HAMBURGER MENU
// ======================
const hamburger   = document.getElementById('hamburger');
const menuMobile  = document.getElementById('menu-mobile');

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('aberto');
    menuMobile.classList.toggle('aberto');
    menuMobile.style.top = header.offsetHeight + 'px';
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
// COUNTER ANIMATION
// ======================
const counterObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const el = entry.target;
        const target = parseInt(el.getAttribute('data-target'));
        const prefix = el.getAttribute('data-prefix') || '';
        const suffix = el.getAttribute('data-suffix') || '';
        const duration = 1200;
        const startTime = performance.now();

        function tick(now) {
            const progress = Math.min((now - startTime) / duration, 1);
            const ease = 1 - Math.pow(1 - progress, 3);
            el.textContent = prefix + Math.round(ease * target) + suffix;
            if (progress < 1) requestAnimationFrame(tick);
        }
        requestAnimationFrame(tick);
        counterObserver.unobserve(el);
    });
}, { threshold: 0.5 });

document.querySelectorAll('.stat-num[data-target]').forEach(el => counterObserver.observe(el));

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

    // Mantém o menu mobile colado ao header
    menuMobile.style.top = header.offsetHeight + 'px';

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
