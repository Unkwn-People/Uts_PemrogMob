import 'package:flutter/material.dart';
import '../detail_product.dart';

class SmartphoneCategoryPage extends StatelessWidget {
  const SmartphoneCategoryPage({super.key});

  final List<Map<String, dynamic>> smartphoneProducts = const [
    {
      "name": "Iphone 16 Pro Max",
      "price": "21.999.000",
      "image": "lib/images/product/smartphone1.png",
    },
    {
      "name": "Samsung S25 Ultra",
      "price": "20.999.000",
      "image": "lib/images/product/smartphone2.png",
    },
    {
      "name": "Motorola G45",
      "price": "2.199.000",
      "image": "lib/images/product/smartphone3.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smartphone"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: smartphoneProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.80,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final item = smartphoneProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    name: item["name"],
                    price: item["price"],
                    image: item["image"],
                  ),
                ),
              );
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
