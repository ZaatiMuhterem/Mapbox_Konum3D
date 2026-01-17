
<img src="https://github.com/ZaatiMuhterem/Mapbox_Konum3D/blob/a23a12a719212a0b44de9f1e33d31483da9e0ee3/WhatsApp%20Image%202026-01-17%20at%2015.20.21.jpeg" width="200">  <img src="https://github.com/ZaatiMuhterem/Mapbox_Konum3D/blob/ebc01f8731fd41d690b99999e8ccd8d0eee07154/WhatsApp%20Image%202026-01-17%20at%2015.20.22-2.jpeg" width="200"> <img src="https://github.com/ZaatiMuhterem/Mapbox_Konum3D/blob/ae086e5ae2fe38c29ed0fd497d49ec0862d008c1/WhatsApp%20Image%202026-01-17%20at%2015.20.22-3.jpeg" width="200"> <img src="https://github.com/ZaatiMuhterem/Mapbox_Konum3D/blob/f236b76dd4c546682e0d00bef5de7257aa5c948c/WhatsApp%20Image%202026-01-17%20at%2015.20.22-4.jpeg" width="200">  
# 📍 Balıkesir/ivrindi Konum Takip (Arcade Mod Denemesi)

Bu projede Flutter öğrenirken, arkadaşlarımla birbirimizi haritada takip edebileceğimiz bir uygulama yapmaya çalıştım.

Normal harita uygulamaları çok sıkıcı geldiği için biraz **oyun havası (Cyberpunk/Arcade)** katmak istedim. Haritayı karanlık yaptım, binaları 3 boyutlu yükselttim falan. Henüz profesyonel değilim, kodlarda acemilikler olabilir, şimdiden affola! 😅
 
 

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
