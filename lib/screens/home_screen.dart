import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/screens/pick_image_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PickImagePage(source: ImageSource.camera,)),
                  );
                },
                child: const Text('📷 Tomar Foto')),
            ElevatedButton(
                onPressed: () {
                  print('Boton 2');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PickImagePage(source: ImageSource.gallery)),
                  );
                },
                child: const Text('🖼️ Elegir de la Galería ')),
          ],
        ),
      ),
    );
  }
}
