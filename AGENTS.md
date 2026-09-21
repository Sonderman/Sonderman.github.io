# AGENTS.md

Bu depo, `https://sonderman.github.io/` adresinde yayınlanan kişisel portfolyo sitesidir.
Kaynak kod `Source/` altındadır; depo kökü doğrudan yayınlanan build çıktısını içerir.

## Kurallar

- 3. parti assetlerden referans aldığımızda, bu kaynakları kendi proje assets klasörümüze uygun şekilde kopyalayalım. Bu şekilde 3. parti kaynaklara bağımlılığımız olmasın.
- Memory leak ihtimallerini dikkate alarak kodlama yap.

## Tek kaynak ilkesi

Aynı dosyanın birden fazla kopyası bulunmaz; her assetin tek bir kaynak konumu vardır ve kod yalnızca o konuma referans verir.

| İçerik | Tek kaynak | Yayındaki konum |
| --- | --- | --- |
| Proje ve sertifika görselleri | `Source/public/images/` | `/images/` |
| Unity WebGL oyun build'leri | `Source/public/games/` | `/games/` |
| Kod içinde import edilen ikon ve profil görseli | `Source/src/assets/` | hash'li `assets/` çıktısı |
| CV | `Source/public/cv.pdf` | `/cv.pdf` |
| Statik dosyalar (favicon, robots, sitemap, og-image, app-ads.txt, Google doğrulama) | `Source/public/` | kök |

- Kök dizindeki kopyalar elle düzenlenmez. Kök, build çıktısının yayınlanmış halidir; `deploy.bat` ile yeniden üretilir.
- Kod içinden çağrılan yollar mutlak olmalıdır (`/images/...`, `/games/...`, `/cv.pdf`) ve `Source/public/` altındaki tek kaynağa karşılık gelmelidir.
- Aynı dosyayı `Source/src/assets/` ve `Source/public/` altında iki kez bulundurma: kod içinde import edilecekse `src/assets/`, URL ile çağrılacaksa `public/`.

## Proje yapısı

- `Source/` Vite + React 19 projesidir. `Source/src/App.jsx` 1024px eşiğinde mobil (`mobile/MobileApp.jsx`) ve masaüstü (`DesktopApp.jsx`) görünümü seçer.
- Kişisel içerik tek noktadan yönetilir: `Source/src/data/personalData.js`. Dosya gezgini içeriği `Source/src/data/files/` altındadır.
- SEO meta etiketleri `Source/index.html`, `Source/public/robots.txt` ve `Source/public/sitemap.xml` içindedir. Alan adı değişirse canonical, og:url ve sitemap adresleri güncellenmelidir.

## Bağımlılık yükseltme

- Yükseltme sonrası `npm run build` ve `node scripts/check-icons.mjs` çalıştırılır; ikisi de temiz olmalıdır.
- `lucide-react` 1.x marka ikonlarını (GitHub, LinkedIn) kaldırdı; marka ikonları `react-icons/fa6` üzerinden alınır.
- `@tsparticles/react` 4.x motor başlatmayı `ParticlesProvider` bileşenine taşıdı; `<Particles init={...}>` yerine sağlayıcı kullanılır. Sessizce boş kalan bir bileşen, bu tür bir kırılmanın işaretidir: her yükseltmeden sonra tarayıcıda görünür doğrulama yapılır.

## Yayın akışı

1. Depo kökünden `deploy.bat` çalıştırılır.
2. Betik `Source` içinde `npm install` (gerekirse) ve `npm run build` yapar.
3. `node Source/scripts/verify-dist.mjs Source/dist` ile build doğrulanır.
4. `robocopy Source\dist . /MIR` ile çıktı köke yansıtılır; kökteki eski hash'li dosyalar bu adımda silinir.
5. Kök dizin tekrar doğrulanır, ardından değişiklikler commit edilir.
6. GitHub Pages depo kökünü yayınlar. Otomatik build workflow'u yoktur.

- `robocopy /MIR` kökte dist içinde bulunmayan dosyaları siler. `README.md`, `AGENTS.md`, `deploy.bat`, `Source/` ve `.git/` hariç tutulur. Yayında kalması gereken yeni bir kök dosya eklenirse betikteki `/XF` listesine eklemek yerine `Source/public/` altına taşı.
