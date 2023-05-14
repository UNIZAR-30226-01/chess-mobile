import 'package:flutter/material.dart';
import '../../communications/socket_io.dart';

TextButton surrenderButton(BuildContext context) {
  return TextButton(
    onPressed: () => surrender(),
    child: Container(
      padding: const EdgeInsets.all(12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "Rendirse",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ),
  );
}