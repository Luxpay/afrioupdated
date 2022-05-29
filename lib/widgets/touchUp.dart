import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart';
import '../utils/hexcolor.dart';

class PassWordtextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;

    PassWordtextField({ Key? key , required this.hint,required this.controller}) : super(key: key);

   bool hidePassword = true;

  Color passwordStrengthColor = red6;


  var finished = false;

  var hidePasswordConfirm = true;

  var showConfirmPasswordHint = false;

  var showPasswordHint = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
          "${hint}",
          style: TextStyle(
              fontSize: 13,
              fontWeight:  FontWeight.w600,
              color:HexColor("#1E1E1E")),
        ),
         SizedBox(height: 15),
            TextField(
                    controller:controller,
                    onChanged: (value) {
                     
                    },
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        hintText: '***********',
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        fillColor: white,
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            
                              hidePassword = !hidePassword;
                              // print(passwordController.text.length);
                          
                          },
                          icon: Icon(
                              hidePassword
                                  ? Icons.remove_red_eye_outlined
                                  : FontAwesomeIcons.eyeSlash,
                              size: hidePassword ? 20 : 15),
                        )),
                  ),
                 
                  
        ],
      ),
    );
  }
}
