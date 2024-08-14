import 'package:flaviourfleet/features/cart/presentation/view/cart_view.dart';
import 'package:flaviourfleet/features/favorite/presentation/view/favorite_view.dart';
import 'package:flaviourfleet/features/favorite/presentation/viewmodel/favorite_viewmodel.dart';
import 'package:flaviourfleet/features/home/presentation/view/home_view.dart';
import 'package:flaviourfleet/features/addfood/presentation/view/add_food_view.dart';
import 'package:flaviourfleet/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int _selectedIndex = 0;
  late List<Widget> lstBottomScreen;

  @override
  void initState() {
    super.initState();
    lstBottomScreen = [
      const HomeView(),
      const CartView(),
      const PostProductView(),
      const FavoriteView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange[400],
        // Set the background color to orange
        selectedItemColor:
            Colors.white, // Set the color of the selected item to white
        unselectedItemColor:
            Colors.white.withOpacity(0.7), // Set the color of unselected items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'My Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Food'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'You'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 3) {
        // Favorite index
        ref.read(favoriteViewModelProvider.notifier).getFavorites();
      }
    });
  }
}
