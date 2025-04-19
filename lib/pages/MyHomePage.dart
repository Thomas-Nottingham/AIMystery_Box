import 'package:SandBox_Gifts_Backup/pages/cart_page.dart';
import 'package:SandBox_Gifts_Backup/widgets/product_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int currentPage = 0;

  List<Widget> pages = [
    const ProductList(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        currentIndex: currentPage,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), 
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart')]),
    );
  }
}
