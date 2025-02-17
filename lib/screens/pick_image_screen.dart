import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImagePage extends StatefulWidget {
  final ImageSource source; // Recibe si es cámara o galería

  const PickImagePage({super.key, required this.source});

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File? _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    pickImage(); // Llama a la función para abrir cámara/galería automáticamente
  }


  pickImage() async {
    final pickedFile = await _picker.pickImage(source: widget.source);
    if(pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: _image == null
            ? const Text('No se ha seleccionado ninguna imagen')
            : Image.file(_image!), // Muestra la imagen seleccionada
            )
    );
  }
}
