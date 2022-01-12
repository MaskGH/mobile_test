import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({
    Key? key,
    this.mainText,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.onSave,
    this.onChange,
    this.textInputType,
    this.icon,
    this.widget,
    this.autofillhints,
    this.prefixIcon,
    this.borderColor,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obscureText;
  final String? hintText;
  final String Function(String?)? validator;
  final Function(String?)? onSave;
  final Function(String)? onChange;
  final TextInputType? textInputType;
  final Icon? icon;
  final Widget? widget;
  final Iterable<String>? autofillhints;
  final Widget? mainText;
  final Widget? prefixIcon;
  final Color? borderColor;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: mainText,
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText!,
            validator: validator,
            maxLength: maxLength,
            onSaved: onSave,
            onChanged: onChange,
            keyboardType: textInputType,
            autofillHints: autofillhints,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: widget,
              counterText: "",
              suffixStyle: const TextStyle(
                color: Colors.red,
              ),
              hintText: hintText,
              hintStyle: TextStyles.contentM.copyWith(
                  color: ColorSchemes.gray400, fontFamily: Fonts.notoSansKR),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorSchemes.orangeMain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StepTitle extends StatelessWidget {
  const StepTitle({Key? key, this.titletext}) : super(key: key);
  final String? titletext;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 24,
      child: Text(
        "$titletext",
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: Fonts.notoSansKR),
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  SubTitle({Key? key, this.text}) : super(key: key);
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyles.contentM.copyWith(fontFamily: Fonts.notoSansKR));
  }
}

class Fonts {
  static const String notoSansKR = 'NotoSansKR';
}

class TextStyles {
  static const TextStyle notoSansKR = TextStyle(fontFamily: Fonts.notoSansKR);
  static const TextStyle baseTextStyle = notoSansKR;

  static TextStyle w400TextStyle =
      baseTextStyle.copyWith(fontWeight: FontWeight.w400);
  static TextStyle w500TextStyle =
      baseTextStyle.copyWith(fontWeight: FontWeight.w500);
  static TextStyle w700TextStyle =
      baseTextStyle.copyWith(fontWeight: FontWeight.w700);

  static TextStyle get title1 => w700TextStyle.copyWith(fontSize: 32);
  static TextStyle get title2 => w700TextStyle.copyWith(fontSize: 25);
  static TextStyle get title3 => w700TextStyle.copyWith(fontSize: 20);
  static TextStyle get subTitleM => w500TextStyle.copyWith(fontSize: 18);
  static TextStyle get subTitleB => w700TextStyle.copyWith(fontSize: 18);
  static TextStyle get smallTitleM => w500TextStyle.copyWith(fontSize: 16);
  static TextStyle get smallTitleB => w700TextStyle.copyWith(fontSize: 16);
  static TextStyle get contentR => w400TextStyle.copyWith(fontSize: 13);
  static TextStyle get contentM => w500TextStyle.copyWith(fontSize: 13);
  static TextStyle get contentB => w700TextStyle.copyWith(fontSize: 13);
  static TextStyle get explainR => w400TextStyle.copyWith(fontSize: 11);
  static TextStyle get explainM => w500TextStyle.copyWith(fontSize: 11);
  static TextStyle get explainB => w700TextStyle.copyWith(fontSize: 11);
  static TextStyle get caption => w500TextStyle.copyWith(fontSize: 9);

  static TextStyle get buttonBig => w500TextStyle.copyWith(fontSize: 15);
  static TextStyle get buttonMdM => w500TextStyle.copyWith(fontSize: 13);
  static TextStyle get buttonMdB => w700TextStyle.copyWith(fontSize: 13);
  static TextStyle get buttonSm =>
      w500TextStyle.copyWith(fontSize: 10, letterSpacing: 0.1);
}

class ColorSchemes {
  static const Color orangeMain = Color(0xffFFB609);
  static const Color orange30 = Color(0xffFFEAB6);
  static const Color orange10 = Color(0xffFFFBF3);
  static const Color black1 = Color(0xff212121);
  static const Color black6 = Color(0xffF6F6F6);
  static const Color red = Color(0xffFC511F);
  static const Color red20 = Color(0xffFFEEE9);
  static const Color white = Color(0xffFFFFFF);
  static const Color indigo = Color(0xff312E81);
  static const Color blue = Color(0xff1DA3FF);
  static const Color blueGray100 = Color(0xffCFD8DC);
  static const Color green = Color(0xff38AE00);
  static const Color gray50 = Color(0xffFAFAFA);
  static const Color gray100 = Color(0xffF5F5F5);
  static const Color gray200 = Color(0xffEEEEEE);
  static const Color gray300 = Color(0xffE0E0E0);
  static const Color gray400 = Color(0xffBDBDBD);
  static const Color gray500 = Color(0xff9E9E9E);
  static const Color gray800 = Color(0xff424242);
}

/// A large size custom button created using OutlinedButton.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return LargeButton(
///     onPressed: () => print("확인"),
///     backgroundColor: Colors.indigo,
///     borderRadius: 15,
///     child: const Text("확인"),
///   );
/// }
/// ```
class LargeButton extends StatelessWidget {
  /// Function onPressed.
  final VoidCallback onPressed;

  /// Button child widget such as Text("확인"). Default align center.
  final Widget child;

  /// Background color.
  final Color? backgroundColor;

  /// Button width value. Default value is 343.
  final double width;

  /// Button height value. Default value is 45.
  final double height;

  /// Border radius. Default value is 50.
  final double borderRadius;

  /// Create a LargeButton.
  ///
  /// <image src='https://user-images.githubusercontent.com/86940837/137304045-8b50d595-a80b-4176-bc8a-3d3e2e99def6.png' width="325px">
  const LargeButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.backgroundColor,
      this.width = 343,
      this.height = 45,
      this.borderRadius = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(width, height),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        side: const BorderSide(color: Colors.transparent),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
      ),
      child: child,
    );
  }
}

class SmallButton extends StatelessWidget {
  /// Function onPressed.
  final VoidCallback onPressed;

  /// Background color.
  final Color? backgroundColor;

  /// Button border color. Default value is Colors.transparent.
  final Color borderColor;

  /// Dropdown icon color. Default value is Theme.of(context).colorScheme.onPrimary.
  final Color? dropdownColor;

  /// Enable dropdown icon.
  final bool enableDropdown;

  /// Button child widget such as Text("확인"). Default align center.
  final Widget child;

  /// Create a SmallButton.
  ///
  /// <image src='https://user-images.githubusercontent.com/86940837/137305938-2c4167d3-ed70-4e96-a0c1-f5d014a05d2e.png' width="325px">
  const SmallButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.backgroundColor,
      this.borderColor = Colors.transparent,
      this.dropdownColor,
      this.enableDropdown = false})
      : super(key: key);

  /// Create a SmallButton with icon widget.
  ///
  /// <image src='https://user-images.githubusercontent.com/86940837/137305938-2c4167d3-ed70-4e96-a0c1-f5d014a05d2e.png' width="325px">
  factory SmallButton.icon({
    Key? key,
    required VoidCallback onPressed,
    required IconData icon,
    required Widget child,
    Color? backgroundColor,
    Color borderColor,
    Color? iconColor,
  }) = _SmallButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [child];
    if (enableDropdown) {
      Widget dropdown = Row(
        children: [
          const SizedBox(width: 4),
          Icon(
            FlutterRemix.arrow_down_s_fill,
            size: 10,
            color: dropdownColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      );
      _children.add(dropdown);
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: backgroundColor,
        textStyle: TextStyles.buttonSm,
        side: BorderSide(color: borderColor),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _children,
        ),
      ),
    );
  }
}

class _SmallButtonWithIcon extends SmallButton {
  _SmallButtonWithIcon({
    Key? key,
    required VoidCallback onPressed,
    required IconData icon,
    required Widget child,
    Color? backgroundColor,
    Color borderColor = Colors.transparent,
    Color? iconColor,
  }) : super(
            key: key,
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            child: _SmallButtonWithIconChild(
              icon: icon,
              child: child,
              iconColor: iconColor,
            ));
}

class _SmallButtonWithIconChild extends StatelessWidget {
  const _SmallButtonWithIconChild({
    Key? key,
    required this.icon,
    required this.child,
    this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final Widget child;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 10,
          color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(width: 4),
        child,
      ],
    );
  }
}

/// The various kinds of Dialog return status
///
/// See also:
///
///  * [CustomDialog]
enum DialogReturns {
  /// Pressed close icon.
  exit,

  /// Done by user
  confirm,

  /// Cancle by user
  cancel,
}

/// Creates a nonangulated Dialog widets
///
/// <image src='https://user-images.githubusercontent.com/40026920/137082881-61b3353e-4bd6-4e9e-b05f-b1b9bba6b3d3.png'>
///
/// ```dart
/// OutlinedButton(
///   child: const Text('Get Dialog Example'),
///   onPressed: () {
///     Get.dialog(
///       CustomDialog(
///         enableCancel: true,
///         enableConfirm: true,
///         enableExit: true,
///         child: Container(
///         height: 150,
///         width: 400,
///         color: Colors.black26,
///         child: const Center(child: Text('This has child property')),)
///     )).then((value) => print(value));
///
/// // <output>
/// // DialogReturns.confirm
/// // DialogReturns.cancel
/// // DialogReturns.exit
/// ```
///
/// See also:
///
///  * [DialogReturns]
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.child,
    this.height = 160,
    this.width = 360,
    this.padding =
        const EdgeInsets.only(left: 14, right: 14, top: 26, bottom: 15),
    this.decoration = const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    this.enableCancel = true,
    this.enableConfirm = true,
    this.enableExitLeft = false,
    this.enableExitRight = true,
  }) : super(key: key);

  /// Dialog body widget such as Text('Hello World'). Default Align top-left
  final Widget? child;

  /// Dialog height value. Default value is 160.
  final double height;

  /// Dialog Width value. Default value is 320.
  final double width;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Decoration
  final Decoration? decoration;

  /// enableCancle Button.
  final bool enableCancel;

  /// enableExit Button.
  final bool enableConfirm;

  /// enableExit Buttons.
  final bool enableExitRight;
  final bool enableExitLeft;

  Widget _buildExitButton() {
    return InkWell(
      onTap: () {
        Get.back<DialogReturns>(result: DialogReturns.exit);
      },
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: const Icon(
        Icons.close,
        size: 20,
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: OutlinedButton(
        onPressed: () {
          Get.back<DialogReturns>(result: DialogReturns.confirm);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorSchemes.red,
          shape: const StadiumBorder(),
          side: const BorderSide(
            color: ColorSchemes.red,
          ),
        ),
        child: Text(
          '확인',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: ColorSchemes.white),
        ),
      ),
    );
  }

  Widget _buildCancleButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: OutlinedButton(
        onPressed: () {
          Get.back<DialogReturns>(result: DialogReturns.cancel);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: ColorSchemes.white,
          shape: const StadiumBorder(),
          side: const BorderSide(
            color: ColorSchemes.gray500,
          ),
        ),
        child: Text(
          '취소',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: decoration,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (child != null) child ?? const SizedBox(),
              if (enableExitRight)
                Align(
                  alignment: Alignment.topRight,
                  child: _buildExitButton(),
                ),
              if (enableExitLeft)
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildExitButton(),
                ),
              if (enableConfirm || enableCancel)
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (enableConfirm) _buildConfirmButton(context),
                        if (enableCancel) _buildCancleButton(context),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
