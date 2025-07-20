import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:SandBox_Gifts_Backup/core/Ai/openai_servicebuy_for_friend.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import '../providers/budget_provider.dart';

class StartMysteryPage extends StatefulWidget {
  const StartMysteryPage({super.key});

  @override
  State<StartMysteryPage> createState() => _StartMysteryPageState();
}

class _StartMysteryPageState extends State<StartMysteryPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final List<String> _questions = [
    "What is your name?",
    "How much would you like to spend? Within the boundaries of £15 and £50",
  ];
  final List<String> _responses = [];
  int _currentQuestionIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  String get budgetResponse =>
      _responses.length > 1
          ? _responses[1].replaceAll(RegExp(r'[£$€₽₹¥]'), '')
          : '';
  int get ageResponse =>
      _responses.length > 2 ? int.tryParse(_responses[2]) ?? 0 : 0;
  String get interestResponse => _responses.length > 4 ? _responses[4] : '';
  String get genderResponse => _responses.length > 3 ? _responses[3] : '';

  late AnimationController _animationController;
  late Animation<double> _bobbingAnimation;
  bool poopie = false;
  bool _showAddToCartButton = false;
  bool _questionsCompleted = false;

  bool _isProcessing = true;
  bool _isButtonProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final openAIService = Provider.of<OpenAIService>(context, listen: false);
    openAIService.clearMessages();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _bobbingAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1400));
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
              "Hi! I'm your guide to help you find the perfect gift from our vaults.",
        });
      });
      await Future.delayed(const Duration(milliseconds: 1400));
      if (!mounted) return;
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text':
              "We have thousands of surprises waiting to be discovered, but first let's run a few of the basic questions.",
        });
      });
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return;
      setState(() {
        _messages.add({
          'sender': 'ai',
          'text': _questions[_currentQuestionIndex],
        });
        _isProcessing = false;
      });
      _requestInputFocus();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    _scrollController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // This triggers a rebuild when the keyboard appears/disappears
    setState(() {});
  }

  void _onFocusChange() {
    if (!mounted) return;
    if (_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _scrollToBottom();
      });
    }
  }

  void _requestInputFocus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  Future<void> handleUserResponse(String message) async {
    if (!mounted || _isProcessing) return;
    final String trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': trimmedMessage});
      _responses.add(trimmedMessage);
      _isProcessing = true;
    });
    _textController.clear();
    _scrollToBottom();

    try {
      if (poopie == false && _currentQuestionIndex == _questions.length - 1) {
        final sanitizedMessage = trimmedMessage.replaceAll(
          RegExp(r'[£$€₽₹¥]'),
          '',
        );
        final price = double.tryParse(sanitizedMessage);
        if (price == null || price < 15 || price > 50) {
          if (!mounted) return;
          setState(() {
            _messages.add({
              'sender': 'ai',
              'text': "Invalid input. Please enter a number between 15 and 50.",
            });
            _isProcessing = false;
          });
          _scrollToBottom();
          _responses.removeLast();
          _requestInputFocus();
          return;
        }
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        if (!mounted) return;
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          _currentQuestionIndex++;
          _messages.add({
            'sender': 'ai',
            'text': _questions[_currentQuestionIndex],
          });
          _isProcessing = false;
        });
        _scrollToBottom();
        _requestInputFocus();
      } else if (!_questionsCompleted) {
        if (!mounted) return;
        setState(() {
          _questionsCompleted = true;
          poopie = true;
        });
        await _FirstAiChat();
        if (!mounted) return;
        _scrollToBottom();
      } else {
        await _startAIChat(trimmedMessage);
        if (!mounted) return;
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _requestInputFocus();
      }
    }
  }

  Future<void> _startAIChat([String? userMessage]) async {
    final openAIService = Provider.of<OpenAIService>(context, listen: false);
    try {
      final input =
          userMessage != null
              ? "${_responses.join(", ")}, $userMessage"
              : _responses.join(", ");
      if (!mounted) return;
      final response = await openAIService.giftFinderBot(
        input,
        context: context,
      );
      if (!mounted) return;
      setState(() {
        _messages.add({'sender': 'ai', 'text': response['message']});
        if (response['showAddToCart'] == true) {
          _showAddToCartButton = true;
        }
        _isProcessing = false;
      });
      _scrollToBottom();
      _requestInputFocus();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _requestInputFocus();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to continue AI chat: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _FirstAiChat() async {
    final openAIService = Provider.of<OpenAIService>(context, listen: false);
    try {
      final input = _responses.join(", ");
      if (!mounted) return;
      final response = await openAIService.giftFinderBot(
        input,
        name: _responses.isNotEmpty ? _responses[0] : "",
        budget: _responses.length > 1 ? _responses[1] : "",
        context: context,
      );
      if (!mounted) return;
      setState(() {
        _messages.add({'sender': 'ai', 'text': response['message']});
        if (response['showAddToCart'] == true) {
          _showAddToCartButton = true;
        }
        _isProcessing = false;
      });
      _scrollToBottom();
      _requestInputFocus();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _requestInputFocus();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get the first AI response: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void onTap() async {
    try {
      print('Simulating adding data to Supabase');
    } catch (e) {
      print('Failed to add data to Supabase: $e');
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isMobile = screenWidth < 800;
    final isKeyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final safeAreaTop = mediaQuery.padding.top;

    return BaseLayout(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isMobile
                    ? 'assets/images/ChatBackground.png'
                    : 'assets/images/ChatBackgroundLandscape.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        isMobile ? 20.0 : screenWidth * 0.2,
                        isKeyboardVisible ? 10 : screenHeight * 0.35,
                        isMobile ? 20.0 : screenWidth * 0.2,
                        0,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final isUser = message['sender'] == 'user';
                          return Align(
                            alignment:
                                isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.all(12),
                              constraints: BoxConstraints(
                                maxWidth: screenWidth * (isMobile ? 0.75 : 0.6),
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isUser
                                        ? Pallete.secondaryCol
                                        : Pallete.MainTextCol,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                message['text']!,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? 8.0 : screenWidth * 0.2,
                      8.0,
                      isMobile ? 8.0 : screenWidth * 0.2,
                      mediaQuery.viewInsets.bottom > 0 ? 8.0 : 20.0,
                    ),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(25.0),
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        enabled: !_isProcessing,
                        style: TextStyle(
                          color:
                              _isProcessing ? Colors.grey : Pallete.blackColor,
                          fontSize: 16,
                        ),
                        // --- THE FINAL FIX FOR SAFARI ---
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        // --- END OF FIX ---
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          hintText:
                              _isProcessing ? '' : 'Enter your message...',
                          filled: true,
                          fillColor: Pallete.MainTextCol.withOpacity(0.95),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send, color: Pallete.Purps),
                            onPressed:
                                _isProcessing
                                    ? null
                                    : () => handleUserResponse(
                                      _textController.text,
                                    ),
                          ),
                        ),
                        onSubmitted:
                            _isProcessing
                                ? null
                                : (value) => handleUserResponse(value),
                      ),
                    ),
                  ),
                ],
              ),
              if (!isKeyboardVisible)
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
              if (_showAddToCartButton)
                Positioned(
                  top: isKeyboardVisible ? (safeAreaTop + 5.0) : 20,
                  left: isMobile ? 20 : 100,
                  right: isMobile ? 20 : 100,
                  child: Center(
                    child: SizedBox(
                      width: isMobile ? null : screenWidth * 0.4,
                      child: ElevatedButton(
                        onPressed:
                            _isButtonProcessing
                                ? null
                                : () async {
                                  setState(() {
                                    _isButtonProcessing = true;
                                  });
                                  try {
                                    final budgetProvider =
                                        Provider.of<BudgetProvider>(
                                          context,
                                          listen: false,
                                        );
                                    final openAIService =
                                        Provider.of<OpenAIService>(
                                          context,
                                          listen: false,
                                        );

                                    final rawHistory =
                                        budgetProvider.conversationHistory;
                                    final cleanButRepetitiveHistory =
                                        await openAIService
                                            .createCleanTranscript(rawHistory);
                                    final finalSummarizedHistory =
                                        await openAIService
                                            .summarizeCleanTranscript(
                                              cleanButRepetitiveHistory,
                                            );
                                    budgetProvider.setConversationHistory(
                                      finalSummarizedHistory,
                                    );

                                    final summary = await openAIService
                                        .summarizeGiftPersona(context);
                                    onTap();
                                    budgetProvider.setBudget(budgetResponse);
                                    budgetProvider.setUserAge(ageResponse);
                                    budgetProvider.setUserGender(
                                      genderResponse,
                                    );
                                    budgetProvider.setUserInterests(
                                      interestResponse,
                                    );
                                    budgetProvider.setProductDetails(
                                      'Surprise Gift',
                                    );
                                    budgetProvider.setGiftSummary(summary);

                                    if (mounted) {
                                      context.push('/cart_page');
                                    }
                                  } catch (e) {
                                    print("Error during button press: $e");
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'An error occurred. Please try again.',
                                          ),
                                        ),
                                      );
                                    }
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isButtonProcessing = false;
                                      });
                                    }
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.secondaryCol,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:
                            _isButtonProcessing
                                ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                                : const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    SizedBox(width: 8),
                                    Text('Gift Summary'),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
