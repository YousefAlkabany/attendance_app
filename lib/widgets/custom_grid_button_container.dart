import 'package:flutter/material.dart';

class CustomGridButtonContainer extends StatefulWidget {
  const CustomGridButtonContainer(
      {super.key,
      required this.title,
       this.onTap,
      this.time,
      required this.image,
      this.isActive = false , 
      this.activeColor});

  final String title;
  final VoidCallback ? onTap;
  final String? time;
  final String image;
  final bool isActive;
  final Color ? activeColor; 

  @override
  State<CustomGridButtonContainer> createState() =>
      _CustomGridButtonContainerState();
}

class _CustomGridButtonContainerState extends State<CustomGridButtonContainer> {
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: width / 1,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ], borderRadius: BorderRadius.circular(20), color: widget.isActive ? widget.activeColor : Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 36, vertical: height / 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: height / 20,
                    width: height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        widget.image,
                        height: height / 36,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 36,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(fontFamily: 'LexendSemiBold'),
                  ),
                ],
              ),
              SizedBox(
                height: height / 120,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    widget.time ?? '',
                    style: const TextStyle(
                        fontSize: 22, fontFamily: 'LexendSemiBold'),
                  ),
                ),
              ),
              SizedBox(
                height: height / 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
