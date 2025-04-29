import 'package:SandBox_Gifts_Backup/presentation/widgets/pallete.dart';
import 'package:SandBox_Gifts_Backup/presentation/widgets/product_card.dart';
import 'package:SandBox_Gifts_Backup/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/global_variables.dart';
import 'package:video_player/video_player.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late String selectedFilter;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player with your video file or URL
    _controller = VideoPlayerController.asset('assets/videos/mystery_video.mp3')
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is initialized
      });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MYSTERY GIFT',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    'UNBOXING',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'TAILORED BY AI',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Pallete.YellowCol,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
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
                  Image.asset(
                    'assets/images/VideoGift.png', // Replace with your image path
                    width: 200, // Set the desired width
                    height: 200, // Set the desired height
                    fit:
                        BoxFit
                            .contain, // Adjust how the image fits within the box
                  ),
                  Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Product Section
            size.width > 1750
                ? GridView.builder(
                  shrinkWrap:
                      true, // Ensures GridView doesn't take infinite height
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor:
                            index.isEven
                                ? Pallete.primaryCol
                                : Pallete.secondaryCol,
                      ),
                    );
                  },
                )
                : ListView.builder(
                  shrinkWrap:
                      true, // Ensures ListView doesn't take infinite height
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor:
                            index.isEven
                                ? Pallete.primaryCol
                                : Pallete.secondaryCol,
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
