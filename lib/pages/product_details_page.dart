import 'package:SandBox_Gifts_Backup/pages/StartMysteryPage.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/Ai/openai_service.dart';


class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  void onTap() {
    Provider.of<CartProvider>(
      context,
      listen: false,
    ).addProduct({  
    'id': widget.product['id'],
    'title': widget.product['title'],
    'price': widget.product['price'],
    'sizes': widget.product['sizes'],
    'company': widget.product['company'],
    'imageUrl': widget.product['imageUrl']});
  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Product added successfully!'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green));
  }
  //   );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Details", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white)),
        
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 28,),
                textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(widget.product['imageUrl'] as String,),
            ),
          ),
          const Spacer(),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Color(0xFF00FF9C),
                      fontSize: 30,
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.product['sizes'] as String,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white70,
                      ),
                  ),
                ),


                // return GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) {
                //                   return ProductDetailsPage(product: product);
                //                 },
                //               ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton.icon(
                  onPressed: () async {
                  final openAIService = OpenAIService();
                  final title = widget.product['title'] as String;
                  final price = widget.product['price'] as double;

                  try {
                    // Generate a response from OpenAI
                    final aiResponse = await openAIService.isArtPromptAPI(title, price);

                    // Navigate to StartMysteryPage with the product and AI response
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return StartMysteryPage(
                            product: widget.product,
                            aiResponse: aiResponse, // Pass the AI response
                          );
                        },
                      ),
                    );
                  } catch (e) {
                    // Handle errors (e.g., show a snackbar)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to generate response: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                    icon: const Icon(Icons.search, color: Colors.black),
                    label: Text(
                      'Start Mystery',),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF9C),
                      foregroundColor: Colors.black,
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      fixedSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    ),
                  ),
                  //prefixIcon: const Icon(Icons.search, color: Colors.white, size: 20,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
