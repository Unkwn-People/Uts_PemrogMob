import 'package:flutter/material.dart';
import '../detail_product.dart';

class CameraCategoryPage extends StatelessWidget {
  const CameraCategoryPage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "name": "INSTA360 ACE PRO ACTION CAM ACE_PRO_ID", 
      "price": "Rp 5.549.000", 
      "image": "lib/images/product/camera1.png"
    },
    {
      "name": "GOPRO SPORT & ACTION CAM HERO 12 GOPRO_HERO12", 
      "price": "Rp 6.419.000", 
      "image": "lib/images/product/camera2.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.80,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final item = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                name: item["name"],
                price: item["price"],
                image: item["image"],
              )));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 6)],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(child: Image.asset(item["image"], fit: BoxFit.contain)),
                  const SizedBox(height: 6),
                  Text(item["name"], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text("Rp ${item["price"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
