import 'package:farmtrace/layers_details_page.dart';
import 'package:farmtrace/models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LayersPage extends StatefulWidget {
  const LayersPage({Key? key}) : super(key: key);

  @override
  State<LayersPage> createState() => _LayersPageState();
}

class _LayersPageState extends State<LayersPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late Box<Layers> _layersBox;
  late List<Layers> _layersList;

  @override
  void initState() {
    super.initState();

    _layersBox = Hive.box<Layers>('layers');
    _layersList = _layersBox.values.toList();
  }

  // Function to delete a layer from the list and Hive database
  void _deleteLayer(int index) async {
    await _layersBox.deleteAt(index); // Delete from Hive database
    setState(() {
      _layersList.removeAt(index); // Remove from list
    });
  }
// Function to edir
  void _editLayer(int index) {
    final layer = _layersList[index];
    _showAddLayerDialog(context, layer: layer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _layersList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LayerDetailsPage(layer: _layersList[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xff764abc),
                      child: Text('${_layersList[index].id}'),
                    ),
                    title: Text(_layersList[index].name),
                    subtitle: Text('Breed: ${_layersList[index].breed}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _editLayer(index);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteLayer(index);
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

  void _showAddLayerDialog(BuildContext context, {Layers? layer}) {
    final breeds = <String>[
      'Rhode Island Red',
      'Leghorn',
      'Plymouth Rock',
      'Sussex',
      'Wyandotte',
      'Orpington',
      'Australorp',
      'Marans',
      'Ameraucana',
      'Hamburg',
      'Brahma',
      'Cochin'
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
                final id = layer?.id ?? _layersBox.length;
                final name = _nameController.text;
                final age = _ageController.text;
                final breed = selectedBreed;
                final newLayer = Layers(
                   name: name, age: int.parse(age), breed: breed!);

                if (name.isNotEmpty && age.isNotEmpty && breed != null) {
                  if (layer == null) {
                    _layersBox.add(newLayer);
                  } else {
                    _layersBox.put(layer.key, newLayer);
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
