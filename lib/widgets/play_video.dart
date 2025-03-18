import 'package:flutter/material.dart';

class PlayVideoButton extends StatelessWidget {
  const PlayVideoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Acción al presionar el botón
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Fondo rojo oscuro
        foregroundColor: Colors.black, // Texto en blanco
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ), // Tamaño del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
        elevation: 5, // Sombra
        // Color de la sombra
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow),
          SizedBox(width: 10),
          Text(
            'Reproducir',
            style: TextStyle(
              fontSize: 18, // Tamaño del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
        ],
      ),
    );
  }
}
