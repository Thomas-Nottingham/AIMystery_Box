// final size = MediaQuery.of(context).size;

//  size.width > 1750
//                     ? GridView.builder(
//                       shrinkWrap:
//                           true, // Ensures GridView doesn't take infinite height
//                       physics:
//                           const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
//                       itemCount: products.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 2,
//                           ),
//                       itemBuilder: (context, index) {
//                         final product = products[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return ProductDetailsPage(product: product);
//                                 },
//                               ),
//                             );
//                           },
//                           child: ProductCard(
//                             title: product['title'] as String,
//                             price: product['price'] as double,
//                             image: product['imageUrl'] as String,
//                             backgroundColor:
//                                 index.isEven
//                                     ? Pallete.primaryCol
//                                     : Pallete.secondaryCol,
//                           ),
//                         );
//                       },
//                     )
//                     : ListView.builder(
//                       shrinkWrap:
//                           true, // Ensures ListView doesn't take infinite height
//                       physics:
//                           const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return ProductDetailsPage(product: product);
//                                 },
//                               ),
//                             );
//                           },
//                           child: ProductCard(
//                             title: product['title'] as String,
//                             price: product['price'] as double,
//                             image: product['imageUrl'] as String,
//                             backgroundColor:
//                                 index.isEven
//                                     ? Pallete.primaryCol
//                                     : Pallete.secondaryCol,
//                           ),
//                         );
//                       },
//                     ),
//               ],
