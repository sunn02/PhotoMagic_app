import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_app/screens/edition_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditionPage(image: File(pickedFile.path))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  print('Boton 1');
                  pickImage(context, ImageSource.camera);
                },
                child: const Text('📷 Tomar Foto')),
            ElevatedButton(
                onPressed: () {
                  print('Boton 2');
                  pickImage(context, ImageSource.gallery);
                },
                child: const Text('🖼️ Elegir de la Galería ')),
          ],
        ),
      ),
    );
  }
}
