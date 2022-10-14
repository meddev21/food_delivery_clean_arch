import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../index_pages.dart';
import 'package:food_delivery_clean_arch/src/core/utils/app_colors.dart';

class HomePage extends HookWidget {
  HomePage({super.key});

  final _selectedIndex = useState(0);

  final PageController _pageController = usePageController();

  final List<Widget> _pages = [
    MainFoodPage(),
    const Center(
      child: Text('Next page'),
    ),
    // Container(child: Center(child: Text('Next next page'),),),
    CartHistory(), //TODO: add cart history
    const Center(
      child: Text('Next next next page'),
    ),
  ];

  void onPageChanged(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex.value,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: (index) => _pageController.animateToPage(index,
            duration: 300.milliseconds, curve: Curves.ease),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'history',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'me',
          ),
        ],
      ),
    );
  }
}
