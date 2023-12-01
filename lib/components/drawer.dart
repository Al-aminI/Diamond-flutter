import 'dart:io';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:diamond/components/my_list_tile.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:diamond/pages/HomePage.dart';

class MyDrawer extends StatefulWidget {
  final String referralCode;
  final String image;
  final void Function()? onHomeTap;
  final void Function()? onLogoutTap;
  final void Function()? onProfileTap;
  final void Function()? onAboutUsTap;
  final void Function()? onTeamTap;

  const MyDrawer(
      {super.key,
      required this.referralCode,
      required this.image,
      required this.onHomeTap,
      required this.onLogoutTap,
      required this.onProfileTap,
      required this.onAboutUsTap,
      required this.onTeamTap});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  XFile? image;
  //final String referralCode = referralCode;

  void onShareTap() {
    const textToShare = 'Diamond Miner App.';
    //print(textToShare);
    Share.share(textToShare);
  }

  // Function to display the dialog
  void showTextDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Referral Code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.referralCode),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    // Copy the referral code to the clipboard
                    Clipboard.setData(ClipboardData(text: widget.referralCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied to Clipboard'),
                        dismissDirection: DismissDirection.up,
                      ),
                    );
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 51, 1, 73),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // heder
          Column(
            children: [
              DrawerHeader(
                  child: Column(children: [
                if (image != null)
                  Image.file(
                    File(image!.path),
                    width: 120,
                    height: 120,
                  )
                else
                  const Icon(
                    Icons.image,
                    size: 120,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
              ])),
              MyListTile(
                  icon: Icons.home, text: "H O M E", onTap: widget.onHomeTap),
              MyListTile(
                  icon: Icons.person,
                  text: "P R O F I L E",
                  onTap: widget.onProfileTap),
              MyListTile(
                  icon: Icons.people, text: "T E A M", onTap: widget.onTeamTap),
              MyListTile(
                  icon: Icons.share, text: "S H A R E", onTap: onShareTap),
              MyListTile(
                  icon: Icons.code,
                  text: "R E F E R R A L  C O D E",
                  onTap: () {
                    showTextDialog(context);
                  }),
              /*  MyListTile(icon: Icons.create, text: "N E W", onTap: onHomeTap),
              MyListTile(
                  icon: Icons.add_ic_call,
                  text: "C O N T A C T U S",
                  onTap: () => Navigator.pop(context)),*/
              MyListTile(
                  icon: Icons.business_center,
                  text: "A B O U T  U S",
                  onTap: widget.onAboutUsTap),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
                icon: Icons.logout,
                text: "L O G O U T",
                onTap: widget.onLogoutTap),
          ),
        ],
      ),
    );
  }
}
