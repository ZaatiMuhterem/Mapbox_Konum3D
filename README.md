# 📍 Balıkesir/ivrindi Konum Takip (Arcade Mod Denemesi)

Bu projede Flutter öğrenirken, arkadaşlarımla birbirimizi haritada takip edebileceğimiz bir uygulama yapmaya çalıştım.

Normal harita uygulamaları çok sıkıcı geldiği için biraz **oyun havası (Cyberpunk/Arcade)** katmak istedim. Haritayı karanlık yaptım, binaları 3 boyutlu yükselttim falan. Henüz profesyonel değilim, kodlarda acemilikler olabilir, şimdiden affola! 😅
 <img src="https://github.com/ZaatiMuhterem/author/blob/5585246e51fda0bf847236be7a83cc1a8aff0eac/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-01-14%20at%2010.29.33.png" width="200">  <img src="https://github.com/ZaatiMuhterem/author/blob/86ff31d6d98d92d1265dd1e25e7d98f15fd60e7f/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-01-14%20at%2010.29.40.png" width="200"> <img src="https://github.com/ZaatiMuhterem/author/blob/4e4d570641aa6dbe34c313cfa5d81d881494bf61/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-01-14%20at%2010.30.03.png" width="200"> <img src="https://github.com/ZaatiMuhterem/author/blob/1b9efa006e76f8445f32a6a65bf87d12fba3bb86/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-01-14%20at%2010.30.08.png" width="200"> 

## Neler Yapabiliyor?

*  **Canlı Takip:** Firebase kullanarak anlık konum paylaşıyor.
*  **Harita:** Mapbox kullanarak haritayı gece moduna aldım ve binaları 3D yaptım.
*  **Avatar:** Kendimizi haritada Chicken olarak görüyoruz.
*  **Arkadaşları Görme:** Veritabanına bağlı diğer kişileri de haritada görebiliyoruz (şimdilik sarı yuvarlaklar olarak).

##  Kendi Bilgisayarınızda Nasıl Çalıştırırsınız?

Güvenlik sebebiyle kendi API anahtarlarımı ve veritabanı dosyalarımı projeden sildim. Çalıştırmak için şu adımları yapmanız lazım:

1.  **Projeyi İndirin:**
    Kodu bilgisayarınıza çekin (Clone).

2.  **Firebase Ayarı:**
    * Kendinize bir Firebase projesi açın (Realtime Database açık olsun).
    * `google-services.json` dosyasını indirip `android/app/` içine atın.
    * iOS kullanıyorsanız `GoogleService-Info.plist` dosyasını `ios/Runner/` içine atın.

3.  **Mapbox Ayarı (Harita için şart):**
    * Mapbox sitesinden ücretsiz bir hesap açıp "Public Access Token" alın.
    * **Android için:** `android/app/src/main/AndroidManifest.xml` dosyasına girip `BURAYA_KENDI_TOKENINIZI_YAZIN` kısmına yapıştırın.
    * **iOS için:** `ios/Runner/Info.plist` dosyasına girip ilgili yere yapıştırın.

4.  **Çalıştırın:**
    Terminalden paketleri yükleyip başlatın:
    ```bash
    flutter pub get
    flutter run
    ```

---
