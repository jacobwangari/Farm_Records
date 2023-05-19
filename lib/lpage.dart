import 'package:farmtrace/dpage.dart';
import 'package:farmtrace/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class DairyPage extends StatefulWidget {
  const DairyPage({super.key});

  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late Box<Dairy> _dairyBox;
  late List<Dairy> _dairyList;

  @override
  void initState() {
    super.initState();

    _dairyBox = Hive.box<Dairy>('layers');
    _dairyList = _dairyBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dairy'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _dairyList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DairyDetailsPage(dairy: _dairyList[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xff764abc),
                      child: Text('${_dairyList[index].id}'),
                    ),
                    title: Text(_dairyList[index].name),
                    subtitle: Text('Breed: ${_dairyList[index].breed}'),
                    trailing: Text('Age: ${_dairyList[index].age}'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                _showAddLayerDialog(context);
              },
              child: const Text('+'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddLayerDialog(BuildContext context) {
    final breeds = <String>[
      'Freshian',
      'Jersey',
      'Guernsey',
      'Ayrshire',
    ];
    String? selectedBreed;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Register Layer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Layer Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age in Weeks'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Breed'),
                value: selectedBreed,
                onChanged: (value) {
                  setState(() {
                    selectedBreed = value;
                  });
                },
                items: breeds.map((breed) {
                  return DropdownMenuItem(
                    value: breed,
                    child: Text(breed),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final age = int.tryParse(_ageController.text) ?? 0;
                final breed = selectedBreed ?? '';

                _dairyBox.add(Dairy(
                  name: name,
                  age: age,
                  breed: breed,
                ));

                setState(() {
                  _dairyList = _dairyBox.values.toList();
                  // update the layers list
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
