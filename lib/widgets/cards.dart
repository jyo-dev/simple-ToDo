import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCards extends StatelessWidget {
  CustomCards(
      {Key? key,
      required this.date,
      required this.taskName,
      required this.priority,
      this.priorityValue = ''})
      : super(key: key);
  final String date;
  final String taskName;
  final int priority;
  String priorityValue = '';
  Color cardColor(int priority) {
    if (priority == 1) {
      priorityValue = 'Low Priority';
      return const Color(0xff7FFFD4);;
    } else if (priority == 2) {
      priorityValue = 'Medium Priority';
      return const Color(0xff088F8F);
    } else {
      priorityValue = 'High Priority';
      return const Color(0xff097969);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
    String day = DateFormat("dd").format(tempDate);

    return Card(
      color: cardColor(priority),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              day,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
               
                Text(
                  date,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
