
import 'package:flutter/material.dart';

import '../app_config.dart';
import '../helpers/auth_helper.dart';
import '../helpers/shared_value_helper.dart';
import '../screens/about_gfa.dart';
import '../screens/login.dart';
import '../screens/main.dart';
import '../screens/messenger_list.dart';
import '../screens/order_list.dart';
import '../screens/profile.dart';
import '../screens/wallet.dart';
import '../screens/wishlist.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();

    /*
    var logoutResponse = await AuthRepository()
            .getLogoutResponse();


    if(logoutResponse.result == true){
         ToastComponent.showDialog(logoutResponse.message, context,
                   gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
         }
         */
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50, child: Image.asset("assets/gfa.png")),
                is_logged_in.$ == true
                    ? ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${AppConfig.BASE_PATH}${avatar_original.$}",
                          ),
                        ),
                        title: Text(user_name.$,
                            style: const TextStyle(fontSize: 17)),
                        subtitle:
                            user_email.$ != ""
                                ? Text(user_email.$,
                                    style: const TextStyle(fontSize: 15))
                                : Text(user_phone.$,
                                    style: const TextStyle(fontSize: 15)))
                    : const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/square_logo.png",
                          ),
                        ),
                        title: Text('Not logged in',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 14)),
                      ),
                const Divider(),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
                    title: const Text('Home',
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 17)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Main();
                      }));
                    }),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/profile.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Profile',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Profile(show_back_button: true);
                          }));
                        })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/order.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Orders',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const OrderList(from_checkout: false);
                          }));
                        })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/heart.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('My Wishlist',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Wishlist();
                          }));
                        })
                    : Container(),
                (is_logged_in.$ == true)
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/chat.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Messages',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MessengerList();
                          }));
                        })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/wallet.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Wallet',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Wallet();
                          }));
                        })
                    : Container(),
                ListTile(
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: const Icon(Icons.info_outlined,
                        size: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: const Text('About GFA',
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 17)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AboutGFA();
                      }));
                    }),
                const Divider(height: 24),
                is_logged_in.$ == false
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/login.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Login',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/logout.png",
                            height: 16,
                            color: const Color.fromRGBO(153, 153, 153, 1)),
                        title: const Text('Logout',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 17)),
                        onTap: () {
                          onTapLogout(context);
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
