import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/form.dart';

class CustomCheckBox extends StatefulWidget {
  final String label;
  final CustomFormField<bool> value;
  final Function(bool) onCheckedChanged;
  const CustomCheckBox(
      {super.key,
      required this.label,
      required this.onCheckedChanged,
      required this.value});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool isChecked;
  @override
  void initState() {
    isChecked = widget.value.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 24 / 18,
          child: Checkbox(
            side: const BorderSide(color: Colors.white),
            value: isChecked,
            activeColor: Colors.white,
            checkColor: Colors.black,
            onChanged: (value) => onCheckedChanged(value ?? false),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white
          ),
        ),
      ],
    );
  }

  void onCheckedChanged(bool value) {
    setState(() {
      isChecked = value;
    });
    widget.onCheckedChanged(value);
  }
}
