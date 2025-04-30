import 'package:SandBox_Gifts_Backup/core/Ai/openai_service.dart';
import 'package:SandBox_Gifts_Backup/providers/cart_provider.dart';
import 'package:SandBox_Gifts_Backup/presentation/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:SandBox_Gifts_Backup/global_variables.dart';

class StartMysteryPage extends StatefulWidget {
  final Map<String, Object> product;
  final String aiResponse;

  const StartMysteryPage({
    super.key,
    required this.product,
    required this.aiResponse,
  });

  @override
  State<StartMysteryPage> createState() => _StartMysteryPageState();
}

class _StartMysteryPageState extends State<StartMysteryPage> {
  String lastWords = '';

  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImage;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Use the aiResponse passed from the previous page
    generatedContent = widget.aiResponse;
  }

  Future<void> sendMessageToAI(String message) async {
    try {
      // Call the chatGPTAPI with the user's message
      final response = await openAIService.chatGPTAPI(message);

      // Update the UI with the AI's response
      setState(() {
        generatedContent = response;
      });
    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onTap() async {
    // Add the product to the cart
    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product['id'],
      'title': widget.product['title'],
      'price': widget.product['price'],
      'sizes': widget.product['sizes'],
      'company': widget.product['company'],
      'imageUrl': widget.product['imageUrl'],
    });

    // Update the stored_chat field with the OpenAIService messages list
    final productId = widget.product['id'];
    final product = products.firstWhere((p) => p['id'] == productId);
    product['stored_chat'] = List<Map<String, String>>.from(
      openAIService.Amazon_Search_Data,
    );

    try {
      final response = await supabase.from('cart_items').insert({
        'product_id': product['id'],
        'title': product['title'],
        'price': product['price'],
        'stored_chat': product['stored_chat'], // JSONB field
      });

      if (response.error != null) {
        throw response.error!;
      }

      print('Data added to Supabase successfully: $response');
    } catch (e) {
      print('Failed to add data to Supabase: $e');
    }

    // Print the entire product data for debugging
    print('Updated Product Data:');
    print(product);

    // Show a success message
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
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Pallete.Purps),
    );
    return Scaffold(
      backgroundColor: Pallete.primaryCol,
      appBar: AppBar(
        backgroundColor: Pallete.secondaryCol,
        title: Center(
          child: const Text(
            "Let us surprise you with a tailored gift",
            style: TextStyle(
              color: Pallete.MysteryTitle,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Pallete.MainTextCol),
      ),

      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                width: 200,
                height: 200,
              ),
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  // Makes the image circular
                  child: Image.asset(
                    'assets/images/profile_picture.png', // Replace with your image path
                    width: 80, // Set the width of the image
                    height: 80, // Set the height of the image
                    fit:
                        BoxFit
                            .cover, // Ensures the image fits within the circle
                  ),
                ),
                const SizedBox(
                  width: 8,
                ), // Add some spacing between the image and text
                Text(
                  "AI Chat",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Pallete.MainTextCol,
                    fontSize: 42,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const Spacer(),
          Container(
            height: 360,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Pallete.secondaryCol,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                FadeInRight(
                  child: Visibility(
                    visible: generatedImage == null,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight:
                            150, // Set the maximum height for the container
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ).copyWith(top: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.borderColor),
                        borderRadius: BorderRadius.circular(
                          20,
                        ).copyWith(topLeft: Radius.zero),
                        boxShadow: [
                          BoxShadow(
                            color: Pallete.Purps.withOpacity(0.2), // Glow color
                            blurRadius: 5, // Spread of the glow
                            spreadRadius: 0,
                            offset: Offset(0, 0), // Intensity of the glow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          generatedContent == null
                              ? 'Hi! I see you have selected a standard mystery gift :). Nice choice! Now im here to make sure the gift you get is unique interesting and taliored to you! Please begin by telling me about yourself.'
                              : generatedContent!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Cera Pro",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    controller:
                        _textController, // Optional: Add a controller if needed
                    style: TextStyle(color: Pallete.Purps),
                    minLines: 2, // Start with 2 lines
                    maxLines: 3, // Expand up to 4 lines
                    keyboardType: TextInputType.text,
                    textInputAction:
                        TextInputAction.done, // Enables multiline input
                    scrollController:
                        ScrollController(), // Adds scrolling functionality

                    decoration: InputDecoration(
                      hintText: 'Enter your answers here...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      filled: true,
                      fillColor: Pallete.MainTextCol,
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        sendMessageToAI(value); // Send the message to the AI
                        _textController
                            .clear(); // Clear the TextField after submission
                      }
                    },
                  ),
                ),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0)),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Pallete.ScaffoldBackgroundColor,
                  ),
                  label: const Text('Add To Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.secondaryCol,
                    foregroundColor: Pallete.ScaffoldBackgroundColor,
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    fixedSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
