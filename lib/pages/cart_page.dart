import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('\$${cartItem['price']}'),
            leading: Image.asset(cartItem['imageUrl'].toString()),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Remove Item'),
                      content: const Text(
                        'Are you sure you want to remove this item from the cart?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('No',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).removeProduct(cartItem);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${cartItem['title']} removed from cart',
                                ),
                              ),
                            ); // Close the dialog
                          },
                          child: const Text('Yes', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    );
                  },
                );
                //Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                // Handle item removal from cart
                //cart.removeAt(index);
              },
            ),
          );
        },
      ),
    );
  }
}
