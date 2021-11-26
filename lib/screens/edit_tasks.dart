import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techrtwo/model/todo_model.dart';

class EditTasks extends StatefulWidget {
  const EditTasks({Key? key, required this.taskName, required this.tass})
      : super(key: key);
  final String taskName;
  final ToDo tass;

  @override
  State<EditTasks> createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String? _title = "";
  String? _priority = "Low";
  DateTime? _date = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ["Low", "Medium", "High"];

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date!);
  }

  Future updateTask(
      {required ToDo tasks,
      required String name,
      required String status,
      required String date,
      required int priority}) async {
    tasks.status = 'open';
    tasks.date = date;
    tasks.priority = priority;
    tasks.task = name;
    tasks.save();
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      int p = 0;
      switch (_priority) {
        case 'Low':
          {
            p = 1;
          }
          break;

        case 'Medium':
          {
            p = 2;
          }
          break;
        case 'High':
          {
            p = 3;
          }
          break;
        default:
          {
            p = 0;
          }
          break;
      }

      String formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString()));
      updateTask(
          tasks: widget.tass,
          status: 'open',
          name: _title.toString(),
          priority: p,
          date: formattedDate);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 60),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Edit Task",
                      style: TextStyle(
                          fontFamily: 'ProximaNova',
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 40.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'ProximaNova',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (input) => input!.trim().isEmpty
                                  ? 'Please Enter a Task Title'
                                  : null,
                              onSaved: (input) => _title = input,
                              initialValue: widget.taskName,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              readOnly: true,
                              controller: _dateController,
                              style: const TextStyle(fontSize: 18),
                              onTap: _handleDatePicker,
                              decoration: InputDecoration(
                                  labelText: 'Date',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'ProximaNova',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: DropdownButtonFormField(
                              isDense: true,
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              iconSize: 22.0,
                              iconEnabledColor: Colors.greenAccent,
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  labelText: 'Priority',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'ProximaNova',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (dynamic input) =>
                                  input.toString().trim().isEmpty ||
                                          input == null
                                      ? 'Please Select a Priority Level'
                                      : null,
                              onSaved: (input) => _priority = input.toString(),
                              items: _priorities.map((String priority) {
                                return DropdownMenuItem(
                                    value: priority,
                                    child: Text(
                                      priority,
                                      style: const TextStyle(
                                          fontFamily: 'ProximaNova',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18.0),
                                    ));
                              }).toList(),
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  _priority = newValue.toString();
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            height: 60.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(30.0)),
                            child: TextButton(
                              onPressed: _submit,
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
