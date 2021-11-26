import 'package:flutter/material.dart';

class NoTasksFound extends StatelessWidget {
  const NoTasksFound({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Tasks Found'),
    );
  }
}