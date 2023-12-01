import 'package:diamond/pages/aboutus.dart';
import 'package:diamond/pages/payinfo.dart';
import 'package:diamond/pages/profile.dart';
import 'package:diamond/pages/team.dart';
import 'package:diamond/pages/withdraw.dart';
import 'package:flutter/material.dart';
//import 'package:diamond/pages/profile.dart';

class MyProfileCard extends StatefulWidget {
  //final Function()? onTap;
  final String userId;

  const MyProfileCard({super.key, required this.userId});
  @override
  State<MyProfileCard> createState() => _MyProfileCardState();
}

class _MyProfileCardState extends State<MyProfileCard> {
  //required this.onTap, required this.text});

  void goToTeamPage() {
    //pop menu drawer
    // Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TeamPage(
                  userId: widget.userId,
                )));
  }

  void goToProfilePage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(
                  userId: widget.userId,
                )));
  }

  void goToAboutUsPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutUsPage()));
  }

  void goToWithdrawalPage() {
    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WithdrawalPage(userId: widget.userId)));
  }

  void goToHistoryPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HistoryPage(
                  userId: widget.userId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: goToTeamPage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.people,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Team",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: goToProfilePage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: goToHistoryPage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Payment Hystory",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: goToWithdrawalPage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.wallet_giftcard,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Withdraw",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.star,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Rate Us",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: goToAboutUsPage,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 162, 162),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 115,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.business_center,
                              size: 60,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "About Us",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
