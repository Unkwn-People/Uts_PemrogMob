import 'package:flutter/material.dart';
import '../detail_product.dart';

class LaptopCategoryPage extends StatelessWidget {
  const LaptopCategoryPage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "name": "MSI GAMING LAPTOP NOTEBOOK Cyborg 15 AI A1VEK Intel Core ULTRA 7-155H",
      "price": "Rp 21.499.000", 
      "image": "lib/images/product/laptop1.png"
    },
    {
      "name": "ACER LAPTOP GAMING NITRO V 16 ANV16-71-79NR INTEL CORE I7-14650HX", 
      "price": "Rp 16.999.000",
      "image": "lib/images/product/laptop2.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laptop"), centerTitle: true),
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
