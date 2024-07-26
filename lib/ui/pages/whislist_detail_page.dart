import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/models/cart_model.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class WhislistDetailPage extends StatelessWidget {
  const WhislistDetailPage({super.key, required this.product});

  final CartModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Detail Product Whislist',
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:
                              const Text('Are you sure remove this product?'),
                          // content: const Text('Yakin?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<WhislistBloc>()
                                    .add(RemoreWhislist(product));
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home',
                                  (route) => false,
                                );
                                ToastMessage(
                                  context: context,
                                  message: 'Success Remove Whislist',
                                  type: ToastificationType.success,
                                ).toastCustom();
                              },
                              child: const Text('Yes'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: whiteTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.delete, color: whiteColor),
                  label: Text('Remove Whislist', style: whiteTextStyle),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
