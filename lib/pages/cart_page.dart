import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;
    final cart = Provider.of<CartProvider>(context).cart;

    // Define a custom AppBar for the CartPage

    return BaseLayout(
      appBarColor: Pallete.whiteColor,
      iconColor: Pallete.blackColor,
      appTextColor: Pallete.blackColor,
      centerTitle: true,
      text_title: Text(
        'Checkout and Payment',
        style: TextStyle(color: Pallete.blackColor),
      ),
      child: Stack(
        children: [
          // Background Image
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Image.asset(
              isMobile
                  ? 'assets/images/Cart_Background.png'
                  : 'assets/images/cart_background3.png',
              fit: isMobile ? BoxFit.cover : BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
