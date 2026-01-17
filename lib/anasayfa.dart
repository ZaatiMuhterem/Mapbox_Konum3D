import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart' as geo;

class anasayfa extends StatefulWidget {
  const anasayfa({super.key});

  @override
  State<anasayfa> createState() => _anasayfaState();
}

class _anasayfaState extends State<anasayfa> {
  MapboxMap? _mapboxMap;
  CircleAnnotationManager? _circleManager;

  final String _databaseURL = "https://SİZİN_PROJE_ID.europe-west1.firebasedatabase.app/";

  late final DatabaseReference _myRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: _databaseURL
  ).ref("konumlar/safi");

  late final DatabaseReference _allUsersRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: _databaseURL
  ).ref("konumlar");

  @override
  void initState() {
    super.initState();
    _konumDinlemeyiBaslat();
  }

  //KONUM GÖNDERME
  void _konumDinlemeyiBaslat() async {
    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
    }

    geo.Geolocator.getPositionStream(
      locationSettings: const geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((geo.Position position) {
      _myRef.set({
        "enlem": position.latitude,
        "boylam": position.longitude,
        "hiz": position.speed,
        "zaman": DateTime.now().toString(),
      });
    });
  }

  //HARİTA OLUŞUNCA
  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    // Tıklama Dinleyicisi
    mapboxMap.setOnMapTapListener((context) {
      _haritayaTiklandi(context.touchPosition);
    });

    _setupLocationPuck(mapboxMap);
    _circleManager = await mapboxMap.annotations.createCircleAnnotationManager();
    _digerleriniDinle();
  }

  //AKILLI TIKLAMA FONKSİYONU
  void _haritayaTiklandi(ScreenCoordinate point) async {
    final queryGeometry = RenderedQueryGeometry.fromScreenCoordinate(point);

    // Sorguyu yapıyoruz
    final List<QueriedRenderedFeature?>? features = await _mapboxMap?.queryRenderedFeatures(
      queryGeometry,
      RenderedQueryOptions(
          layerIds: null,
          filter: null
      ),
    );

    if (features != null && features.isNotEmpty) {
      String? bulunanIsim;
      IconData gosterilecekIkon = Icons.place;
      Color ikonRengi = Colors.red;

      for (var feature in features) {
        // Null Safety kontrolü
        final props = feature?.queriedFeature.feature['properties'] as Map?;

        if (props != null && (props.containsKey('name') || props.containsKey('name_tr'))) {
          bulunanIsim = props['name_tr'] ?? props['name'];

          String kucukIsim = bulunanIsim!.toLowerCase();

          // Kategori Belirleme
          if (kucukIsim.contains("eczane")) {
            gosterilecekIkon = Icons.local_pharmacy;
            ikonRengi = Colors.green;
          } else if (kucukIsim.contains("kütüphane") || kucukIsim.contains("library")) {
            gosterilecekIkon = Icons.local_library;
            ikonRengi = Colors.brown;
          } else if (kucukIsim.contains("belediye")) {
            gosterilecekIkon = Icons.account_balance;
            ikonRengi = Colors.blue;
          } else if (kucukIsim.contains("market") || kucukIsim.contains("şok") || kucukIsim.contains("bim") || kucukIsim.contains("a101")) {
            gosterilecekIkon = Icons.shopping_cart;
            ikonRengi = Colors.orange;
          }

          break; // İlk ismi bul, döngüden çık
        }
      }

      if (bulunanIsim != null) {
        _bilgiPenceresiAc(bulunanIsim, gosterilecekIkon, ikonRengi);
      }
    } else {
      print("Tıklanan yerde bir yapı bulunamadı.");
    }
  }

  void _bilgiPenceresiAc(String isim, IconData ikon, Color renk) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(ikon, color: renk, size: 50),
        content: Text(isim,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Kapat", style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }

  //DİĞER KULLANICILARI ÇİZ
  void _digerleriniDinle() {
    _allUsersRef.onValue.listen((DatabaseEvent event) {
      _circleManager?.deleteAll();
      if (event.snapshot.exists) {
        for (var child in event.snapshot.children) {
          if (child.key != "safi") {
            try {
              final data = Map<dynamic, dynamic>.from(child.value as Map);
              double enlem = (data['enlem'] as num?)?.toDouble() ?? 0.0;
              double boylam = (data['boylam'] as num?)?.toDouble() ?? 0.0;

              if (enlem != 0 && boylam != 0) {
                _circleManager?.create(CircleAnnotationOptions(
                  geometry: Point(coordinates: Position(boylam, enlem)),
                  circleColor: Colors.yellow.value,
                  circleRadius: 10.0,
                  circleStrokeWidth: 2.0,
                  circleStrokeColor: Colors.black.value,
                ));
              }
            } catch (e) {
              print("Çizim hatası: $e");
            }
          }
        }
      }
    });
  }

  Future<void> _setupLocationPuck(MapboxMap mapboxMap) async {
    await mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        locationPuck: LocationPuck(
          locationPuck3D: LocationPuck3D(
            modelUri: "asset://assets/Chicken.glb",
            modelScale: [40.0, 40.0, 40.0],
          ),
        ),
      ),
    );
    await mapboxMap.setCamera(CameraOptions(zoom: 17.0, pitch: 45.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        styleUri: "mapbox_harita_stili",
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(27.485166, 39.581678)),
          zoom: 18,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}