
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaQuarto extends StatelessWidget{
  const TelaQuarto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quarto"),),
      body: Center(
        child: Column(
          children: [
            Text("Quarto"),
          ],
        ),
      ),
    );
  }


}