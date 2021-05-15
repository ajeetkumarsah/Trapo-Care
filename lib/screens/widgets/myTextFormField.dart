import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapo_care/controller/color.dart';

final TextStyle primaryText =
    TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600);

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final String initialValue;
  final TextEditingController controller;
  final bool requiredField;
  final bool isNumber;
  final bool isEnable;
  final bool limit;
  final Function onFieldSubmitted;
  MyTextFormField({
    this.labelText,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.requiredField = false,
    this.isNumber = false,
    this.isEnable = true,
    this.onChanged,
    this.limit = false,
    this.controller,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Column(
        children: [
          TextFormField(
            inputFormatters: limit
                ? [
                    LengthLimitingTextInputFormatter(10),
                  ]
                : null,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: requiredField ? labelText + ' *' : labelText,
              contentPadding: EdgeInsets.all(15.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blueColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 1.5)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 1.5)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: redColor, width: 1.5)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: redColor, width: 1.5)),
              filled: true,
              fillColor: whiteColor,
            ),
            validator: validator,
            initialValue: initialValue,
            enabled: !isEnable ? false : true,
            onSaved: onSaved,
            onChanged: onChanged,
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          ),
        ],
      ),
    );
  }
}
