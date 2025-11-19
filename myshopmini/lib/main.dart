// main.dart
import 'dart:async';
import 'package:flutter/material.dart';

// Import halaman kategori
import 'category/smartphone_category.dart';
import 'category/laptop_category.dart';
import 'category/tablet_category.dart';
import 'category/camera_category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My ShopMini',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  // Banner gambar lokal
  final List<Map<String, String>> promoBanner = [
    {
      "title": "Diskon 40% Smartphone",
      "subtitle": "Promo terbatas hingga akhir bulan!",
      "image": "lib/images/banner/smartphone.png"
    },
    {
      "title": "Laptop Sale 30%",
      "subtitle": "Harga terbaik untuk pelajar",
      "image": "lib/images/banner/laptop.png"
    },
    {
      "title": "Promo Tablet Mulai 10rb",
      "subtitle": "Tablet Murah Untuk Kebutuhan Anda",
      "image": "lib/images/banner/tablet.png"
    },
  ];

  // Kategori
  final List<Map<String, dynamic>> categories = [
    {"name": "Smartphone", "icon": Icons.smartphone},
    {"name": "Laptop", "icon": Icons.laptop_mac},
    {"name": "Tablet", "icon": Icons.tablet_mac},
    {"name": "Camera", "icon": Icons.photo_camera},

    // Kategori tambahan, tapi belum dibuat halamannya
    {"name": "Headset", "icon": Icons.headphones},
    {"name": "Smartwatch", "icon": Icons.watch},
    {"name": "Televisi", "icon": Icons.tv},
    {"name": "Aksesoris", "icon": Icons.cable},
  ];

  Timer? autoPlayTimer;

  @override
  void initState() {
    super.initState();

    // Auto-slide banner
    autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentIndex < promoBanner.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Fungsi untuk pindah halaman berdasarkan kategori
  void openCategory(String name) {
    switch (name) {
      case "Smartphone":
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SmartphoneCategoryPage()));
        break;

      case "Laptop":
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LaptopCategoryPage()));
        break;

      case "Tablet":
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => TabletCategoryPage()));
        break;

      case "Camera":
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => CameraCategoryPage()));
        break;

      // Jika kategori belum ada halamannya:
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Halaman kategori '$name' belum tersedia"),
            duration: const Duration(seconds: 1),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "My ShopMini",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =============================
            // CAROUSEL BANNER
            // =============================
            SizedBox(
              height: 150,
              child: PageView.builder(
                controller: _pageController,
                itemCount: promoBanner.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final banner = promoBanner[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(banner["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner["title"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner["subtitle"]!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                promoBanner.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =============================
            // KATEGORI
            // =============================
            const Text(
              "Kategori Barang Elektronik",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = categories[index];

                return GestureDetector(
                  onTap: () => openCategory(item["name"]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black12.withOpacity(0.06),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item["icon"],
                          size: 40,
                          color: Colors.blue.shade400,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item["name"],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
