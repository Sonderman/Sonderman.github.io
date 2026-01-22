# Proje Özeti: İnteraktif Portfolyo

**Amaç:** Kullanıcının yeteneklerini ve projelerini sergilemek için modern, eğlenceli ve interaktif bir web deneyimi oluşturmak.

**Teknolojiler:**

- **Core:**
  - **React.js v19** (Vite ile) - En güncel React sürümü.
  - **Vite v7.2** - Hızlı geliştirme ve build aracı.
- **Styling:**
  - **Tailwind CSS v4** - Modern ve performanslı CSS framework'ü.
  - **PostCSS & Autoprefixer** - CSS işleme.
  - **clsx & tailwind-merge** - Dinamik sınıf yönetimi.
- **Animasyon & UI:**
  - **Framer Motion v12** - Gelişmiş animasyonlar ve geçişler.
  - **Lucide React & React Icons** - Kapsamlı ikon kütüphaneleri.
  - **React Markdown & React PDF** - İçerik görüntüleme.

**Ana Bölümler:**

### 1. VS Code Simülasyonu (`src/components/VSCode`)

- **Tasarım:** Gerçekçi bir IDE deneyimi sunmak amacıyla `itsnitinr/vscode-portfolio` projesinden esinlenilerek yeniden tasarlandı.
- **Özellikler:**
  - **Layout:** Responsive düzen, sol sidebar ve ana içerik alanı.
  - **Titlebar:** Özel pencere başlığı, menü çubuğu ve kontrol düğmeleri.
  - **Activity Bar:** Solda yer alan ikon menüsü (Dosyalar, Arama, Git, Eklentiler vb.).
  - **Explorer:** Dosya gezgini, `src/data` içerisindeki yapıya göre klasörleri ve dosyaları listeler.
  - **Editör & Sekmeler:**
    - Markdown dosyalarını syntax highlighting ile görüntüler.
    - Sekme sistemi ile birden fazla dosya arasında geçiş imkanı.
    - Sekme kapatma ve aktif sekme vurgulama.
  - **Tema:** Otantik "GitHub Dark" teması renkleri ve fontları.

### 2. Android Simülasyonu (`src/components/Android`)

- **Tasarım:** Modern, çentikli ve ince çerçeveli bir akıllı telefon görünümü.
- **Bileşenler:**
  - **StatusBar:** Saat, pil ve sinyal göstergeleri.
  - **NavigationBar:** Geri, Ana Ekran ve Uygulamalar tuşları.
  - **HomeScreen:**
    - Uygulama ikonları ızgarası (`src/data/apps.js` üzerinden beslenir).
    - Kaydırılabilir sayfa yapısı.
- **Etkileşim:**
  - İkonlara tıklayınca uygulama açılış animasyonu.
  - Modal (pencere) içinde uygulama detayları ve açıklamaları.
- **Animasyon:** Framer Motion ile akıcı açılış/kapanış ve geçiş efektleri.

### 3. Tablet & Unity Simülasyonu (`src/components/Tablet`)

- **Tasarım:** Yatay (landscape) modda duran bir tablet çerçevesi.
- **Özellikler:**
  - **Oyun Alanı:** Unity WebGL oyunlarının çalıştırılabileceği bir iframe veya container alanı.
  - **Amaç:** Oyun geliştirme projelerinin canlı olarak sergilenmesi ve oynanabilmesi.

**Dosya Yapısı:**

- `src/components/`
  - `VSCode/`: IDE simülasyonu bileşenleri (Layout, Titlebar, Sidebar, Explorer, Editor vb.).
  - `Android/`: Telefon çerçevesi ve ekran bileşenleri.
  - `Tablet/`: Tablet çerçevesi ve Unity container.
  - `common/`: Ortak kullanılan buton, ikon vb. bileşenler.
- `src/data/`:
  - `apps.js`: Android simülasyonundaki uygulamaların verisi.
  - `files.js`: VS Code simülasyonundaki dosya ve klasör yapısı.
- `public/`: Statik dosyalar, resimler ve ikonlar.

**Kurulum ve Çalıştırma:**

1. **Bağımlılıkları Yükleyin:**

   ```bash
   npm install
   ```

2. **Geliştirme Sunucusunu Başlatın:**

   ```bash
   npm run dev
   ```

   Tarayıcıda genellikle `http://localhost:5173` adresinde açılır.

3. **Production Build Alın:**

   ```bash
   npm run build
   ```

   `dist` klasörüne optimize edilmiş dosyalar oluşturulur.

4. **Önizleme (Preview):**
   ```bash
   npm run preview
   ```
   Build alınan projeyi yerel sunucuda test etmek için kullanılır.
