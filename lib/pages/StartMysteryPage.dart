import 'package:SandBox_Gifts_Backup/core/Ai/openai_service.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/supabase_client.dart';
import 'package:flutter/material.dart';

final OpenAIService openAIService = OpenAIService();

class StartMysteryPage extends StatefulWidget {
  //final String aiResponse;

  const StartMysteryPage({
    super.key,
    //required this.aiResponse,
  });

  @override
  State<StartMysteryPage> createState() => _StartMysteryPageState();
}

class _StartMysteryPageState extends State<StartMysteryPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = []; // List to store chat messages
  final List<String> _questions = [
    "What is your name?",
    "What is the occasion?",
    "What is your age?",
    "What is your gender?",
    "What are some of your hobbies/interests?",
    "Last but not least, how much are you willing to spend on this gift? Minimum £10 and Maximum £50",
  ]; // List of questions
  final List<String> _responses = []; // List to store user responses
  int _currentQuestionIndex = 0; // Track the current question index
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode(); // Add this to manage focus

  late AnimationController _animationController;
  late Animation<double> _bobbingAnimation;
  bool poopie = false; // Flag to track if the user has answered the questions

  bool _showAddToCartButton = false; // Flag to show the "Add to Cart" button
  bool _questionsCompleted = false; // Flag to track if questions are completed

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of one bobbing cycle
    )..repeat(reverse: true); // Repeat the animation in reverse

    // Define the Tween for the bobbing effect
    _bobbingAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Smooth up-and-down motion
      ),
    );

    // Add the initial AI welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
              "Hi! I'm here to help you find the perfect gift. Let's start with a few questions to tailor the gift to your needs!",
        });
        _messages.add({
          'sender': 'ai',
          'text': _questions[_currentQuestionIndex],
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  Future<void> handleUserResponse(String message) async {
    // Add the user's response to the chat
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
      _responses.add(
        message,
      ); // Append the user's response to the responses list
    });

    // Scroll to the bottom to show the latest message
    _scrollToBottom();

    // Check if the current question is the price question
    if (poopie == false &&
        _questions[_currentQuestionIndex] ==
            "Last but not least, how much are you willing to spend on this gift? Minimum £10 and Maximum £50") {
      final sanitizedMessage = message.replaceAll(RegExp(r'[£$€₽₹¥]'), '');
      final price = double.tryParse(sanitizedMessage);

      if (price == null || price < 10 || price > 50) {
        // If the input is invalid, repeat the question with an error message
        setState(() {
          _messages.add({
            'sender': 'ai',
            'text': "Invalid input. Please enter a number between 10 and 50.",
          });
        });
        _scrollToBottom();
        return; // Exit the method to wait for a valid response
      }
    }

    // Move to the next question or finish the conversation
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _messages.add({
          'sender': 'ai',
          'text': _questions[_currentQuestionIndex],
        });
      });
      _scrollToBottom();
    } else if (!_questionsCompleted) {
      // Final AI response after all questions are answered
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
              "Thank you for answering all the questions! I'll now find the perfect gift for you.",
        });
        _showAddToCartButton = true; // Show the "Add to Cart" button
        _questionsCompleted = true; // Mark questions as completed
        poopie = true;

        // Add the disclaimer message
        _messages.add({
          'sender':
              'disclaimer', // Use a custom sender to style the message in red
          'text':
              "You can add to cart, but the gift may be more random. You can of course do this, but if you want to tailor further, continue speaking to me.",
        });
      });
      _scrollToBottom();

      // Send the first AI message to _ContinueAiChat
      await _FirstAiChat();
    } else {
      // If questions are already completed, continue the AI chat
      await _startAIChat(message);
    }
  }

  Future<void> _startAIChat([String? userMessage]) async {
    try {
      // Prepare the input for the AI chat
      final input =
          userMessage != null
              ? _responses.join(", ") + ", " + userMessage
              : _responses.join(", ");
      print("Input sent to AI: $input");

      // Send the input to the AI service
      final response = await openAIService.AIChatBot(input);

      // Add the AI's response to the chat
      setState(() {
        _messages.add({'sender': 'ai', 'text': response});
      });

      // Scroll to the bottom to show the latest message
      _scrollToBottom();
    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to continue AI chat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _FirstAiChat() async {
    try {
      // Map responses to their corresponding questions
      final Map<String, String> responseMap = {
        "Name": _responses[0],
        "Occasion": _responses[1],
        "Age": _responses[2],
        "Gender": _responses[3],
        "Interests": _responses[4],
        "Budget": _responses[5],
      };

      // Construct a structured input for the AI
      final input = """ 
      """;

      // Send the input to the AI service
      final response = await openAIService.AIChatBot(
        input,
        name: _responses[0],
        occasion: _responses[1],
        age: (_responses[2]),
        gender: _responses[3],
        interests: _responses[4],
        budget: (_responses[5]),
      );

      // Add the AI's response to the chat
      setState(() {
        _messages.add({'sender': 'ai', 'text': response});
      });

      // Scroll to the bottom to show the latest message
      _scrollToBottom();
    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get the first AI response: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void onTap() async {
    // Add the product to the cart

    // product['stored_chat'] =
    //     openAIService.Amazon_Search_Data.map(
    //       (data) => Map<String, String>.from(data),
    //     ).toList();

    try {
      final response = await supabase.from('cart_items').insert({
        // 'product_id': product['id'],
        // 'title': product['title'],
        // 'price': product['price'],
        // 'stored_chat': product['stored_chat'], // JSONB field
        "title": "poopie",
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
    // print(product);

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;

    return BaseLayout(
      child: Stack(
        children: [
          // Background Image
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Image.asset(
              isMobile
                  ? 'assets/images/ChatBackground.png'
                  : 'assets/images/ChatBackgroundLandscape.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // Bobbing Animation for Main_Present Image
          AnimatedBuilder(
            animation: _bobbingAnimation,
            builder: (context, child) {
              return Positioned(
                top: screenHeight * 0.02 + _bobbingAnimation.value,
                left: screenWidth / 2 - (screenHeight * 0.2),
                child: child!,
              );
            },
            child: Image.asset(
              'assets/images/Main_Present.png',
              width: screenHeight * 0.4,
              height: screenHeight * 0.4,
              fit: BoxFit.contain,
            ),
          ),

          // Chat Messages
          Positioned(
            top: screenHeight * 0.35,
            left: isMobile ? 20 : screenHeight * 0.42,
            right: isMobile ? 20 : screenHeight * 0.42,
            bottom: isMobile ? 85 : 120,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['sender'] == 'user';
                      final isDisclaimer = message['sender'] == 'disclaimer';

                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isUser
                                    ? Pallete.secondaryCol
                                    : isDisclaimer
                                    ? Colors.red
                                    : Pallete.MainTextCol,

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message['text']!,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Text Input Field
          Positioned(
            bottom: 20,
            left:
                isMobile
                    ? 20
                    : screenWidth *
                        0.2, // Adjust left padding based on isMobile
            right: isMobile ? 20 : screenWidth * 0.2,
            child: TextField(
              controller: _textController,
              focusNode: _focusNode, // Attach the focus node
              style: const TextStyle(color: Pallete.blackColor),
              minLines: isMobile ? 1 : 3,
              maxLines: isMobile ? 2 : 3,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                hintStyle: const TextStyle(color: Colors.deepPurple),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Pallete.Purps),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Pallete.Purps),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Pallete.Purps),
                ),
                filled: true,
                fillColor: Pallete.MainTextCol,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  handleUserResponse(value);
                  _textController.clear();
                  _scrollToBottom();
                  _focusNode.requestFocus(); // Keep the text field focused
                }
              },
            ),
          ),

          // Add to Cart Button
          if (_showAddToCartButton)
            Positioned(
              top: 20,
              left:
                  isMobile
                      ? 20
                      : screenWidth *
                          0.4, // Adjust left padding based on isMobile
              right: isMobile ? 20 : screenWidth * 0.4,
              child: ElevatedButton.icon(
                onPressed: () {
                  onTap();
                  Navigator.of(context).pushNamed('/cart_page');
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.secondaryCol,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
