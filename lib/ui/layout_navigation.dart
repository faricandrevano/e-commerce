import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelompok9_toko_online/bloc/cart_bloc/cart_bloc.dart';
import 'package:kelompok9_toko_online/bloc/profile_picture_bloc/profile_picture_bloc.dart';
import 'package:kelompok9_toko_online/bloc/user_bloc/user_bloc.dart';
import 'package:kelompok9_toko_online/bloc/whislist_bloc/whislist_bloc.dart';
import 'package:kelompok9_toko_online/shared/theme.dart';
import 'package:kelompok9_toko_online/ui/pages/cart_page.dart';
import 'package:kelompok9_toko_online/ui/pages/product_list.dart';
import 'package:kelompok9_toko_online/ui/pages/profile_page.dart';
import 'package:kelompok9_toko_online/ui/pages/whislist_page.dart';

class LayoutNavigation extends StatefulWidget {
  const LayoutNavigation({super.key});

  @override
  State<LayoutNavigation> createState() => _LayoutNavigationState();
}

class _LayoutNavigationState extends State<LayoutNavigation> {
  int currentIndex = 0;
  List<Widget> page = [
    const ProductListPage(),
    const WhislistPage(),
    const CartPage(),
    const ProfilePage()
  ];
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserGetProfileEvent());
    context.read<CartBloc>().add(FetchCart());
    context.read<WhislistBloc>().add(FetchWhislist());
    context.read<ProfilePictureBloc>().add(ProfileCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    final countCart = context.watch<CartBloc>().state;
    final countWhislist = context.watch<WhislistBloc>().state;
    return Scaffold(
      backgroundColor: whiteColor,
      body: page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/ic_menu_home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(countWhislist is WhislistUpdateData
                  ? countWhislist.data.length.toString()
                  : '0'),
              child: Image.asset('assets/icon/ic_menu_wishlist.png'),
            ),
            label: 'Whislist',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: countCart is CartUpdateData
                  ? Text(countCart.data.length.toString())
                  : const Text('0'),
              child: Image.asset('assets/icon/ic_menu_pesanan.png'),
            ),
            label: 'Order',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_outlined),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
