import 'package:exchange_rates/src/core/constants/app_sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';

class VisualizeChart extends StatefulWidget {
  const VisualizeChart(
      {super.key,
      required this.normalizedValues,
      required this.minY,
      required this.maxY});

  final List<Map> normalizedValues;
  final double minY;
  final double maxY;
  @override
  State<VisualizeChart> createState() => _VisualizeChartState();
}

class _VisualizeChartState extends State<VisualizeChart> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue
  ];

  bool showAvg = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: Sizes.p20,
              left: Sizes.p12,
              top: Sizes.p16,
              bottom: Sizes.p8,
            ),
            child: LineChart(mainData()),
          ),
        ),
        const SizedBox(
          width: 60,
          height: 34,
          child: Padding(
            padding: EdgeInsets.all(Sizes.p8),
            child: Text(
              'Price',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
            widget.normalizedValues[value.toInt()][value.toInt()].toString(),
            style: style);
        break;
      case 2:
        text = Text(
            widget.normalizedValues[value.toInt()][value.toInt()].toString(),
            style: style);
        break;
      case 4:
        text = Text(
            widget.normalizedValues[value.toInt()][value.toInt()].toString(),
            style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) => const SizedBox();

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 4,
      minY: widget.minY,
      maxY: widget.maxY,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(widget.normalizedValues[0]['x'].toDouble(),
                widget.normalizedValues[0]['y'].toDouble()),
            FlSpot(widget.normalizedValues[1]['x'].toDouble(),
                widget.normalizedValues[1]['y'].toDouble()),
            FlSpot(widget.normalizedValues[2]['x'].toDouble(),
                widget.normalizedValues[2]['y'].toDouble()),
            FlSpot(widget.normalizedValues[3]['x'].toDouble(),
                widget.normalizedValues[3]['y'].toDouble()),
            FlSpot(widget.normalizedValues[4]['x'].toDouble(),
                widget.normalizedValues[4]['y'].toDouble()),
          ],
          isCurved: false,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Colors.yellow, const Color(0xffad9c00)]
                  .map((e) => e.withOpacity(0.5))
                  .toList(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
