import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/models/cart_model.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/pages/whislist_detail_page.dart';
import 'package:kelompok9_toko_online/ui/widgets/toast_message.dart';
import 'package:toastification/toastification.dart';

class WhislistPage extends StatelessWidget {
  const WhislistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: BlocBuilder<WhislistBloc, WhislistState>(
        builder: (context, state) {
          if (state.WhislistItems.isEmpty) {
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
                    'No Whislist',
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
            final List<CartModel> data = state.WhislistItems;
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rp.${data[index].price.toString()}'),
                              const SizedBox(height: 3),
                              GestureDetector(
                                onTap: () {
                                  final detailProduct = data[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WhislistDetailPage(
                                        product: detailProduct,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View Detail",
                                  style: blueColorStyle,
                                ),
                              )
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure remove this product?'),
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
                                          context.read<WhislistBloc>().add(
                                                RemoreWhislist(
                                                  state.WhislistItems[index],
                                                ),
                                              );
                                          ToastMessage(
                                                  context: context,
                                                  message: 'Success Remove',
                                                  type: ToastificationType
                                                      .success)
                                              .toastCustom();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
