import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class CheckGpsEnabled extends StatelessWidget {
  const CheckGpsEnabled({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( // Asegura que el contenedor esté en el centro de la pantalla
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        // Utiliza SizedBox para dar un tamaño específico o usa un widget Flexible/Expanded para llenar el espacio disponible.
        width: double.infinity, // Hace que el contenedor se expanda para llenar el ancho de la pantalla
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Alinea horizontalmente en el centro
          children: [
            Text(
              "Es necesario habilitar el GPS",
              style: TextStyle(color: ColorsApp.text),
              textAlign: TextAlign.center, // Asegura que el texto esté centrado dentro de su contenedor
            ),
          ],
        ),
      ),
    );
  }
}
