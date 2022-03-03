import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'dart:html' as html;
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';
import '../util/items.dart';

class InspectPage extends StatelessWidget {
  const InspectPage({Key? key, required this.featureItem}) : super(key: key);

  final ValueListenable<FeatureItem> featureItem;

  static TextStyle heading() {
    return const TextStyle(fontSize: 20);
  }

  static TextStyle syntax() {
    return const TextStyle(fontSize: 16, height: 1.5);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(featureItem.value.name, style: const TextStyle(fontSize: 40)),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(featureItem.value.description, style: const TextStyle(fontSize: 20)),
      ),
      featureItem.value.scenarios.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                  itemCount: featureItem.value.scenarios.length,
                  itemBuilder: (context, index) {
                    ScenarioItem scenario =
                        featureItem.value.scenarios[index];
                    return Card(
                        color: Color(0xF5F8F8F8),
                        margin: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10),
                                child: Text(
                                  scenario.name,
                                  style: heading(),
                                )),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          scenario.syntax.given,
                                          textAlign: TextAlign.left, style: syntax(),),
                                      Text(
                                          scenario.syntax.when,
                                          textAlign: TextAlign.left, style: syntax(),),
                                      Text(
                                          scenario.syntax.then,
                                          textAlign: TextAlign.left, style: syntax(),)
                                    ]))
                          ],
                        ));
                  }),
            )
          : Container()
    ]);
  }
}