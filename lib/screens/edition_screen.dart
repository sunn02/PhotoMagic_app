import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import '../filters/color_filters.dart';

class EditionPage extends StatefulWidget {
  final File image;
  const EditionPage({super.key, required this.image});

  @override
  _EditionPageState createState() => _EditionPageState();
}

class _EditionPageState extends State<EditionPage> {
  ColorFilter? _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = null; // Inicialmente sin filtro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),   
          // Cancelar y Guardar
          _buildActionButtons(),

          // Imagen con filtro aplicado
          _buildImage(),

          // Barra de filtros en la parte inferior
          _buildFilterBar(),
        ],
      ),
    );
  }

  // Widget para los botones de acción (Cancelar y Guardar)
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),

        SizedBox(width: 20), // Espaciado entre los botones

        ElevatedButton(
          onPressed: () async {
            await _saveImageWithFilter();
            print('Imagen guardada');
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }

  // Widget para mostrar la imagen con el filtro aplicado
  Widget _buildImage() {
    return Expanded(
      child: Center(
        child: ColorFiltered(
          colorFilter: _currentFilter ?? ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: Image.file(widget.image),
        ),
      ),
    );
  }

  // Widget para la barra de filtros en la parte inferior
  Widget _buildFilterBar() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton('None', null),
            _buildFilterButton('Greyscale', ColorFilters.greyscale),
            _buildFilterButton('Sepia', ColorFilters.sepia),
            _buildFilterButton('Invert', ColorFilters.invert),
          ],
      ),
    );
  }

  // Widget para los botones de filtro
  Widget _buildFilterButton(String label, ColorFilter? filter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilter = filter;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Icon(
              Icons.filter,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Función para guardar la imagen con el filtro aplicado
  Future<void> _saveImageWithFilter() async {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Cargando...')),
    );
    // Cargar la imagen
    img.Image? image = img.decodeImage(await widget.image.readAsBytes());

    // Aplicar filtro (si hay uno seleccionado)
    if (_currentFilter != null) {
      if (_currentFilter == ColorFilters.greyscale) {
        image = img.grayscale(image!);
      }
      if (_currentFilter == ColorFilters.sepia) {
        image = img.sepia(image!);
      }
      if (_currentFilter == ColorFilters.invert) {
        image = img.invert(image!);
      }
    }

    // Obtener el directorio donde guardar la imagen
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/edited_image.png';

    // Guardar la imagen en el archivo
    final savedFile = File(filePath)..writeAsBytesSync(img.encodePng(image!));

    // Mostrar mensaje de confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Imagen guardada en $filePath')),
    );
  }
}
