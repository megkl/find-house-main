import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserNotifier>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/house.jpg",
            fit: BoxFit.cover,
            width: 500,
            height: 400,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20.0, bottom: 10),
                        child: Container(
                            alignment: Alignment.center,
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.circular(200.0),
                              color: Colors.blueAccent,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Text(
                        userProvider.users!.name ?? "",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text(
                        userProvider.users!.phoneNo ?? "",
                        style: const TextStyle(fontSize: 18,color: Colors.black,),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text(
                        userProvider.users!.email ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                            color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Thank you for trusting us to deliver your dream home ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Icon(
                        Icons.stars,
                        size: 50,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
