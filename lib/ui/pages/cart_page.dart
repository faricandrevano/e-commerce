import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/cart_bloc/cart_bloc.dart';
import 'package:kelompok9_toko_online/models/product_model.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/widgets/custom_filled_button.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/images/empty_cart.png',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'No Product',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff939090),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Go find the products you like.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: medium,
                      color: const Color(0xff939090),
                    ),
                  ),
                ],
              ),
            );
          } else {
            final List<Product> data = state.cartItems;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(data[index].title),
                          leading: Image.network(
                            data[index].image,
                            width: 50,
                          ),
                          subtitle: Text('Rp.${data[index].price.toString()}'),
                          trailing: GestureDetector(
                            onTap: () {
                              context.read<CartBloc>().add(
                                    RemoveCart(
                                      state.cartItems[index],
                                    ),
                                  );
                              ToastMessage(
                                context: context,
                                message: 'Success Empty Cart',
                                type: ToastificationType.success,
                              ).toastCustom();
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                CustomFilledButton(
                  onPressed: () {
                    context.read<CartBloc>().add(EmptyCart());
                    ToastMessage(
                      context: context,
                      message: 'Success Empty Cart',
                      type: ToastificationType.success,
                    ).toastCustom();
                  },
                  text: Text(
                    'Procced to checkout',
                    style: whiteTextStyle,
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
