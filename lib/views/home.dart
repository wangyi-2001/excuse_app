import 'package:excuse_demo/views/event/event_create.dart';
import 'package:excuse_demo/views/event/event_list.dart';
import 'package:excuse_demo/views/mine/mine.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  // var currentPage;

  List<String> pageTitles = ["事件大厅", "我"];
  List<Widget> pageChildren = [];

  @override
  void initState() {
    super.initState();

    pageChildren = [
      const EventPage(),
      const MinePage(),
    ];

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(pageTitles[currentIndex]),
        // 导航栏标题剧中
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      // body: pageChildren[currentIndex],
      body:
      // pageChildren[currentIndex],
      IndexedStack(
        index: currentIndex,
        children: pageChildren,
      ),
      bottomNavigationBar: BottomAppBar(
        // 中间悬浮按钮嵌入BottomAppBar
        shape: const CircularNotchedRectangle(),
        // 缺口边距
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: const Icon(Icons.event),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        // 阴影
        elevation: 10.0,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              clipBehavior: Clip.antiAlias,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              builder: (builder) {
                double mWidth = MediaQuery.of(context).size.width;
                double mHeight = MediaQuery.of(context).size.height;
                return AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  child: SizedBox(
                    width: mWidth,
                    height: mHeight * 0.6,
                    child: const CreateEvent(),
                  ),
                );
              });
          // Navigator.of(context).pushNamed("/createEvent");
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, //放在中间
    );
  }
}
