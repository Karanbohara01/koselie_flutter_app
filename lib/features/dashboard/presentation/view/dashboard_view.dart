import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Koselie!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    title: categories[index]['title'] as String,
                    imageUrl: categories[index]['imageUrl'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> categories = [
  {
    'title': 'Electronics',
    'imageUrl':
        'https://m.media-amazon.com/images/I/71Pai0YmEfL._SL1500_.jpg', // Replace with actual URLs
  },
  {
    'title': 'Fashion',
    'imageUrl':
        'https://media.glamour.com/photos/66f5c2777e09bc43bcee2067/master/w_2560%2Cc_limit/men%25E2%2580%2599s%2520fashion%2520trends.jpg',
  },
  {
    'title': 'Home & Garden',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_D6UzlJ_5J0RihunglhixoPywcOur3xMC9A&s',
  },
  {
    'title': 'Beauty',
    'imageUrl':
        'https://cdn.pixabay.com/photo/2023/11/14/22/54/beauty-8388807_640.jpg',
  },
  {
    'title': 'Toys',
    'imageUrl':
        'https://cdn.firstcry.com/education/2022/11/06094158/Toy-Names-For-Kids.jpg',
  },
  {
    'title': 'Sports',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Xv5vxs84doIRq3u1hKcZNzaendHsB3ADiA&s',
  },
  {
    'title': 'Automotive',
    'imageUrl':
        'https://cdn.bikedekho.com/processedimages/royal-enfield/classic350/494X300/classic35066d56da536989.jpg',
  },
  {
    'title': 'Books',
    'imageUrl':
        'https://junealholder.blog/wp-content/uploads/2019/05/img_20190505_155026_731-1.jpg?w=640',
  },
];
