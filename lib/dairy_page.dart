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

    _dairyBox = Hive.box<Dairy>('dairy');
    _dairyList = _dairyBox.values.toList();
  }

  // Function to delete a layer from the list and Hive database
  void _deleteDairy(int index) async {
    await _dairyBox.deleteAt(index); // Delete from Hive database
    setState(() {
      _dairyList.removeAt(index); // Remove from list
    });
  }

// Function to edir
  void _editDairy(int index) {
    final dairy = _dairyList[index];
    _showAddLayerDialog(context, dairy: dairy);
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
                    subtitle: Text('Breed: ${_dairyList[index].breed}  Age: ${_dairyList[index].age}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _editDairy(index);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteDairy(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
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

  void _showAddLayerDialog(BuildContext context, {Dairy? dairy}) {
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
          title: const Text('Register Dairy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Dairy Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age in Months'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Breed'),
                value: selectedBreed,
                onChanged: (String? value) {
                  setState(() {
                    selectedBreed = value;
                  });
                },
                items: breeds.map((breed) {
                  return DropdownMenuItem<String>(
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
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final id = dairy?.id ?? _dairyBox.length;
                final name = _nameController.text;
                final age = _ageController.text;
                final breed = selectedBreed;
                final newDairy =
                    Dairy(name: name, age: int.parse(age), breed: breed!);

                if (name.isNotEmpty && age.isNotEmpty && breed != null) {
                  if (dairy == null) {
                    _dairyBox.add(newDairy);
                  } else {
                    _dairyBox.put(dairy.key, newDairy);
                  }
                  _nameController.clear();
                  _ageController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
