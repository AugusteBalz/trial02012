import 'package:flutter/material.dart';
import 'package:trial0201/widgets/graphs/line_chart.dart';
import 'package:trial0201/widgets/graphs/pie_chart.dart';
import 'package:trial0201/widgets/graphs/pie_chart_2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: EdgeInsets.all(10),
          child: Column(
        children: const [

          PieChartSample3(),

          //LineChartSample1(),
          //PieChartSample2(),
        ],
      )),
    );
  }
}
