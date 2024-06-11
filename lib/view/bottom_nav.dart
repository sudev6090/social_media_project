import 'package:flutter/material.dart';
import 'package:social_media/view/create_post.dart';
import 'package:social_media/view/follow_page.dart';
import 'package:social_media/view/profilepage.dart';
import 'package:social_media/view/homepage.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  List<Widget> pages = [
    const HomePage(),
    const PostPage(),
    const FollowPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey.withOpacity(0.8),
          backgroundColor: Color.fromARGB(255, 79, 19, 19),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                label: 'home',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'post', icon: Icon(Icons.add)),
            BottomNavigationBarItem(
                label: 'Add', icon: Icon(Icons.person_add_alt_1)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          ]),
    );
  }
}
