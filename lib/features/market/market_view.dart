import 'package:flutter/material.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const MarketplaceScreen(),
    );
  }
}

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final List<Product> products = [
    Product(
      imageUrl:
          'https://cdn.britannica.com/16/126516-050-2D2DB8AC/Triumph-Rocket-III-motorcycle-2005.jpg',
      title: 'Uk jeep jacket',
      price: 'रू7,000',
    ),
    Product(
      imageUrl:
          "https://www.shift4shop.com/2015/images/sell-online/electronics/selling-charge-up.jpg",
      title: '8/128GB Ram',
      price: 'रू12,000',
    ),
    Product(
      imageUrl:
          'https://i5.walmartimages.com/seo/HP-15-6-FHD-Laptop-AMD-Ryzen-5-7520U-8GB-RAM-256GB-SSD-Pale-Rose-Gold-Windows-11-Home-15-fc0039wm_016446eb-4ada-4429-84b0-4badb49d083e.d83a8f1aeadc64a771d4dd1c375c46bd.jpeg',
      title: 'Laptop',
      price: 'रू7700',
    ),
    Product(
      imageUrl:
          "https://imgd.aeplcdn.com/370x208/n/cw/ec/173325/magnite-facelift-exterior-right-front-three-quarter-2.jpeg?isig=0",
      title: 'Nissan super...',
      price: 'रू795,000',
    ),
    Product(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmSkxH6-pgEm6lt-zMp4quIHKfxlGfdo5GNQ&s",
      title: 'Uk jeep jacket',
      price: 'रू7,000',
    ),
    Product(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtNjb3cAGuOm8nN0Iopqcehh8ZG2F7PwSlhg&s',
      title: '8/128GB Ram',
      price: 'रू12,000',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Marketplace', style: TextStyle(color: Colors.pink)),
        actions: const [
          Icon(Icons.person, color: Colors.pink),
          SizedBox(width: 16),
          Icon(Icons.menu, color: Colors.pink),
          SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sell'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Categories'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's picks",
                    style: TextStyle(color: Colors.pink, fontSize: 18)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.pink),
                    Text("Kathmandu, Nepal",
                        style: TextStyle(color: Colors.pink)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65, // Adjusted aspect ratio
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String title;
  final String price;

  Product({
    required this.imageUrl,
    required this.title,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink, // Darker card color
      elevation: 4, // Added elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16), // Increased font size
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.price,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14), // Increased font size
                ),
                // Center(
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>  ProductDetailsScreen(),
                //         ),
                //       );
                //     },
                //     child: const Text(
                //       "See details",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
