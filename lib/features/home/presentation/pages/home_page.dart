import 'package:bliszo1/features/home/presentation/components/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // BUILD UI
  @override
  Widget build(BuildContext context) {

    // SCAFFOLD
    return Scaffold(

      // APP BAR
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        
      ),

      // DRAWER
      drawer: const MyDrawer(),
    );
  }
}