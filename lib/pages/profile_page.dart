import 'package:flutter/material.dart';
import '../shared/theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Profile', style: whiteTextStyle.copyWith(fontWeight: bold)),
        backgroundColor: blueColor,
      ),
      body: Container(
        color: whiteColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/images/profile_picture.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Siti Aisah',
                style: blackColorStyle.copyWith(
                    fontWeight: semibold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'sghhaisah99@gmail.com',
                style: greyColorStyle.copyWith(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: blueColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: whiteTextStyle.copyWith(fontWeight: bold),
                ),
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
