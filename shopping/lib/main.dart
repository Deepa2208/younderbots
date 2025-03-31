import 'package:flutter/material.dart';

void main() {
  runApp(Shop());
}

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/sort.png"),
                    ),
                  ),
                  Text(
                    "Gemstore",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/Bell_pin.png"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CategorySelector(),
              SizedBox(height: 20),
              Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      "assets/banner.png",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.3,
                      ), // Dark overlay for readability
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Text(
                      "Autumn\nCollection\n 2022",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Feature Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    "Show all",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 20),
              featureProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget featureProductsSection() {
  final List<Map<String, String>> products = [
    {
      "image": "assets/longsleeve.png",
      "name": "Long Sleeve Dress",
      "price": "\$45.00",
    },
    {
      "image": "assets/sportswear.jpg",
      "name": "Sportwear Set",
      "price": "\$80.00",
    },
    {
      "image": "assets/turtleneck.png",
      "name": "Black Sweater",
      "price": "\$50.00",
    },
  ];

  return SizedBox(
    height: 250,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return productCard(
          products[index]["image"]!,
          products[index]["name"]!,
          products[index]["price"]!,
        );
      },
    ),
  );
}

Widget productCard(String imagePath, String name, String price) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              price,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CategoryItem(String title, IconData icon, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: isSelected ? Colors.black : Colors.grey[200],
          child: Icon(
            icon,
            size: 24,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "Women", "icon": Icons.female},
    {"title": "Men", "icon": Icons.male},
    {"title": "Accessories", "icon": Icons.watch},
    {"title": "Beauty", "icon": Icons.brush},
    {"title": "Shoes", "icon": Icons.shopping_bag},
    {"title": "Kids", "icon": Icons.child_friendly},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              print("Selected Category: ${categories[index]['title']}");
            },
            child: CategoryItem(
              categories[index]["title"] as String,
              categories[index]["icon"] as IconData,
              index == selectedIndex,
            ),
          );
        },
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Search Page", style: TextStyle(fontSize: 24)));
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Cart Page", style: TextStyle(fontSize: 24)));
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Page", style: TextStyle(fontSize: 24)));
  }
}
