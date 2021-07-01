import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget textInputField({
  @required TextEditingController controller,
  @required TextInputType type,
  double size,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      height: size,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 20,
              color: Colors.black.withOpacity(0.8),
              offset: Offset(0, 5),
            )
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
