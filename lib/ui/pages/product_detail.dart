import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/cart_bloc/cart_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/models/product_model.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Product',
          style: blackColorStyle,
        ),
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: navyColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Aksi ketika tombol share ditekan
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: blackColorStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toString(),
                    style: blackColorStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Category: ${product.category}',
                style:
                    blackColorStyle.copyWith(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp. ${product.price}',
                style: blackColorStyle.copyWith(
                    fontSize: 24, fontWeight: bold, color: Colors.red),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: blackColorStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.50,
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 25,
                                left: 25,
                                bottom: 25,
                                top: 25,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Add to Favorite',
                                        style: blackColorStyle.copyWith(
                                          fontWeight: bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: blueColor,
                                      ),
                                      onPressed: () {
                                        final whilistbloc =
                                            context.read<WhislistBloc>();
                                        final whilistItems =
                                            whilistbloc.state.WhislistItems;
                                        if (whilistItems.any(
                                            (item) => item.id == product.id)) {
                                          ToastMessage(
                                            context: context,
                                            type: ToastificationType.info,
                                            message: 'Product Already Exist',
                                          ).toastCustom();
                                        } else {
                                          final whilistbloc =
                                              context.read<WhislistBloc>();
                                          whilistbloc
                                              .add(AddToWhislist(product));
                                          ToastMessage(
                                                  context: context,
                                                  message:
                                                      'Success Add To Whislist',
                                                  type: ToastificationType
                                                      .success)
                                              .toastCustom();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Add to Favorite',
                                        style: whiteTextStyle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.favorite, color: whiteColor),
                    label: Text('Added', style: whiteTextStyle),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.65,
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 25,
                                left: 25,
                                bottom: 25,
                                top: 25,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Add to Cart',
                                        style: blackColorStyle.copyWith(
                                          fontWeight: bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: const Icon(
                                          Icons.close,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(height: 20),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Total Belanja',
                                    style: blackColorStyle.copyWith(
                                      fontWeight: medium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Rp. ${product.price.toString()}',
                                    style: blackColorStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: blueColor,
                                      ),
                                      onPressed: () {
                                        final cartbloc =
                                            context.read<CartBloc>();
                                        final cartItem =
                                            cartbloc.state.cartItems;
                                        if (cartItem.any(
                                            (item) => item.id == product.id)) {
                                          ToastMessage(
                                            context: context,
                                            type: ToastificationType.info,
                                            message: 'Product Already Exist',
                                          ).toastCustom();
                                        } else {
                                          final cartbloc =
                                              context.read<CartBloc>();
                                          cartbloc.add(AddToCart(product));
                                          ToastMessage(
                                                  context: context,
                                                  message:
                                                      'Success Add To cart',
                                                  type: ToastificationType
                                                      .success)
                                              .toastCustom();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Add to card',
                                        style: whiteTextStyle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Add to Cart', style: whiteTextStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
