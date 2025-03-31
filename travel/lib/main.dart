import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int selectedFilterIndex = 0;
  bool isFavorite = false;
  final List<String> filters = ['Most Viewed', 'Nearby', 'Latest'];
  final List<Widget> _pages = [
    const Center(child: Text("Home", style: TextStyle(fontSize: 24))),
    const Center(child: Text("History", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Favorites", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Profile", style: TextStyle(fontSize: 24))),
  ];
  final List<Map<String, String>> places = [
    {
      'image': 'assets/fuji.jpeg',
      'name': 'Mount Fuji, Tokyo',
      'location': 'Tokyo, Japan',
      'rating': '4.8',
    },
    {
      'image': 'assets/ande.jpeg',
      'name': 'Andes, South America',
      'location': 'South America',
      'rating': '4.5',
    },
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(sw * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hi, David 👋",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sw * 0.07,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: sw * 0.06,
                  backgroundImage: const AssetImage('assets/profile.png'),
                ),
              ],
            ),
            SizedBox(height: sh * 0.01),
            Text(
              "Explore the world",
              style: TextStyle(color: Colors.grey, fontSize: sw * 0.04),
            ),
            SizedBox(height: sh * 0.03),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: sw * 0.02),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Search places",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/filter (1).png',
                      width: sw * 0.06,
                      height: sw * 0.06,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: sh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Popular places",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sw * 0.05,
                  ),
                ),
                Spacer(),
                Text(
                  "View all",
                  style: TextStyle(color: Colors.grey, fontSize: sw * 0.04),
                ),
              ],
            ),

            SizedBox(height: sh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  filters.asMap().entries.map((entry) {
                    return _buildFilterButton(entry.value, entry.key);
                  }).toList(),
            ),
            SizedBox(height: sh * 0.03),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return _buildPlaceCard(places[index], sw, sh);
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: sh * 0.01),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, 0, sw),
            _buildNavItem(Icons.access_time, 1, sw),
            _buildNavItem(Icons.favorite_border, 2, sw),
            _buildNavItem(Icons.person, 3, sw),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, double screenWidth) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: screenWidth * 0.08,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          SizedBox(height: screenWidth * 0.01),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSelected ? 6 : 0,
            height: isSelected ? 6 : 0,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, int index) {
    bool isSelected = index == selectedFilterIndex;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilterIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildPlaceCard(Map<String, String> place, double sw, double sh) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            width: sw * 0.65,
            height: sh * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(place['image']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: sw * 0.65,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place['location']!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.star_border, color: Colors.white, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        place['rating']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
