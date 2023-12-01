// ignore: file_names
import 'dart:convert';

import 'package:diamond/components/card.dart';
import 'package:diamond/components/profilecard.dart';
import 'package:diamond/components/stake.dart';
import 'package:diamond/components/tasks.dart';
import 'package:diamond/modules/diamond_provider.dart';
//import 'package:diamond/modules/api_service.dart';
import 'package:diamond/modules/user_data_provider.dart';
import 'package:diamond/pages/aboutus.dart';
import 'package:diamond/pages/chat.dart';
import 'package:diamond/pages/notifs.dart';
import 'package:diamond/pages/profile.dart';
import 'package:diamond/pages/stake_history.dart';
import 'package:diamond/pages/team.dart';
import 'package:diamond/pages/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:diamond/auth/login_or_register.dart';
import 'package:diamond/components/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:diamond/pages/login_page.dart';
import 'dart:async';

import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({
    super.key,
    required this.userId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void addDiamond(diaAmount, userId, diaIndex) async {
    //print(emailController.text);
    final Map<String, dynamic> requestData = {
      'amount': diaAmount,
      'user_id': userId,
      'dia': diaIndex
    };
    final url = Uri.parse('http://127.0.0.1:5000/add_diamond');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode(requestData), // Encode your data as JSON
    );
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // Request was successful, you can handle the response here.
      //print('Response: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);

      // Access specific values from the JSON data
      String message = data['message'];

      if (message == "success") {
        final Map<String, dynamic> requestData = {'user_id': widget.userId};
        final url = Uri.parse('http://127.0.0.1:5000/get_diamonds');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(requestData), // Encode your data as JSON
        );

        if (response.statusCode == 200) {
          final responseBody = response.body;
          //print(jsonDecode(responseBody)['me']);
          try {
            final output = jsonDecode(responseBody);
            final diamondProvider =
                Provider.of<DiamondDataProvider>(context, listen: false);
            diamondProvider.diamondData?.amount = output["amount"];
          } catch (e) {
            print("Error decoding JSON: $e");
            // Handle the error or display an error message
          }
        } else {
          print("Request failed with status: ${response.statusCode}");
          // Handle the error or display an error message based on the status code
        }
      }
    }
  }

  double positionY1 = 0;
  double size1 = 50;
  double opacity1 = 1;

  void animateImage1() {
    addDiamond("2", widget.userId, "1");
    setState(() {
      positionY1 = -100; // Jump up
      size1 = 100; // Increase size
      opacity1 = 0;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        positionY1 = 0; // Reset position
        size1 = 50; // Reset size
        opacity1 = 1; // Reset opacity
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.dia1 = true;
        //widget.dia1 = true;
      });
    });
  }

  /////////////////////////////////////////////////////////////////

  //bool widget.dia2 = true;
  double positionY2 = 0;
  double size2 = 50;
  double opacity2 = 1;

  void animateImage2() {
    addDiamond("2", widget.userId, "2");
    setState(() {
      positionY2 = -100; // Jump up
      size2 = 100; // Increase size
      opacity2 = 0;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        positionY2 = 0; // Reset position
        size2 = 50; // Reset size
        opacity2 = 1; // Reset opacity
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.dia2 = true;
      });
    });
  }

  /////////////////////////////////////////////////////////////////

  //bool widget.dia3 = true;
  double positionY3 = 0;
  double size3 = 50;
  double opacity3 = 1;

  void animateImage3() {
    addDiamond("2", widget.userId, "3");
    setState(() {
      positionY3 = -100; // Jump up
      size3 = 100; // Increase size
      opacity3 = 0;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        positionY3 = 0; // Reset position
        size3 = 50; // Reset size
        opacity3 = 1; // Reset opacity
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.dia3 = true;
      });
    });
  }

  /////////////////////////////////////////////////////////////////
  //bool widget.dia4 = false;
  double positionY4 = 0;
  double size4 = 50;
  double opacity4 = 1;

  void animateImage4() {
    addDiamond("2", widget.userId, "4");
    setState(() {
      positionY4 = -100; // Jump up
      size4 = 100; // Increase size
      opacity4 = 0;
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        positionY4 = 0; // Reset position
        size4 = 50; // Reset size
        opacity4 = 1; // Reset opacity
        final diamondProvider =
            Provider.of<DiamondDataProvider>(context, listen: false);
        diamondProvider.diamondData?.dia4 = true;
      });
    });
  }

  /////////////////////////////////////////////////////////////////

  // Bottom navber Tabs
  int _selectedIndex = 0;

  /*final List<Widget> _pages = [
    const Center(child: Text('Page 1')),
    const Center(child: Text('Page 2')),
    const Center(child: Text('Page 3')),
  ];*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void goToHomePage() {
    //pop menu drawer
    Navigator.pop(context);
  }

  void goToLoginPage() {
    //pop menu drawer
    Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginOrRegister(
                  showLoginPage: true,
                )));
  }

  void goToProfilePage() {
    //pop menu drawer
    // Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage(userId: widget.userId)));
  }

  void goToAboutUsPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutUsPage()));
  }

  void goToChatPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(userId: widget.userId)));
  }

  void goToTeamPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TeamPage(userId: widget.userId)));
  }

  void goToWithdrawPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WithdrawalPage(
                  userId: widget.userId,
                )));
  }

  void goToStakeHistoryPage() {
    //pop menu drawer
    //Navigator.pop(context);

    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StakeHistoryPage(
                  userId: widget.userId,
                )));
  }

  // notification page method
  // sing user in method
  void notif() {
    // then go to EventsPage
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotifPage(
                  userId: widget.userId,
                )));
  }

  void onShareTap() {
    const textToShare = 'Diamond Miner App.';
    //print(textToShare);
    Share.share(textToShare);
  }

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/6300978111";

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print(error);
      }),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context);

    //final diaProvider = Provider.of<DiamondDataProvider>(context);
    //print('${userProvider.userData?.referralCode}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 0, 80),
        title: const Text("DIAMOND MINE"),
        actions: [
          IconButton(
            icon: const Icon(Icons
                .notifications), // Replace 'your_icon' with the desired icon, e.g., Icons.search
            onPressed: notif,
          ),
        ],
      ),
      drawer: MyDrawer(
        referralCode: '${userProvider.userData?.referralCode}',
        image: '${userProvider.userData?.image}',
        onHomeTap: goToHomePage,
        onLogoutTap: goToLoginPage,
        onProfileTap: goToProfilePage,
        onAboutUsTap: goToAboutUsPage,
        onTeamTap: goToTeamPage,
      ),
      backgroundColor: const Color.fromARGB(255, 254, 247, 255),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 254, 247, 255),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.diamond, color: Colors.grey), label: 'Stake'),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_rounded, color: Colors.grey),
            label: 'Daily Reward',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: Colors.grey),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return SingleChildScrollView(
            child: Center(child: StakingPage(userId: widget.userId)));
      case 2:
        return Center(
            child: MyTasks(
          userId: widget.userId,
        ));
      case 3:
        return Center(child: MyProfileCard(userId: widget.userId));
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    final userProvider = Provider.of<UserDataProvider>(context);
    final diaProvider = Provider.of<DiamondDataProvider>(context);
    String? amount = diaProvider.diamondData
        ?.amount; // Use a default value if diaProvider.diamondData?.amount is null
    double result = double.parse(amount ?? '0.0') * 0.0246;
    return SafeArea(
        child: SingleChildScrollView(
            child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),

        // logo
        /*const Icon(
        Icons.diamond_outlined,
        size: 120,
      ),*/
        Center(
          child: userProvider.userData != null
              ? Text('Welcome ${userProvider.userData?.username}!!!')
              : const CircularProgressIndicator(),
        ),

        Image.asset(
          'images/l1.png', // Replace with the actual path to your image asset.
          width: 120, // Set the desired width.
          height: 120, // Set the desired height.
        ),

        const SizedBox(
          height: 10,
        ),
        Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content horizontally.
            children: [
              GestureDetector(
                  onTap: () {
                    animateImage1();
                  },
                  child: Visibility(
                    visible: diaProvider.diamondData!.dia1,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, positionY1, 0),
                      width: size1,
                      height: size1,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('images/l1.png'),
                          //fit: BoxFit.cover,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          positionY1 = 0; // Reset position
                          size1 = 50; // Reset size
                          opacity1 = 1; // Reset opacity
                          final diamondProvider =
                              Provider.of<DiamondDataProvider>(context,
                                  listen: false);
                          diamondProvider.diamondData?.dia1 = false;
                        });
                      },
                    ),
                  )),
              const SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    animateImage2();
                  },
                  child: Visibility(
                    visible: diaProvider.diamondData!.dia2,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, positionY2, 0),
                      width: size2,
                      height: size2,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('images/l1.png'),
                          //fit: BoxFit.cover,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          positionY2 = 0; // Reset position
                          size2 = 50; // Reset size
                          opacity2 = 1; // Reset opacity
                          final diamondProvider =
                              Provider.of<DiamondDataProvider>(context,
                                  listen: false);
                          diamondProvider.diamondData?.dia2 = false;
                        });
                      },
                    ),
                  )),
              const SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    animateImage3();
                  },
                  child: Visibility(
                    visible: diaProvider.diamondData!.dia3,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, positionY3, 0),
                      width: size3,
                      height: size3,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('images/l1.png'),
                          //fit: BoxFit.cover,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          positionY3 = 0; // Reset position
                          size3 = 50; // Reset size
                          opacity3 = 1; // Reset opacity
                          final diamondProvider =
                              Provider.of<DiamondDataProvider>(context,
                                  listen: false);
                          diamondProvider.diamondData?.dia3 = false;
                        });
                      },
                    ),
                  )),
              const SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    animateImage4();
                  },
                  child: Visibility(
                    visible: diaProvider.diamondData!.dia4,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      transform: Matrix4.translationValues(0, positionY4, 0),
                      width: size4,
                      height: size4,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('images/l1.png'),
                          //fit: BoxFit.cover,
                        ),
                      ),
                      onEnd: () {
                        setState(() {
                          positionY4 = 0; // Reset position
                          size4 = 50; // Reset size
                          opacity4 = 1; // Reset opacity
                          final diamondProvider =
                              Provider.of<DiamondDataProvider>(context,
                                  listen: false);
                          diamondProvider.diamondData?.dia4 = false;
                        });
                      },
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // welcome back
        const Text(
          'Diamond Balance',
          style: TextStyle(
              color: Color.fromARGB(255, 52, 44, 55),
              fontWeight: FontWeight.normal,
              fontSize: 16,
              fontFamily: 'Raleway'),
        ),

        const SizedBox(height: 15),

        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${diaProvider.diamondData?.amount}',
                //'1.0',
                style: const TextStyle(
                    color: Color.fromARGB(255, 55, 44, 44),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.currency_exchange_rounded,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${(result)}',
                //'0.0265',
                style: const TextStyle(
                    color: Color.fromARGB(255, 55, 44, 44),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Raleway'),
              ),
            ],
          ),
        ),

        /*const SizedBox(height: 5),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'mine and widthrow instantly!!!',
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),*/

        const SizedBox(height: 25),
        /*MyTextField(
                  controller: eventnameController,
                  hintText: "type the new event name here",
                  obsecureText: false),
              const SizedBox(height: 25),*/
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: MyCard(
                            onTap: goToStakeHistoryPage,
                            text: "STAKE HISTORY")),
                    const SizedBox(width: 3),
                    Center(
                        child: MyCard(
                            onTap: goToWithdrawPage, text: "WITHDRAWAL")),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child:
                          MyCard(onTap: goToTeamPage, text: "OLINE TEAM:  0"),
                    ),
                    //const SizedBox(width: 3),
                    Center(child: MyCard(onTap: onShareTap, text: "REFERREL")),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // logo
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: goToChatPage,
                        child: const Icon(
                          Icons.contact_support_outlined,
                          size: 55,
                          color: Color.fromARGB(255, 52, 44, 55),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        // MyEventButton(onTap: newEvent, text: "Proceed")
        const SizedBox(
          height: 10,
        ),
        isAdLoaded
            ? SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd),
              )
            : const SizedBox()
      ],
    ))));
  }
}
