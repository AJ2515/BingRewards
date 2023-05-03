import 'dart:io';
import 'dart:math';
import 'package:demo/Constants/const.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var random = Random();
  final box = GetStorage();
  // box.write('switchValue')

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue.value = box.read('switchValue') ?? false;
    dropdownvalue.value = box.read('dropdownvalue') ?? '30';
    if (switchValue.value) {
      automateBingSearch();
    }
  }

  RxString dropdownvalue = '30'.obs;
  List items = [
    '3',
    (searches.length ~/ 4).toString(),
    (searches.length ~/ 2).toString(),
    (3 * searches.length ~/ 4).toString(),
    (searches.length).toString()
  ];
  RxBool switchValue = false.obs;
  // final Uri login =
  //     Uri.parse('https://account.microsoft.com/?refd=account.microsoft.com');
  final Uri login = Uri.parse("https://bing.com/search?q=random");
  final Uri rewards =
      Uri.parse('https://rewards.bing.com/?signin=1&FORM=ANNRW1');

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  automateBingSearch() async {
    for (int i = 0; i < int.parse(dropdownvalue.value); i++) {
      // while (searches.isNotEmpty) {
      var index = random.nextInt(searches.length);
      String value = searches.removeAt(index);
      final Uri url = Uri.parse("https://bing.com/search?q=$value");
      _launchUrl(url);
      await Future.delayed(const Duration(milliseconds: 2000));
    }
    await closeInAppWebView();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(searches.length.toString());
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Number of Searches: "),
                Obx(
                  () => DropdownButton(
                      value: dropdownvalue.value,
                      items: items
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text('$e')))
                          .toList(),
                      onChanged: (newValue) {
                        dropdownvalue.value = newValue.toString();
                        box.write('dropdownvalue', newValue.toString());
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text("Auto Search on Open",
                    style: TextStyle(
                        color: switchValue.value
                            ? Colors.green
                            : Colors.redAccent))),
                Obx(
                  () => Switch(
                    onChanged: (bool value) {
                      switchValue.value = value;
                      box.write('switchValue', value);
                    },
                    value: switchValue.value,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text("Log In"),
              onPressed: () async {
                await _launchUrl(login);
                // await closeInAppWebView();
              },
            ),
            ElevatedButton(
              child: const Text("Rewards"),
              onPressed: () async {
                await _launchUrl(rewards);
                // await closeInAppWebView();
              },
            ),
            TextButton(
                child: const Text("Search again"),
                onPressed: () => automateBingSearch())
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => exit(0),
        tooltip: 'Close app',
        child: const Icon(Icons.close),
      ),
    );
  }
}
