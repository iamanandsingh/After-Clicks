import 'package:flutter/material.dart';

import 'PredefinedPage.dart';
import 'SquarePage.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  bool isGallery = true;
  int index = 1;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  IndexedStack(
                    index: index,
                    children: [
                      SquarePage(isGallery: isGallery),
                      PredefinedPage(isGallery: isGallery),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildBottomBar(),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Theme.of(context).accentColor);

    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Text('Cropper', style: TextStyle(color: Colors.white)),
          label: 'Square',
        ),
        BottomNavigationBarItem(
          icon: Text('Cropper', style: style),
          label: 'Predefined',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }
}
