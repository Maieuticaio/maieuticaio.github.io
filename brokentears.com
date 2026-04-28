<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Broken Tears — Shop</title>
  <style>
    :root {
      --bg: #f5f1ea;
      --ink: #181818;
      --muted: #77706a;
      --line: #181818;
      --cell-min: 260px;
    }

    * { box-sizing: border-box; }

    body {
      margin: 0;
      background: var(--bg);
      color: var(--ink);
      font-family: Arial, Helvetica, sans-serif;
      letter-spacing: -0.02em;
    }

    a { color: inherit; text-decoration: none; }

    .page {
      min-height: 100vh;
      padding: clamp(20px, 4vw, 56px);
    }

    .shop-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      gap: 24px;
      margin-bottom: clamp(28px, 5vw, 72px);
    }

    .shop-title {
      margin: 0;
      font-size: clamp(34px, 8vw, 112px);
      line-height: 0.9;
      font-weight: 500;
      text-transform: uppercase;
    }

    .shop-note {
      max-width: 360px;
      margin: 0;
      font-size: 14px;
      line-height: 1.35;
      color: var(--muted);
      text-align: right;
    }

    .shop-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(min(100%, var(--cell-min)), 1fr));
      gap: 0;
      position: relative;
      background: transparent;
      border: 2px solid var(--line); /* внешний контур */
    }

    .shop-cell {
      position: relative;
      min-height: clamp(340px, 46vw, 520px);
      display: grid;
      place-items: center;
      overflow: visible;
      background: var(--bg);

      /* внутренние линии: только справа и снизу, поэтому они не удваиваются */
      border-right: 1px solid var(--line);
      border-bottom: 1px solid var(--line);
    }

    /* Номер лежит на пересечении угла. Линии визуально почти упираются в цифру. */
    .cell-number {
      position: absolute;
      top: -0.72em;
      left: -0.08em;
      z-index: 2;
      display: inline-block;
      padding-right: 0.18em;
      background: var(--bg);
      font-size: clamp(34px, 5.2vw, 72px);
      line-height: 0.9;
      font-weight: 500;
      letter-spacing: -0.08em;
      font-variant-numeric: tabular-nums;
    }

    .product-link {
      width: 100%;
      height: 100%;
      padding: clamp(36px, 5vw, 72px) clamp(24px, 4vw, 56px) clamp(30px, 4vw, 48px);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 22px;
    }

    .product-media {
      width: min(72%, 320px);
      aspect-ratio: 1 / 1;
      display: grid;
      place-items: center;
      transition: transform 220ms ease, filter 220ms ease;
    }

    .product-media img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
      display: block;
    }

    .product-link:hover .product-media {
      transform: translateY(-4px) scale(1.025);
      filter: contrast(1.04);
    }

    .product-status {
      font-size: clamp(14px, 1.8vw, 22px);
      line-height: 1;
      text-transform: uppercase;
      letter-spacing: 0.08em;
    }

    .product-status.sold { color: var(--muted); }

    .product-page {
      display: none;
    }

    .product-page:target {
      display: block;
    }

    body:has(.product-page:target) .shop-view {
      display: none;
    }

    .back-link {
      display: inline-block;
      margin-bottom: 32px;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.08em;
      border-bottom: 1px solid currentColor;
    }

    .product-detail-layout {
      display: grid;
      grid-template-columns: minmax(0, 1.1fr) minmax(280px, 0.9fr);
      gap: clamp(28px, 5vw, 72px);
      align-items: start;
    }

    .gallery {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 12px;
    }

    .gallery img {
      width: 100%;
      aspect-ratio: 1 / 1;
      object-fit: cover;
      border: 1px solid var(--line);
      background: #eee7dd;
    }

    .product-info h1 {
      margin: 0 0 16px;
      font-size: clamp(38px, 7vw, 96px);
      line-height: 0.9;
      font-weight: 500;
      text-transform: uppercase;
    }

    .product-info p {
      max-width: 560px;
      font-size: 17px;
      line-height: 1.45;
      color: var(--muted);
    }

    .buy-line {
      margin-top: 28px;
      padding-top: 18px;
      border-top: 1px solid var(--line);
      display: flex;
      justify-content: space-between;
      gap: 20px;
      font-size: 16px;
      text-transform: uppercase;
      letter-spacing: 0.06em;
    }

    @media (max-width: 760px) {
      .shop-header {
        display: block;
      }

      .shop-note {
        text-align: left;
        margin-top: 18px;
      }

      .product-detail-layout {
        grid-template-columns: 1fr;
      }

      .gallery {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <main class="page">
    <section class="shop-view">
      <header class="shop-header">
        <h1 class="shop-title">Broken<br>Tears</h1>
        <p class="shop-note">Small ceramic objects. Click an item to open its series page.</p>
      </header>

      <section class="shop-grid" aria-label="Shop products">
        <article class="shop-cell">
          <span class="cell-number">01</span>
          <a class="product-link" href="#product-01" aria-label="Open product 01">
            <figure class="product-media">
              <img src="https://media.giphy.com/media/26BRuo6sLetdllPAQ/giphy.gif" alt="Ceramic piece 01" />
            </figure>
            <span class="product-status">Available</span>
          </a>
        </article>

        <article class="shop-cell">
          <span class="cell-number">02</span>
          <a class="product-link" href="#product-02" aria-label="Open product 02">
            <figure class="product-media">
              <img src="https://media.giphy.com/media/l0HlBO7eyXzSZkJri/giphy.gif" alt="Ceramic piece 02" />
            </figure>
            <span class="product-status sold">Sold</span>
          </a>
        </article>

        <article class="shop-cell">
          <span class="cell-number">03</span>
          <a class="product-link" href="#product-03" aria-label="Open product 03">
            <figure class="product-media">
              <img src="https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif" alt="Ceramic piece 03" />
            </figure>
            <span class="product-status">Available</span>
          </a>
        </article>

        <article class="shop-cell">
          <span class="cell-number">04</span>
          <a class="product-link" href="#product-04" aria-label="Open product 04">
            <figure class="product-media">
              <img src="https://media.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.gif" alt="Ceramic piece 04" />
            </figure>
            <span class="product-status">Available</span>
          </a>
        </article>
      </section>
    </section>

    <section id="product-01" class="product-page">
      <a class="back-link" href="#">← Back to shop</a>
      <div class="product-detail-layout">
        <div class="gallery">
          <img src="https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=1200&auto=format&fit=crop" alt="Product 01 view 1" />
          <img src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?q=80&w=1200&auto=format&fit=crop" alt="Product 01 view 2" />
          <img src="https://images.unsplash.com/photo-1605721911519-3dfeb3be25e7?q=80&w=1200&auto=format&fit=crop" alt="Product 01 view 3" />
          <img src="https://images.unsplash.com/photo-1493106641515-6b5631de4bb9?q=80&w=1200&auto=format&fit=crop" alt="Product 01 view 4" />
        </div>
        <aside class="product-info">
          <h1>Drop 01</h1>
          <p>Страница изделия: здесь можно показать всю серию, детали, размеры, цену, материал, способ покупки и историю объекта.</p>
          <div class="buy-line"><span>Available</span><span>€120</span></div>
        </aside>
      </div>
    </section>

    <section id="product-02" class="product-page">
      <a class="back-link" href="#">← Back to shop</a>
      <div class="product-detail-layout">
        <div class="gallery">
          <img src="https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=1200&auto=format&fit=crop" alt="Product 02 view 1" />
          <img src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?q=80&w=1200&auto=format&fit=crop" alt="Product 02 view 2" />
        </div>
        <aside class="product-info">
          <h1>Drop 02</h1>
          <p>Эта работа уже продана. Можно оставить страницу как архив серии.</p>
          <div class="buy-line"><span>Sold</span><span>Archive</span></div>
        </aside>
      </div>
    </section>

    <section id="product-03" class="product-page">
      <a class="back-link" href="#">← Back to shop</a>
      <div class="product-detail-layout">
        <div class="gallery">
          <img src="https://images.unsplash.com/photo-1605721911519-3dfeb3be25e7?q=80&w=1200&auto=format&fit=crop" alt="Product 03 view 1" />
          <img src="https://images.unsplash.com/photo-1493106641515-6b5631de4bb9?q=80&w=1200&auto=format&fit=crop" alt="Product 03 view 2" />
        </div>
        <aside class="product-info">
          <h1>Drop 03</h1>
          <p>Описание серии, материалы, размеры, глазурь, уход, доставка.</p>
          <div class="buy-line"><span>Available</span><span>€95</span></div>
        </aside>
      </div>
    </section>

    <section id="product-04" class="product-page">
      <a class="back-link" href="#">← Back to shop</a>
      <div class="product-detail-layout">
        <div class="gallery">
          <img src="https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?q=80&w=1200&auto=format&fit=crop" alt="Product 04 view 1" />
          <img src="https://images.unsplash.com/photo-1610701596007-11502861dcfa?q=80&w=1200&auto=format&fit=crop" alt="Product 04 view 2" />
        </div>
        <aside class="product-info">
          <h1>Drop 04</h1>
          <p>Можно заменить эти изображения на реальные фото и GIF твоих изделий.</p>
          <div class="buy-line"><span>Available</span><span>€110</span></div>
        </aside>
      </div>
    </section>
  </main>
</body>
</html>
