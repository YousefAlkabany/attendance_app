import 'package:flutter/material.dart';

class DropBoxContainer extends StatefulWidget {
  const DropBoxContainer(
      {super.key,
      required this.areas,
      required this.onChanged,
      required this.value});

  final List areas;
  final void Function(Object?) onChanged;
  final dynamic value;

  @override
  State<DropBoxContainer> createState() => _DropBoxContainerState();
}

class _DropBoxContainerState extends State<DropBoxContainer> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ], borderRadius: BorderRadius.circular(20), color: Colors.yellow),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width / 36, vertical: height / 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: const Center(
                  child: Text(
                    'Select where you are',
                  ),
                ),
                items: widget.areas.map((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: Center(
                      child: Text(
                        item['name'].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  widget.onChanged(newValue);
                },
                value: widget.value,
                isExpanded: true,
                icon: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
