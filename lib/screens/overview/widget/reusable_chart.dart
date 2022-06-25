import 'package:flutter/material.dart';
import 'package:money_management/screens/overview/components/chartlogic.dart';
import 'package:money_management/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReusableChart extends StatefulWidget {
  final List<ChartData> chartChecking;
  final String text;

  const ReusableChart(
      {Key? key, required this.chartChecking, required this.text})
      : super(key: key);

  @override
  State<ReusableChart> createState() => _ReusableChartState();
}

class _ReusableChartState extends State<ReusableChart> {
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: widget.text, textStyle: kCardTextStyle),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ),
          dataSource: widget.chartChecking,
          xValueMapper: (ChartData data, _) => data.categories,
          yValueMapper: (ChartData data, _) => data.amount,
        )
      ],
    );
  }
}
