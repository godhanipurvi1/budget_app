import 'package:budget/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return controller.pages[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.onItemTapped(index);
          },
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined), label: ""),
            NavigationDestination(icon: Icon(Icons.monetization_on), label: ""),
            NavigationDestination(icon: Icon(Icons.list), label: ""),
            NavigationDestination(icon: Icon(Icons.category), label: "")
          ],
        );
      }),
    );
  }
}
