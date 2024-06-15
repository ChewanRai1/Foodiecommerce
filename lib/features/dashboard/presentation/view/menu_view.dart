import 'package:flaviourfleet/features/dashboard/data/model/menu_model.dart';
import 'package:flutter/material.dart';
import 'home_view.dart';
import 'cart_view.dart';
import 'profile_view.dart';
// Import the MenuModel

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final MenuModel _menuModel = MenuModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 232, 168, 7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _menuModel.buildMenuItem(
                    'Promotions',
                    'assets/promotions.jpg',
                    '10 items',
                    () {
                      // Handle Promotions tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Beverages',
                    'assets/beverages.jpg',
                    '20 items',
                    () {
                      // Handle Beverages tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Food',
                    'assets/food.jpg',
                    '120 items',
                    () {
                      // Handle Food tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Dessert',
                    'assets/dessert.jpg',
                    '10 items',
                    () {
                      // Handle Dessert tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orangeAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.orangeAccent),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.orangeAccent),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orangeAccent),
            label: 'Profile',
          ),
        ],
        currentIndex: _menuModel.selectedIndex,
        onTap: (index) {
          setState(() {
            _menuModel.onItemTapped(index, context);
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.orange[50],
      ),
    );
  }
}
