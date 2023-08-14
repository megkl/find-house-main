import 'package:findhouse/helpers/screen_navigation.dart';
import 'package:findhouse/notifiers/user_notifier.dart';
import 'package:findhouse/screens/home_searcher/profile.dart';
import 'package:findhouse/screens/login_screen.dart';
import 'package:findhouse/widgets/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  const SettingsPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _counter = 0;

  void _incrementCounter() {
    ThemeBuilder.of(this.context).changeTheme();
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserNotifier>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/house.jpg",
            fit: BoxFit.contain,
          ),
          ListView(
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
                      Icons.settings_applications,
                      size: 50,
                      color: Colors.white,
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),

                        child: Text("Theme", style: TextStyle(fontSize: 18,color: Colors.white,),),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                            _incrementCounter();
                        },
                        icon: const Icon(
                          Icons.swap_horizontal_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Row(
                      children: [
                        const Text("About", style: TextStyle(fontSize: 18,color: Colors.white,),),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            current;
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Row(
                      children: [
                        const Text("FAQs", style: TextStyle(fontSize: 18,color: Colors.white,),),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            current;
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Row(
                      children: [
                        const Text("My Profile", style: TextStyle(fontSize: 18,color: Colors.white,),),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => const EditProfilePage())
                                );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                        )                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.blueAccent,
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      userProvider.signOut();
                      changeScreenReplacement(context, const LoginScreen());
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Log Out",
                          style: TextStyle(fontSize: 20,color: Colors.white,),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
