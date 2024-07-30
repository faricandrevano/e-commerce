import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/product_bloc/product_bloc.dart';
import 'package:kelompok9_toko_online/ui/pages/search_page.dart';
import 'package:kelompok9_toko_online/ui/widgets/banner_carousel.dart';
import 'package:kelompok9_toko_online/ui/widgets/categories.dart';
import 'package:kelompok9_toko_online/ui/pages/product_detail.dart';
import 'package:kelompok9_toko_online/ui/widgets/product_bar.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        backgroundColor: Colors.blue,
        color: Colors.white,
        displacement: 70,
        onRefresh: () async {
          context.read<ProductBloc>().add(RefreshProduct());
        },
        child: ListView(
          children: [
            const ProductBar(),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            height: 50,
                            width: 250,
                            child: TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Product Name',
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Color(0xFFC4C5C4)),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.search)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const BannerCarousel(),
            Container(
              padding: const EdgeInsets.only(top: 30),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Categories',
                      style: blackColorStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 16,
                        height: 0.10,
                        letterSpacing: 0.06,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'See All',
                    style: blueColorStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                      height: 0.15,
                      letterSpacing: 0.05,
                    ),
                  )
                ],
              ),
            ),
            const Categories(),
            Container(
              height: 500,
              padding: const EdgeInsets.only(top: 19),
              decoration: const BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    margin: const EdgeInsets.only(bottom: 10, top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Featured Product',
                              style: blackColorStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 16,
                                  height: 0.10,
                                  letterSpacing: 0.06)),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text('See All',
                              style: blueColorStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 12,
                                  height: 0.15,
                                  letterSpacing: 0.05)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is ProductLoaded) {
                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailPage(product: product),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            height: 120,
                                            child: Image.network(
                                              product.image,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            product.title,
                                            style: blackColorStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: bold,
                                            ),
                                            maxLines: 4,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Rp. ${product.price}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${product.rating}',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is ProductError) {
                            return Center(child: Text(state.message));
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
