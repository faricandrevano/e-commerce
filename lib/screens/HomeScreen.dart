import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../shared/theme.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: blueColor,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: products[i],
            );
          },
          child: GridTile(
            child: Image.network(products[i].imageUrl, fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(products[i].name, textAlign: TextAlign.center),
            ),
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/ic_menu_home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/ic_menu_bag.png')),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/ic_menu_profile.png')),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icon/ic_menu_wishlist.png')),
            label: 'Wishlist',
          ),
        ],
        selectedItemColor: blueColor,
      ),
    );
  }
}
