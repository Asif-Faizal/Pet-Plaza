import 'package:flutter/material.dart';

class Adoptpets extends StatefulWidget {
  const Adoptpets({super.key, required this.petType});
  final String petType;

  @override
  State<Adoptpets> createState() => _AdoptpetsState();
}

class _AdoptpetsState extends State<Adoptpets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.petType,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
    );
  }
}