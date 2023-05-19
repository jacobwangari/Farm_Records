import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/adapters.dart';
import 'models.dart';

class DairyDetailsPage extends StatefulWidget {
  final Dairy dairy;

  const DairyDetailsPage({Key? key, required this.dairy}) : super(key: key);

  @override
  State<DairyDetailsPage> createState() => _DairyDetailsPageState();
}

class _DairyDetailsPageState extends State<DairyDetailsPage> {
  late Box<FeedingDairy> _feedingBox;
  late Box<DairyHealth> _healthBox;
  late Box<Milking> _milkingBox;

  @override
  void initState() {
    super.initState();
    _feedingBox = Hive.box<FeedingDairy>('feedingdiary');
    _healthBox = Hive.box<DairyHealth>('dairyhealth');
    _milkingBox = Hive.box<Milking>('milking');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.dairy.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Feeding Records'),
              Tab(text: 'Health Records'),
              Tab(text: 'Milking Records'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFeedingList(),
            _buildHealthList(),
            _buildMilkingList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedingList() {
    final feedingRecords = _feedingBox.values
        .where((record) => record.id == widget.dairy.id)
        .toList();

    // Calculate the total cost of all feeds
    final totalCost = feedingRecords.fold<double>(
      0.0,
      (previousValue, record) => previousValue + record.cost,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final amountController = TextEditingController();
          final costController = TextEditingController();

          // Show a dialog to get the feeding record details from the user
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add Feeding Record"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Amount",
                        hintText: "Enter the amount of feed given",
                      ),
                    ),
                    TextField(
                      controller: costController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Cost",
                        hintText: "Enter the cost of the feed",
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () {
                      final amount =
                          double.tryParse(amountController.text) ?? 0;
                      final cost = double.tryParse(costController.text) ?? 0;

                      // Add the feeding record to the database
                      _feedingBox.add(FeedingDairy(
                        id: widget.dairy.id,
                        amount: amount,
                        cost: cost,
                        date: DateTime.now(),
                      ));

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: feedingRecords.length,
              itemBuilder: (BuildContext context, int index) {
                final record = feedingRecords[index];
                final formattedDate = DateFormat.yMd()
                    .add_jm()
                    .format(record.date); // format the date without seconds
                return ListTile(
                  title: Text(
                    'Amount: ${record.amount}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Cost: ${record.cost}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${DateFormat.yMd().add_jm().format(record.date)}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Container(
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const Text(
                        'Total Cost:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\Ksh ${totalCost.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHealthList() {
    final healthRecords = _healthBox.values
        .where((record) => record.id == widget.dairy.id)
        .toList();

    final totalCost = healthRecords.fold<double>(
      0.0,
      (previousValue, record) => previousValue + record.cost,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nameController = TextEditingController();
          final costController = TextEditingController();

          // Show a dialog to get the health record details from the user
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add Health Record"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        hintText: "Enter the name of the health record",
                      ),
                    ),
                    TextField(
                      controller: costController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Cost",
                        hintText: "Enter the cost used for the health",
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () {
                      final name = nameController.text;
                      final cost = double.tryParse(costController.text) ?? 0;

                      // Add the health record to the database
                      _healthBox.add(DairyHealth(
                        id: widget.dairy.id,
                        name: name,
                        cost: cost,
                        date: DateTime.now(),
                      ));

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: healthRecords.length,
              itemBuilder: (BuildContext context, int index) {
                final record = healthRecords[index];
                final formattedDate = DateFormat.yMd()
                    .add_jm()
                    .format(record.date); // format the date without seconds
                return ListTile(
                  title: Text(
                    'Health Name: ${record.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Cost: ${record.cost}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${DateFormat.yMd().add_jm().format(record.date)}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Container(
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const Text(
                        'Total Cost:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\Ksh ${totalCost.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMilkingList() {
    final hatchingRecords = _milkingBox.values
        .where((record) => record.id == widget.dairy.id)
        .toList();
    // Calculate the total cost of all feeds
    final totalCost = hatchingRecords.fold<double>(
      0.0,
      (previousValue, record) => previousValue + record.earnings,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final earningsController = TextEditingController();
          final numberController = TextEditingController();

          // Show a dialog to get the feeding record details from the user
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add Milking Record"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Amount",
                        hintText: "Enter the number of litres",
                      ),
                    ),
                    TextField(
                      controller: earningsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Earnings",
                        hintText: "Enter the earnings from the milk",
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: const Text("Add"),
                    onPressed: () {
                      final number = double.tryParse(numberController.text) ?? 0;
                      final cost =
                          double.tryParse(earningsController.text) ?? 0;

                      // Add the feeding record to the database
                      _milkingBox.add(Milking(
                        id: widget.dairy.id,
                        amount: number,
                        earnings: cost,
                        date: DateTime.now(),
                      ));

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: hatchingRecords.length,
              itemBuilder: (BuildContext context, int index) {
                final record = hatchingRecords[index];
                final formattedDate = DateFormat.yMd()
                    .add_jm()
                    .format(record.date); // format the date without seconds
                return ListTile(
                  title: Text(
                    'Milk: ${record.amount} litres',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Earnings: ${record.earnings}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Date: ${DateFormat.yMd().add_jm().format(record.date)}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Container(
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const Text(
                        'Total Earnings:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\Ksh ${totalCost.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
