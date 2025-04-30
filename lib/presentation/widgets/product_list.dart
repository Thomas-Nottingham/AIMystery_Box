import 'package:SandBox_Gifts_Backup/footer.dart';
import 'package:SandBox_Gifts_Backup/presentation/BaseLayout.dart';
import 'package:SandBox_Gifts_Backup/presentation/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/global_variables.dart';
import 'package:video_player/video_player.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  late String selectedFilter;
  late VideoPlayerController _controller;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool isVideoVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize the video player with your video file or URL
    _controller = VideoPlayerController.asset('assets/videos/mystery_video.mp3')
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is initialized
      });

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Animation duration
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTrendingList() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    final items = [
      {
        'title': 'Blastoise',
        'image': 'assets/images/Review1.png', // replace with your asset
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

    return Column(
      children:
          items.map((item) {
            return Column(
              children: [
                Center(
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width *
                        0.9, // Responsive width (90% of screen width)
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ), // Add padding for better spacing
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Image.asset(
                              item['image'] as String,
                              width:
                                  screenWidth *
                                  0.24, // Slightly larger image for better proportionality
                              height: screenWidth * 0.24,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ), // Increased spacing between image and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 32 : 64,
                                  // Slightly larger font for title
                                ),
                              ),
                              const SizedBox(height: 6), // More spacing
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    size: isMobile ? 26 : 52,
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
                                  fontSize: isMobile ? 24 : 48,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['review'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 24 : 48,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Allow review text to wrap to 2 lines if needed
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ), // More vertical padding for divider
                  child: Divider(color: Colors.white38),
                ),
              ],
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    return BaseLayout(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: Pallete.gradientBackground),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                const SizedBox(height: 20),

                // Gift Image with Play Icon
                GestureDetector(
                  onTap: () {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          isMobile
                              ? 'assets/images/GiftBackground.png'
                              : 'assets/images/gift_background_desktop.png',
                          // Replace with your image path
                          height:
                              isMobile
                                  ? MediaQuery.of(context).size.width * 0.9
                                  : 800,
                          fit:
                              BoxFit
                                  .cover, // Adjust how the image fits within the box
                        ),
                      ),
                      Positioned(
                        top: 20, // Adjust this value to move the button higher
                        child: ElevatedButton(
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.Purps, //
                            foregroundColor: Pallete.primaryCol,
                            fixedSize: const Size(200, 50),
                            // Change the text color
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ), // Optional: Adjust padding
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
                        bottom: 250,
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Trigger the animation
                                  await _animationController.forward();
                                  await _animationController.reverse();

                                  // Navigate to the next page
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        milliseconds: 500,
                                      ), // Duration of the transition
                                      pageBuilder: (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: ProductDetailsPage(
                                            product: products[0],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.secondaryCol,
                                  foregroundColor: Pallete.Purps,
                                  fixedSize: const Size(120, 70),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Text indicating the number of views
                const SizedBox(
                  width: 500, // Set a fixed width to spread out the text
                  child: Text(
                    'Over 200 people have viewed this website today',
                    textAlign: TextAlign.center, // Center-align the text
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Adjust color as needed
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _buildTrendingList(),
                const SizedBox(height: 20),
                MyFooter(),
              ],
              // Replace with valid named arguments or remove the argument if unsupported
            ),
          ),
        ),
      ),
    );
  }
}
