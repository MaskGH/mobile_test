import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:mobile_version/mobile/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({Key? key}) : super(key: key);

  @override
  Custom_TextFormFieldState createState() => Custom_TextFormFieldState();
}

class Custom_TextFormFieldState extends State<CustomTextFormField> {
  final formKey = GlobalKey<FormState>();

  _buildField(
      {String? label,
      String? hintText,
      String Function(String?)? validator,
      Function(String?)? onChanged,
      Widget? suffixIcon,
      Widget? prefixIcon,
      int? maxLength,
      TextEditingController? controller}) {
    return Column(
      children: [
        if (label != null) Text(label, style: TextStyles.contentM),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            prefix: prefixIcon,
            suffixIcon: suffixIcon,
            suffixStyle: const TextStyle(
              color: Colors.red,
            ),
            hintStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.gray400),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorSchemes.gray200),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorSchemes.orangeMain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildTextField() {
    List<Widget> children;
    Widget emailForm;
    Widget passwordForm;
    Widget phoneForm;

    emailForm = _buildField(
      label: "이메일",
      hintText: " 이메일",
      suffixIcon: TextButton(onPressed: () {}, child: const Text("중복확인")),
    );
    passwordForm = Container(
      width: Get.width,
      child: Column(
        children: [
          _buildField(
            label: "비밀번호",
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.eye_close_fill)),
            hintText: " 비밀번호",
          ),
          _buildField(
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.eye_close_fill)),
            hintText: " 비밀번호",
          ),
        ],
      ),
    );
    phoneForm = Container(
      width: Get.width,
      child: TextFormField(),
    );

    children = [
      emailForm,
      passwordForm,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: _buildTextField(),
        ),
      ),
    );
  }
}
