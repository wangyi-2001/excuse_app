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
  List<String> pageTitles = [];
  List<Widget> pageChildren = [];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    pageTitles = ["事件", "我的"];
    pageChildren = [
      const EventPage(),
      const MinePage(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[currentIndex]),
        // 导航栏标题剧中
        centerTitle: true,
        elevation: 1,
      ),
      body: pageChildren[currentIndex],
      bottomNavigationBar: BottomAppBar(
        // 中间悬浮按钮嵌入BottomAppBar
        shape: const CircularNotchedRectangle(),
        // 缺口边距
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.event),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
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
                  child: Container(
                    width: mWidth,
                    height: mHeight * 0.6,
                    child: const CreateEvent(),
                  ),
                );
              });
          // Navigator.of(context).pushNamed("/createEvent");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, //放在中间
    );
  }
}
