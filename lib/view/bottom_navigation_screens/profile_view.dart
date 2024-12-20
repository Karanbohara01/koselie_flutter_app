import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Section
              const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/AEdFTp7YZOCxHujVnJuM7eCc4dAZ8S67DyBYE3-RMXex0g=s96-c'), // Replace with your image
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Karan Bohara',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'View Marketplace profile',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Action Buttons
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                children: const [
                  ActionButton(
                      title: 'Saved items', icon: Icons.favorite_border),
                  ActionButton(
                      title: '2 messages', icon: Icons.message_outlined),
                  ActionButton(title: 'Reviews', icon: Icons.star_border),
                  ActionButton(title: 'Recently viewed', icon: Icons.history),
                ],
              ),

              const SizedBox(height: 20),
              const SectionTitle(
                'Selling',
              ),

              // Selling Section
              const ListTile(
                leading: Icon(
                  Icons.list,
                  color: Colors.pink,
                ),
                title: Text('Your listings (1)'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.flash_on,
                  color: Colors.pink,
                ),
                title: Text(
                  'Quick actions',
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.pink,
                ),
                title: Text('Marketplace followers'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.bar_chart,
                  color: Colors.pink,
                ),
                title: Text('All selling activities'),
              ),

              const SizedBox(height: 20),
              const SectionTitle('Preferences'),

              // Preferences Section
              const ListTile(
                leading: Icon(
                  Icons.check_box_outlined,
                  color: Colors.pink,
                ),
                title: Text('Following'),
              ),

              const SizedBox(height: 20),
              const SectionTitle('Account'),

              // Account Section
              const ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.pink,
                ),
                title: Text('Location'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.pink,
                ),
                title: Text('Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const ActionButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink[800],
        padding: const EdgeInsets.symmetric(vertical: 8), // Reduced padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24), // Adjusted icon size
          const SizedBox(height: 4), // Reduced spacing
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12, // Reduced font size
              overflow: TextOverflow.ellipsis, // Prevents overflow
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
