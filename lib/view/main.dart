import 'package:flutter/material.dart';
import 'package:ui/view/home.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Screens for each tab
  final List _screens = [
    const Home(),
    const Center(child: Text('Coin Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Wallet Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.lightBlue : Colors.grey,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.monetization_on,
                color: _selectedIndex == 1 ? Colors.lightBlue : Colors.grey,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 60), // Space for FloatingActionButton
            IconButton(
              icon: Icon(
                Icons.wallet_outlined,
                color: _selectedIndex == 2 ? Colors.lightBlue : Colors.grey,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 3 ? Colors.lightBlue : Colors.grey,
              ),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
                child: Image.asset(
              "assets/images/up-down.png",
              height: 24,
              width: 24,
            )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
