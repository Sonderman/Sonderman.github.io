# Proje Özeti: İnteraktif Portfolyo (Web v3)

**Amaç:** Kullanıcının yeteneklerini ve projelerini sergilemek için modern, eğlenceli ve interaktif bir web deneyimi oluşturmak.

**Teknolojiler:**

- **React.js** (Vite ile)
- **Tailwind CSS v4** (Modern styling ve tema desteği)
- **Framer Motion** (Animasyonlar)
- **Lucide React & React Icons** (İkon setleri)

**Ana Bölümler:**

### 1. VS Code Simülasyonu

- **Tasarım:** Gerçekçi bir IDE deneyimi sunmak amacıyla `itsnitinr/vscode-portfolio` projesinden esinlenilerek yeniden tasarlandı.
- **Özellikler:**
  - **Titlebar:** Özel pencere başlığı ve kontrol düğmeleri.
  - **Activity Bar:** Solda yer alan ikon menüsü (Dosyalar, Arama, Git vb.).
  - **Explorer:** Dosya gezgini, klasör yapısını (örneğin "Portfolio" altında) gösterir ve açılır/kapanır özelliktedir.
  - **Editör & Sekmeler:** Seçilen dosyalar (Markdown formatında) sekmeler halinde açılır, aktif sekme vurgulanır ve kapatılabilir.
  - **Tema:** Otantik "GitHub Dark" teması renkleri kullanılmıştır.

### 2. Android Simülasyonu

- **Tasarım:** Modern, çentikli ve ince çerçeveli bir akıllı telefon görünümü.
- **Özellikler:**
  - **Ana Ekran:** Sosyal medya, oyunlar, sohbet gibi çeşitli uygulama ikonlarını içeren ızgara yapısı.
  - **Etkileşim:** İkonlara tıklandığında uygulamanın detaylarını gösteren bir modal (pencere) açılır.
  - **Animasyon:** Framer Motion ile akıcı açılış efektleri.

### 3. Tablet & Unity Simülasyonu

- **Tasarım:** Yatay (landscape) modda duran bir tablet çerçevesi.
- **Özellikler:**
  - **Oyun Alanı:** Unity WebGL oyunlarının çalıştırılabileceği bir alan (placeholder) içerir.
  - **Amaç:** Oyun geliştirme projelerinin canlı olarak sergilenmesi.

**Dosya Yapısı:**

- `src/components/VSCode`: IDE simülasyonu bileşenleri (Layout, Titlebar, Sidebar, Explorer, Editor vb.).
- `src/components/Android`: Telefon çerçevesi ve ekran bileşenleri.
- `src/components/Tablet`: Tablet çerçevesi ve Unity container.
- `src/data`: `apps.js` ve `files.js` gibi simülasyon içeriğini barındıran veri dosyaları.

**Kurulum ve Çalıştırma:**

1. Bağımlılıkları yükleyin: `npm install`
2. Geliştirme sunucusunu başlatın: `npm run dev`
