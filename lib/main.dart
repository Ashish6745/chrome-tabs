import 'package:flutter/material.dart';

void main() {
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabs = [
    const Center(child: Text('Home')),
    const Center(child: Text('Explore')),
    const Center(child: Icon(Icons.add)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addTab(int index) {
    if (_tabs.length < 13) {
      setState(() {
        _tabs.insert(index, Center(child: Text('New Tab ${_tabs.length}')));
        _tabController = TabController(length: _tabs.length, vsync: this);
      });
      Future.delayed(Duration.zero, () {
        _tabController.animateTo(index);
      });
    } else {
      print('Tab limit reached (12 tabs)');
    }
  }

  void _removeTab(int index) {
    setState(() {
      _tabs.removeAt(index);
      _tabController = TabController(length: _tabs.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade800,
          title: const Text('Tabs'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs.map((tab) => Tab(child: tab)).toList(),
            onTap: (index) {
              if (index == _tabs.length - 1) {
                _addTab(index);
              } else {
                _tabController.animateTo(index);
              }
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) {
            return Stack(
              children: [
                tab,
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _removeTab(_tabs.indexOf(tab));
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
