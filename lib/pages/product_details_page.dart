import 'package:SandBox_Gifts_Backup/pages/StartMysteryPage.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/core/Ai/openai_service.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isLoading = false;

  void onTap() {
    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product['id'],
      'title': widget.product['title'],
      'price': widget.product['price'],
      'sizes': widget.product['sizes'],
      'company': widget.product['company'],
      'imageUrl': widget.product['imageUrl'],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added successfully!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryCol,
      appBar: AppBar(
        backgroundColor: Pallete.secondaryCol,
        title: const Text("Details", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Main content of the page
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.product['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 300, // Set the desired width
                    height: 300, // Set the desired height
                    child: Image.asset(
                      widget.product['imageUrl'] as String,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Pallete.hintTextCol,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '\$${widget.product['price']}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Pallete.primaryCol,
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.product['sizes'] as String,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (isLoading)
                            return; // Prevent multiple actions if already loading

                          setState(() {
                            isLoading = true; // Set loading state to true
                          });

                          final openAIService = OpenAIService();
                          final title = widget.product['title'] as String;
                          final price = widget.product['price'] as double;

                          try {
                            // Generate a response from OpenAI
                            final aiResponse = await openAIService
                                .isArtPromptAPI(title, price);

                            // Navigate to StartMysteryPage with the product and AI response
                            if (mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return StartMysteryPage(
                                      product: widget.product,
                                      aiResponse:
                                          aiResponse, // Pass the AI response
                                    );
                                  },
                                ),
                              );
                            }
                          } catch (e) {
                            // Handle errors (e.g., show a snackbar)
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to generate response: $e',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                isLoading = false; // Reset loading state
                              });
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Pallete.ScaffoldBackgroundColor,
                        ),
                        label: const Text('Start Mystery'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.primaryCol,
                          foregroundColor: Pallete.ScaffoldBackgroundColor,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          fixedSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Loading indicator overlay
          if (isLoading)
            Container(
              color: Pallete.ScaffoldBackgroundColor.withOpacity(
                0.5,
              ), // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(
                  color: Pallete.primaryCol, // Match the theme color
                ),
              ),
            ),
        ],
      ),
    );
  }
}
