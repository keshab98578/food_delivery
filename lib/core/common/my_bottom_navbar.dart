import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  // final int _selectedIndex = 0;

  // // List of views for each BottomNavigationBarItem
  // final List<Widget> lstBottomScreen = <Widget>[
  //   const HomeView(),
  //   const CourseView(),
  //   const BatchView(),
  //   const Center(child: Text('Profile View', style: TextStyle(fontSize: 24))),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       // Handle back button action, for example, pop the current screen
        //       Navigator.of(context).pop();
        //     },
        //   ),
        //   title: const Text('Dashboard View'),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.refresh),
        //       onPressed: () {
        //         // Add refresh logic here
        //       },
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.swap_horiz),
        //       onPressed: () {
        //         // Add swap logic here
        //       },
        //     ),
        //     Switch(
        //       value: true,
        //       onChanged: (bool newValue) {
        //         // Add switch logic here
        //       },
        //     ),
        //   ],
        // ),
        // body: lstBottomScreen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Course',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Batch',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        )
      ],
      backgroundColor: Colors.green,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      // currentIndex: _selectedIndex,
      // onTap: (index) {
      //   setState(() {
      //     _selectedIndex = index;
      //   });
      // },
    ));
  }
}
