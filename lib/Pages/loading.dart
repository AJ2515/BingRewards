import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    GetStorage.init();
    return Scaffold();
  }
}