import 'package:SandBox_Gifts_Backup/widgets/product_card.dart';
import 'package:SandBox_Gifts_Backup/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:SandBox_Gifts_Backup/global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Standard',
    'Deluexe',
    'Supreme',
    'Legendary',
  ];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF00FF9C)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sandbox\nGifts',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                ),
              ),
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white54),

                    prefixIcon: Icon(Icons.search, color: Color(0xFF00FF9C)),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    filled: true,
                    fillColor: Color(0xFF1A1A1A)
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: isSelected ?
                      const Color(0xFF00FF9C)
                      : const Color(0xFF1E1E1E),
                           side: BorderSide(
                      color: isSelected ? Color(0xFFA100FF) : Color(0xFF00FF9C),
                    ),
                      label: Text(filter ,style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child:
                size.width > 1750
                    ? GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    ? const Color(0xFF111111)
                                    : const Color(0xFF1A1A1A),
                          ),
                        );
                      },
                    )
                    : ListView.builder(
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
                                    ? const Color(0xFF111111)
                                    : const Color(0xFF1A1A1A),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
