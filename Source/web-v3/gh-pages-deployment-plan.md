# GitHub Pages Yayınlama Planı

Bu döküman, projenin GitHub Pages üzerinde nasıl yayınlanacağını adım adım açıklar.

## 1. Hazırlık: `gh-pages` Paketinin Kurulması

Vite projelerini kolayca yayınlamak için `gh-pages` paketini kullanacağız.

```bash
npm install gh-pages --save-dev
```

## 2. `package.json` Güncellemesi

`package.json` dosyasına `homepage` alanı ve yayınlama scriptleri eklenmelidir.

- **homepage**: `"https://Sonderman.github.io/"` (Kök dizin olduğu için alt klasör belirtmiyoruz)
- **deploy scriptleri**:
  - `"predeploy": "npm run build"`
  - `"deploy": "gh-pages -d dist"`

## 3. `vite.config.js` Güncellemesi

Proje `Sonderman.github.io` reposunun kök dizininde yayınlanacağı için `base` ayarının `/` olduğundan emin olunmalıdır.

```javascript
export default defineConfig({
  plugins: [react()],
  base: "/", // Kök dizin için
});
```

## 4. Yayınlama Adımları

Tüm ayarlar yapıldıktan sonra terminalden şu komutu çalıştırmanız yeterlidir:

```bash
npm run deploy
```

## 5. GitHub Panel Ayarları

1. GitHub reposuna gidin.
2. **Settings > Pages** sekmesine tıklayın.
3. **Build and deployment > Branch** kısmından `gh-pages` branch'ini ve `/ (root)` seçeneğini seçip kaydedin.

---

_Not: Bu bir ön hazırlık planıdır, kullanıcının onayı ile uygulanacaktır._
