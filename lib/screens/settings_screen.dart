import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final List<String> _images = ['Lake', 'Mountain', 'Sea', 'Country'];
  String _selectedImage = 'Lake';

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter your name'),
            ),
            DropdownButton<String>(
              value: _selectedImage,
              items: _images.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedImage = newValue ?? 'Lake';
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveSettings().then((value) {
            if (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings saved!'),
                  duration: Duration(seconds: 3),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('An error occurred'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<bool> saveSettings() async {
    final SpHelper helper = SpHelper();
    return await helper.setSettings(_nameController.text, _selectedImage);
  }

  Future<void> getSettings() async {
    final SpHelper helper = SpHelper();
    Map<String, String> settings = await helper.getSettings();

    _selectedImage = settings['image'] ?? '';
    _nameController.text = settings['name'] ?? '';

    if (_selectedImage == '') _selectedImage = 'Lake';

    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
