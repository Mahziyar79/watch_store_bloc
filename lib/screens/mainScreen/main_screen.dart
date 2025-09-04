import 'package:flutter/material.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/res/colors.dart';
import 'package:watch_store/res/strings.dart';
import 'package:watch_store/screens/cart/cart_screen.dart';
import 'package:watch_store/screens/home/home_screen.dart';
import 'package:watch_store/screens/mainScreen/profile_screen.dart';
import 'package:watch_store/widgets/btm_nav_item.dart';

class BtmNavScreenIndex {
  BtmNavScreenIndex._();
  static const home = 0;
  static const basket = 1;
  static const profile = 2;
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = BtmNavScreenIndex.home;

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _basketKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  final List<int> _routeHistory = [BtmNavScreenIndex.home];

  late final keyMap = {
    BtmNavScreenIndex.home: _homeKey,
    BtmNavScreenIndex.basket: _basketKey,
    BtmNavScreenIndex.profile: _profileKey,
  };

  void _handleBackNavigation() {
    if (keyMap[selectedIndex]!.currentState!.canPop()) {
      keyMap[selectedIndex]!.currentState!.pop();
    } else if (_routeHistory.length > 1) {
      setState(() {
        _routeHistory.removeLast();
        selectedIndex = _routeHistory.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double btmNavHeight = size.height * 0.1;
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          _handleBackNavigation();
        },

        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: btmNavHeight,
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    Navigator(
                      key: _homeKey,
                      onGenerateRoute: (settings) =>
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                    ),
                    Navigator(
                      key: _basketKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    ),
                    Navigator(
                      key: _profileKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: btmNavHeight,
                  color: AppColors.btmNavColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BtmNavItem(
                        iconSvgPath: Assets.svg.user,
                        title: AppStrings.profile,
                        isActive: selectedIndex == BtmNavScreenIndex.profile,
                        onTap: () =>
                            btmNavOnPress(index: BtmNavScreenIndex.profile),
                      ),

                      BtmNavItem(
                        iconSvgPath: Assets.svg.cart,
                        title: AppStrings.basket,
                        isActive: selectedIndex == BtmNavScreenIndex.basket,
                        onTap: () =>
                            btmNavOnPress(index: BtmNavScreenIndex.basket),
                      ),

                      BtmNavItem(
                        iconSvgPath: Assets.svg.home,
                        title: AppStrings.home,
                        isActive: selectedIndex == BtmNavScreenIndex.home,
                        onTap: () =>
                            btmNavOnPress(index: BtmNavScreenIndex.home),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  btmNavOnPress({required index}) {
    setState(() {
      selectedIndex = index;
      _routeHistory.add(index);
    });
  }
}
