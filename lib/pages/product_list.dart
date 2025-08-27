import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

// --- Data Models (Type-Safe & Efficient) ---

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

class ReviewItem {
  final String title;
  final String image;
  final String review;
  final int rating;
  final Color starColor;

  const ReviewItem({
    required this.title,
    required this.image,
    required this.review,
    required this.rating,
    required this.starColor,
  });
}

// --- Static Data (Moved out of the State class) ---

final List<FaqItem> _faqItems = [
  const FaqItem(
    question: 'How does it work?',
    answer:
        "We will do all the heavy lifting while you enjoy the fun! Our guide (powered with smart AI) will chat with you to understand how much you want to spend and your interests. Then we’ll find the perfect surprise gift tailored just for you. Once we have found your match, you can purchase it seamlessly at the end, we’ll keep you updated and maybe even give you some hints along the way.",
  ),
  const FaqItem(
    question: 'What kind of gifts can I receive?',
    answer:
        "We have access to thousands of different items, from Tech gadgets, to beauty essentials, accessories and more. So whether you love board games, or beauty items, we will find and prioritise high value items to try to provide something you’ll enjoy.",
  ),
  const FaqItem(
    question: 'How much does it cost?',
    answer:
        "The price is up to you! We allow for purchases within the range of £15 to £50, and you can select the amount that works for you. If you choose £15 you or your friend will recieve a gift equaling £10, or if you pick £50 you will recieve something worth £45.",
  ),
  const FaqItem(
    question: 'How long does it take to deliver?',
    answer:
        "Delivery depends on the product provided, as the supplier of the item determines the delivery times. However we aim to get the product to you in at least 7 working days. Although this could be shorter or slightly longer. Any queries contact us at thegiftvaults@gmail.com",
  ),
  const FaqItem(
    question: 'Can I return or exchange my gift?',
    answer:
        'Because each gift is uniquely selected and shipped just for you, we don’t offer returns or exchanges with purchases. But we are here to help, if you have any issues please reach us via the contact page. ',
  ),
  const FaqItem(
    question: 'Can I choose a gift for someone else?',
    answer:
        'Of course! You can select the send as a gift option at the start of the conversation with our guide. This lets you use our service to help you find the surprise for a friend or loved one. PLEASE NOTE: This feature is currently under fixing and may still be unavailable at the time of reading this message',
  ),
  const FaqItem(
    question: 'Is it safe to use?',
    answer:
        'Safety and privacy is a primary concern. We use trusted third-parties to protect your payment information and comply with regulations. You can contact us at any time to view, manage, and remove any of your information.',
  ),
];

final List<ReviewItem> _reviewItems = [
  const ReviewItem(
    title: 'Blastoise',
    image: 'assets/images/Review1.png',
    review: 'Really interesting way to find myself a gift!',
    rating: 5,
    starColor: Colors.white,
  ),
  const ReviewItem(
    title: 'Risk board',
    image: 'assets/images/Review2.png',
    review: 'So excited and it was so fun!',
    rating: 5,
    starColor: Colors.yellow,
  ),
  const ReviewItem(
    title: 'Crabby Patty',
    image: 'assets/images/Review3.png',
    review: 'I was dripping with sweat...',
    rating: 5,
    starColor: Colors.cyanAccent,
  ),
];

// --- Main Page Widget ---

class ProductList extends StatefulWidget {
  final String? scrollTo;
  const ProductList({super.key, this.scrollTo, this.onScrollToAbout});
  final VoidCallback? onScrollToAbout;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isLoading = false;
  late final VideoPlayerController _videoController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        'assets/videos/mystery_video.mp4',
      )
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Scroll to section after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToInitialSection(),
    );
  }

  void _scrollToInitialSection() {
    final key =
        widget.scrollTo == 'faq'
            ? _faqKey
            : (widget.scrollTo == 'about' ? _aboutKey : null);
    if (key != null) {
      _scrollToSection(key: key);
    }
  }

  void _onUnlockMePressed() async {
    setState(() => isLoading = true);
    try {
      if (mounted) context.push('/startMysteryPage');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to perform action: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _onUnlockMePressed2() async {
    setState(() => isLoading = true);
    try {
      if (mounted) context.push('/startMysteryPage2');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to perform action: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _scrollToSection({required GlobalKey key}) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      onScrollToFAQ: () => _scrollToSection(key: _faqKey),
      onScrollToAbout: () => _scrollToSection(key: _aboutKey),
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  videoController: _videoController,
                  onUnlockMePressed: _onUnlockMePressed,
                  onUnlockMePressed2: _onUnlockMePressed2,
                  scrollToAbout: () => _scrollToSection(key: _aboutKey),
                ),
                const SizedBox(height: 10),
                AboutSection(key: _aboutKey),
                Explanation(),
                const SizedBox(height: 30),
                //ReviewsSection(),
                FaqSection(key: _faqKey),
                const SizedBox(height: 20),
                const MyFooter(),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
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

// --- Smaller, Broken-Down Widgets for Performance ---

class HeroSection extends StatelessWidget {
  final VideoPlayerController videoController;
  final VoidCallback onUnlockMePressed;
  final VoidCallback onUnlockMePressed2;
  final VoidCallback scrollToAbout;

  const HeroSection({
    super.key,
    required this.videoController,
    required this.onUnlockMePressed,
    required this.onUnlockMePressed2,
    required this.scrollToAbout,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Image.asset('assets/images/bg_image.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: screenSize.height * 0.04,
          child: const Text(
            'The place to discover mystery gifts for \n oneself or another!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 208, 207, 209),
            ),
          ),
        ),

        Positioned(
          top: screenSize.height * 0.13,
          child: ElevatedButton(
            onPressed: () {
              scrollToAbout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.Purps,
              foregroundColor: const Color.fromARGB(255, 208, 207, 209),
              fixedSize: Size(300, screenSize.height * 0.05),
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'What is the Gift Vaults?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        Positioned(
          bottom: screenSize.height * 0.18,
          // Let the Row handle horizontal alignment by giving it the full width
          left: 0,
          right: 0,
          child: Row(
            // Center the buttons horizontally
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Button: "Gift for friend"
              ElevatedButton(
                onPressed: onUnlockMePressed2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.secondaryCol,
                  foregroundColor: const Color.fromARGB(255, 208, 207, 209),
                  // Consider using padding instead of fixedSize for more flexibility
                  fixedSize: Size(
                    150,
                    screenSize.height * 0.08,
                  ), // Adjusted size a bit
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Gift for friend',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              // The gap between the buttons
              const SizedBox(width: 20),
              // Second Button: "Gift for me"
              ElevatedButton(
                onPressed: onUnlockMePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.secondaryCol,
                  foregroundColor: Color.fromARGB(255, 208, 207, 209),
                  fixedSize: Size(
                    150,
                    screenSize.height * 0.08,
                  ), // Adjusted size a bit
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Gift for me',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Explanation extends StatelessWidget {
  const Explanation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      constraints: const BoxConstraints(maxWidth: 1000),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 0, 32),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 3, 0, 32),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            'Who we are',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            """We are Tom and Joz, two friends  and co-founders, trying to discover the next phase of online shopping while bringing surprise and delight back into everyday life. \n We’re a small team creating new and interesting things! \n If you’ve got a question, need help or have any ideas, we’d love it if you reached out!""",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      constraints: const BoxConstraints(maxWidth: 1000),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 0, 32),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 3, 0, 32),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            'A Thoughtful and Personal Gift, With a Twist of Surprise!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            """At The Gift Vaults, we know that a gift is more than just a product. \n It’s the build-up. The curiosity. The thrill of not knowing, and the moment of surprise when it arrives. \n So why wait for someone else to gift you something when you can gift yourself? \n Here, the magic starts with a short chat. \n Tell us a little about who you are, your interests, your vibe, and we’ll pick out a surprise gift we think you’ll love. \n Every gift is matched to you. \n If you're into the idea, all you have to do is say yes. We'll take care of the rest while you sit back and enjoy the anticipation. \n We might even drop you a hint or two before it shows up…""",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final maxContentWidth = 800.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: ListView.separated(
          itemCount: _reviewItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder:
              (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: Colors.white38),
              ),
          itemBuilder: (context, index) {
            final item = _reviewItems[index];
            return ReviewListItem(
              item: item,
              isMobile: isMobile,
              screenWidth: screenWidth,
            );
          },
        ),
      ),
    );
  }
}

class ReviewListItem extends StatelessWidget {
  final ReviewItem item;
  final bool isMobile;
  final double screenWidth;

  const ReviewListItem({
    super.key,
    required this.item,
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Image.asset(
                item.image,
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
                  item.title,
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
                          index < item.rating ? item.starColor : Colors.white24,
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
                  item.review,
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
    );
  }
}

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;
    final maxContentWidth = isMobile ? 480.0 : 800.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _faqItems.length + 1, // Add 1 for the title
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Frequently asked questions',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            }
            final item = _faqItems[index - 1];
            return FaqListItem(item: item);
          },
        ),
      ),
    );
  }
}

class FaqListItem extends StatefulWidget {
  final FaqItem item;
  const FaqListItem({super.key, required this.item});

  @override
  State<FaqListItem> createState() => _FaqListItemState();
}

class _FaqListItemState extends State<FaqListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.item.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.remove_circle_outline
                      : Icons.add_circle_outline,
                  color: Colors.white70,
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(), // Empty container when collapsed
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              widget.item.answer,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ),
          crossFadeState:
              _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        const Divider(color: Colors.white38),
      ],
    );
  }
}
