import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/global_variables.dart';
import 'package:video_player/video_player.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late String selectedFilter;
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  bool isVideoVisible = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _faqKey = GlobalKey(); // Key for the FAQ section
  final GlobalKey _aboutKey = GlobalKey(); // Key for the About section

  // Add FAQ state to track expanded item
  int? _expandedIndex;

  // FAQ data: list of questions and answers
  final List<Map<String, String>> faqItems = [
    {
      'question': 'What is SandBox Gifts?',
      'answer':
          'SandBox Gifts is your go-to platform for discovering unique and exciting gift ideas. We help you find the perfect gift for any occasion, with a curated selection of products and experiences.',
    },
    {
      'question': 'How do I download the SandBox Gifts app?',
      'answer':
          'You can download the SandBox Gifts app from the App Store (iOS) or Google Play Store (Android). Simply search for "SandBox Gifts" and follow the installation instructions.',
    },
    {
      'question': 'What is included in a SandBox Gifts subscription?',
      'answer':
          'A SandBox Gifts subscription includes access to premium gift recommendations, exclusive discounts, and priority customer support. Check our subscription page for more details.',
    },
    {
      'question': 'How much does SandBox Gifts cost?',
      'answer':
          'Pricing varies depending on the subscription plan. Visit our pricing page for the most up-to-date information.',
    },
    {
      'question': 'Does my SandBox Gifts subscription automatically renew?',
      'answer':
          'Yes, subscriptions automatically renew at the end of each billing cycle. You can manage your subscription settings in your account.',
    },
    {
      'question': 'How do I cancel my SandBox Gifts subscription?',
      'answer':
          'To cancel your subscription, go to your account settings, select "Subscription," and follow the instructions to cancel. You can also contact support for assistance.',
    },
    {
      'question': 'How can I support my team’s gift-giving at work?',
      'answer':
          'SandBox Gifts offers corporate gifting solutions to help your team celebrate special occasions. Contact our support team to learn more about our group plans.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/mystery_video.mp3')
      ..initialize().then((_) {
        setState(() {});
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check for navigation arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args != null) {
      final scrollTo = args['scrollTo'];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollTo == 'about') {
          final aboutContext = _aboutKey.currentContext;
          if (aboutContext != null) {
            final renderBox = aboutContext.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero).dy;
            _scrollToSection(offset);
          }
        } else if (scrollTo == 'faq') {
          final faqContext = _faqKey.currentContext;
          if (faqContext != null) {
            final renderBox = faqContext.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero).dy;
            _scrollToSection(offset);
          }
        }
      });
    }
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToAbout() {
    // Scroll to the About section
    Scrollable.ensureVisible(
      _aboutKey.currentContext!,
      duration: const Duration(milliseconds: 500), // Smooth scrolling
      curve: Curves.easeInOut,
    );
  }

  void scrollToFAQ() {
    // Scroll to the FAQ section
    Scrollable.ensureVisible(
      _faqKey.currentContext!,
      duration: const Duration(milliseconds: 500), // Smooth scrolling
      curve: Curves.easeInOut,
    );
  }

  Widget _buildTrendingList() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final maxContentWidth = 800.0;

    final items = [
      {
        'title': 'Blastoise',
        'image': 'assets/images/Review1.png',
        'review': 'Loved my Product!',
        'rating': 1,
        'starColor': Colors.white,
      },
      {
        'title': 'Risk board',
        'image': 'assets/images/Review2.png',
        'review': 'So excited and it was so fun!',
        'rating': 5,
        'starColor': Colors.yellow,
      },
      {
        'title': 'Crabby Patty',
        'image': 'assets/images/Review3.png',
        'review': 'I was dripping with sweat...',
        'rating': 5,
        'starColor': Colors.cyanAccent,
      },
    ];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Column(
          children:
              items.map((item) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Image.asset(
                                item['image'] as String,
                                width: isMobile ? screenWidth * 0.25 : 150,
                                height: isMobile ? screenWidth * 0.25 : 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 32 : 46,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: isMobile ? 26 : 36,
                                      color:
                                          index < (item['rating'] as int)
                                              ? item['starColor'] as Color
                                              : Colors.white24,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Category • \$\$ • 1.2 miles away',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: isMobile ? 24 : 36,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['review'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 24 : 34,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: Colors.white38),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  // New method to build the FAQ section
  Widget _buildFAQSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    final maxContentWidth = isMobile ? 480.0 : 800.0;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAQ Title
            const Text(
              'Frequently asked questions',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // FAQ List
            ...faqItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> item = entry.value;
              bool isExpanded = _expandedIndex == index;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedIndex = isExpanded ? null : index;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              item['question']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.remove_circle_outline
                              : Icons.add_circle_outline,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        item['answer']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  const Divider(color: Colors.white38),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    print("Current Route: $currentRoute");
    return BaseLayout(
      onScrollToFAQ: scrollToFAQ,
      onScrollToAbout: scrollToAbout,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    // Background Image
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/images/gift_bg.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),

                    // "Who am I?" Button
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width / 2 - 150,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.Purps,
                          foregroundColor: Pallete.primaryCol,
                          fixedSize: Size(
                            300,
                            MediaQuery.of(context).size.height * 0.05,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Who am I?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.35,
                      left: MediaQuery.of(context).size.width / 2 - 100,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null // Disable the button while loading
                                : () async {
                                  setState(() {
                                    isLoading =
                                        true; // Set loading state to true
                                  });

                                  try {
                                    if (mounted) {
                                      Navigator.of(context).pushNamed(
                                        '/startMysteryPage',
                                        arguments: {'product': products[0]},
                                      );
                                    }
                                  } catch (e) {
                                    // Handle errors (e.g., show a snackbar)
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
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
                                        isLoading =
                                            false; // Reset loading state
                                      });
                                    }
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.secondaryCol,
                          foregroundColor: Pallete.Purps,
                          fixedSize: Size(
                            200,
                            MediaQuery.of(context).size.height * 0.1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Unlock Me',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // About Section
                Container(
                  key: _aboutKey,

                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxWidth: 1000),

                  child: Container(
                    // Assign the GlobalKey to the FAQ section
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'At SandBox Gifts, we believe in the joy of giving. Our mission is to help you find the perfect gift for every occasion, '
                          'whether it’s a birthday, anniversary, or just a way to show someone you care. With a curated selection of unique products '
                          'and experiences, we aim to make gift-giving effortless and memorable.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Our team is passionate about discovering the best gifts from around the world and bringing them to your fingertips. '
                          'Thank you for choosing SandBox Gifts as your trusted gifting partner.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                // Trending List
                _buildTrendingList(),
                const SizedBox(height: 20),

                // FAQ Section
                Container(key: _faqKey, child: _buildFAQSection()),
                const SizedBox(height: 20),

                // Footer
                MyFooter(),
              ],
            ),
          ),

          // Loading Indicator
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(
                0.5,
              ), // Semi-transparent background
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
