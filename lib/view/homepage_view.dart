import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 2, 80),
        title: Row(
          children: [
            Image.asset('assets/logo/logo.png', height: 30),
            const SizedBox(width: 10),
            const Text('Koselie', style: TextStyle(fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // Horizontal Icon Menu
          Container(
            padding: const EdgeInsets.all(2.0),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildIconMenu(Icons.home),
                  _buildIconMenu(Icons.video_camera_front),
                  _buildIconMenu(Icons.people),
                  _buildIconMenu(Icons.location_city),
                  _buildIconMenu(Icons.notifications),
                  _buildIconMenu(Icons.menu),
                ],
              ),
            ),
          ),

          // Story Section
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StoryItem(
                      image: 'assets/images/person1.jpeg',
                      name: 'Binita Budhathoki'),
                  SizedBox(width: 10),
                  StoryItem(
                      image: 'assets/images/pushpa.jpg', name: 'Pratistha Kc'),
                  SizedBox(width: 10),
                  StoryItem(
                      image: 'assets/images/rashmika.jpeg',
                      name: 'Komal Xettri'),
                  SizedBox(width: 10),
                  StoryItem(
                      image: 'assets/images/baby.jpg', name: 'Komal Xettri'),
                  SizedBox(width: 10),
                  StoryItem(
                      image: 'assets/images/Rajesh_Hamal.jpg',
                      name: 'Komal Xettri'),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),

          // Post Feed
          const PostCard(
            name: 'Peter',
            time: '53m ago',
            content: 'Feeling happy with अर्जुन बस्नेत and Alina Budhathoki.',
            image: 'assets/images/group.jpg',
          ),
          const PostCard(
            name: 'Shambhavi Bohara',
            time: '53m ago',
            content: 'Feeling happy with अर्जुन बस्नेत and Alina Budhathoki.',
            image: 'assets/images/baby.jpg',
          ),
          const PostCard(
            name: 'Pushpa Raj',
            time: '53m ago',
            content: 'Feeling happy with अर्जुन बस्नेत and Alina Budhathoki.',
            image: 'assets/images/pushpa.jpg',
          ),
          const PostCard(
            name: 'Rashmika Mandana',
            time: '53m ago',
            content: 'Feeling happy with अर्जुन बस्नेत and Alina Budhathoki.',
            image: 'assets/images/rashmika.jpeg',
          ),
        ],
      ),
    );
  }

  Widget _buildIconMenu(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.pinkAccent.withOpacity(0.1),
        child: Icon(icon, color: Colors.pinkAccent),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final String image;
  final String name;

  const StoryItem({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image),
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(height: 5),
        Text(name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String image; // Only a single image is used now

  const PostCard({
    super.key,
    required this.name,
    required this.time,
    required this.content,
    required this.image, // A single image
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/pushpa.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(time,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Post Content
            Text(content, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            // Single Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image,
                  fit: BoxFit.cover), // Display a single image
            ),
          ],
        ),
      ),
    );
  }
}
