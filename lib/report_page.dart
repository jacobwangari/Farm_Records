import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:farmtrace/models.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  double _totalLayersCost = 0.0;
  double _totalLayersEarnings = 0.0;
  double _totalDairyCost = 0.0;
  double _totalDairyEarnings = 0.0;

  @override
  void initState() {
    _calculateCostsAndEarnings();
    super.initState();
  }

  void _calculateCostsAndEarnings() {
    final Box<FeedingLayers>? feedingLayersBox =
        Hive.box<FeedingLayers>('feedinglayers');
    final Box<LayersHealth>? layersHealthBox =
        Hive.box<LayersHealth>('layershealth');
    final Box<FeedingDairy>? feedingDairyBox =
        Hive.box<FeedingDairy>('feedingdiary');
    final Box<DairyHealth>? dairyHealthBox =
        Hive.box<DairyHealth>('dairyhealth');
    final Box<Milking>? milkingBox = Hive.box<Milking>('milking');
    final Box<Hatching>? hatchingBox = Hive.box<Hatching>('hatching');

    // Calculate total cost and earnings for layers
    double layersFeedingCost = 0.0;
    double layersHealthCost = 0.0;
    double layersEarnings = 0.0;

    if (feedingLayersBox != null) {
      for (final feedingLayer in feedingLayersBox.values) {
        layersFeedingCost += feedingLayer.cost;
      }
    }

    if (layersHealthBox != null) {
      for (final layersHealth in layersHealthBox.values) {
        layersHealthCost += layersHealth.cost;
      }
    }

    _totalLayersCost = layersFeedingCost + layersHealthCost;

    if (hatchingBox != null) {
      for (final hatching in hatchingBox.values) {
        layersEarnings += hatching.earnings;
      }
    }

    _totalLayersEarnings = layersEarnings;

    // Calculate total cost and earnings for dairy
    double dairyFeedingCost = 0.0;
    double dairyHealthCost = 0.0;
    double dairyEarnings = 0.0;

    if (feedingDairyBox != null) {
      for (final feedingDairy in feedingDairyBox.values) {
        dairyFeedingCost += feedingDairy.cost;
      }
    }

    if (dairyHealthBox != null) {
      for (final dairyHealth in dairyHealthBox.values) {
        dairyHealthCost += dairyHealth.cost;
      }
    }

    _totalDairyCost = dairyFeedingCost + dairyHealthCost;

    if (milkingBox != null) {
      for (final milking in milkingBox.values) {
        dairyEarnings += milking.earnings;
      }
    }

    _totalDairyEarnings = dairyEarnings;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Total Cost and Earnings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Layers',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total cost: $_totalLayersCost',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total earnings: $_totalLayersEarnings',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Dairy',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total cost: $_totalDairyCost',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total earnings: $_totalDairyEarnings',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                   
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
