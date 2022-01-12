import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//pakages
import 'package:get/get.dart';

// styles
import 'package:flutter_remix/flutter_remix.dart';
import 'package:mobile_version/controller/user_controller.dart';
import 'package:mobile_version/controller/user_model.dart';
import 'package:mobile_version/mobile/styles.dart';

// views

class SignUpListMobile extends StatefulWidget {
  const SignUpListMobile({Key? key}) : super(key: key);

  @override
  _SignUpListMobileState createState() => _SignUpListMobileState();
}

class _SignUpListMobileState extends State<SignUpListMobile> {
  get value => 1;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      reverse: false,
      controller: pageController,
      onPageChanged: (int value) {
        setState(() {
          currentIndex = value;
        });
      },
      children: const [
        _EmailForm(),
        _ProFileForm(),
        _PayForm(),
        BloodForm(),
        _SubmitPage(),
        _CompanyIdSearchPage(),
      ],
    );
  }
}

PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;
String? email;
String? password;
String? phoneNumber = "$countryId $_phoneNumber";
String countryId = "+82";
String _phoneNumber = "";

BottomAppBar buildBottomAppBar({bool? bool, Function()? func}) {
  return BottomAppBar(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LargeButton(
          width: Get.width,
          borderRadius: 10,
          backgroundColor:
              bool! ? ColorSchemes.orangeMain : ColorSchemes.gray300,
          onPressed: bool
              ? func!
              : () {
                  null;
                },
          child: Text(
            "다음",
            style: TextStyles.buttonMdM.copyWith(
                color: bool ? ColorSchemes.white : ColorSchemes.black1),
          ),
        ),
      ));
}

final emailEditingController = TextEditingController();

class _EmailForm extends StatefulWidget {
  const _EmailForm({Key? key}) : super(key: key);

  @override
  __EmailFormState createState() => __EmailFormState();
}

class __EmailFormState extends State<_EmailForm> {
  final passwordEditingController = TextEditingController();
  final passwordTwoEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final numberEditingController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool _isVisibleT = false;
  bool _isPassword = false;
  bool _isNumber = false;
  bool _isRequest = false;
  bool _isEmail = false;
  bool _isNextButton = false;
  bool _isPhone = false;

  String mailBottomText = "메일 주소까지 입력해 주세요.";
  String passwordBottomText =
      "비밀번호는 영문 대소문자, 숫자, 특수문자(.!@#%)를 혼합하여 8~20자로 입력해 주세요.";
  String passwordText = "비밀번호가 일치합니다.";
  String number = "";
  String certification = "인증요청";
  String request = "재요청";
  String requestComplete = "인증확인";

  onEmailChanged(String email) {
    setState(() {
      if (!GetUtils.isEmail(email)) {
        _isEmail = false;
        mailBottomText = "사용할 수 없는 이메일 입니다.";
      } else if (email.isEmpty || email.length < 6) {
        _isEmail = false;
        mailBottomText = "메일 주소까지 입력해 주세요.";
      } else {
        _isEmail = true;
        mailBottomText = "사용할 수 있는 이메일 입니다.";
      }
      onNextButton();
    });
  }

  onPasswordChanged(String password) {
    setState(() {
      if (!RegExp(
              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,20}$')
          .hasMatch(password)) {
        passwordBottomText =
            "비밀번호는 영문 대소문자, 숫자, 특수문자(.!@#%)를 혼합하여 8~20자로 입력해 주세요.";
      } else if (passwordEditingController.text !=
          passwordTwoEditingController.text) {
        _isPassword = false;
        passwordBottomText = "비밀번호가 일치 하지 않습니다.";
      } else {
        _isPassword = true;
      }
      onNextButton();
    });
  }

  onNumberChanged(String number) {
    setState(() {
      if (!GetUtils.isNumericOnly(number) || number.length > 6) {
        number = "숫자만 입력해 주세요.";
        _isRequest = false;
      } else if (number.isEmpty && number.length == 6) {
        _isRequest = true;
      }
      onNextButton();
    });
  }

  onPhone(String phone) {
    setState(() {
      if (!phone.isNumericOnly || !GetUtils.isNumericOnly(phone)) {
        _isPhone = false;
      } else if (phone.isNumericOnly &&
          GetUtils.isNumericOnly(phone) &&
          phone.length >= 6) {
        _isPhone = true;
      }
      onNextButton();
    });
  }

  onNextButton() {
    setState(() {
      if (_isEmail == true && _isPassword == true && _isRequest == true) {
        _isNextButton = true;
      } else if (!_isEmail || !_isPassword || !_isRequest) {
        _isNextButton = false;
      }
    });
  }

  Widget buildBody({Widget? child}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: child);
  }

  Widget buildBodyTopIcon() {
    return Column(
      children: [
        topBackIcon(),
        const TopStepIcon(
          oneIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.red,
          ),
          oneStepColor: ColorSchemes.black1,
          oneLineColor: ColorSchemes.gray300,
          twoIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.gray300,
          ),
          twoStepColor: ColorSchemes.gray300,
          twoLineColor: ColorSchemes.gray300,
          threeIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.gray300,
          ),
          threeStepColor: ColorSchemes.gray300,
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget buildBodyCenter() {
    return Column(
      children: [
        const StepTitle(
          titletext: "계정 정보를 입력해 주세요.",
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextFieldForm(
          controller: emailEditingController,
          autofillhints: const [AutofillHints.email],
          mainText: Text(
            "이메일",
            style: TextStyles.explainM.copyWith(color: ColorSchemes.black1),
          ),
          hintText: "   이메일",
          onChange: (email) => onEmailChanged(email),
          borderColor: _isEmail ? ColorSchemes.gray300 : ColorSchemes.red,
          widget: TextButton(
            onPressed: () {
              // TODO : DB 확인
            },
            child: Text(
              "중복확인",
              style: TextStyles.contentM.copyWith(
                color: ColorSchemes.red,
              ),
            ),
          ),
          obscureText: false,
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            mailBottomText,
            style: _isEmail
                ? TextStyles.explainM
                : TextStyles.explainM.copyWith(color: ColorSchemes.red),
          ),
        ),
        const SizedBox(
          height: 39,
        ),
        CustomTextFieldForm(
          controller: passwordEditingController,
          mainText: Text(
            "비밀번호",
            style: TextStyles.explainM,
          ),
          hintText: "   비밀번호",
          obscureText: !_isVisible,
          textInputType: TextInputType.text,
          autofillhints: const [AutofillHints.newPassword],
          onChange: (password) => onPasswordChanged(password),
          widget: IconButton(
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            icon: _isVisible
                ? const Icon(FlutterRemix.eye_line)
                : const Icon(FlutterRemix.eye_close_line),
          ),
          borderColor: _isPassword ? ColorSchemes.gray300 : ColorSchemes.red,
        ),
        CustomTextFieldForm(
          controller: passwordTwoEditingController,
          hintText: "   비밀번호 확인",
          obscureText: !_isVisibleT,
          textInputType: TextInputType.text,
          autofillhints: const [AutofillHints.password],
          onChange: (password) => onPasswordChanged(password),
          borderColor: _isPassword ? ColorSchemes.gray300 : ColorSchemes.red,
          widget: IconButton(
            onPressed: () {
              setState(() {
                _isVisibleT = !_isVisibleT;
              });
            },
            icon: _isVisibleT
                ? const Icon(FlutterRemix.eye_line)
                : const Icon(FlutterRemix.eye_close_line),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            _isPassword ? passwordText : passwordBottomText,
            style: TextStyles.explainM.copyWith(
                color: _isPassword ? ColorSchemes.black1 : ColorSchemes.red),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextFieldForm(
          controller: phoneEditingController,
          onChange: (phone) => onPhone(phone),
          mainText: Text(
            "전화번호",
            style: TextStyles.explainM,
          ),
          hintText: "   전화번호('ㅡ'없이",
          obscureText: false,
          textInputType: TextInputType.phone,
          autofillhints: const [AutofillHints.telephoneNumber],
          borderColor: ColorSchemes.gray300,
          prefixIcon: DropdownButton<String>(
            underline: DropdownButtonHideUnderline(
              child: Container(),
            ),
            onChanged: (value) {
              countryId = value!;
            },
            value: countryId,
            items: getDropdown(),
          ),
          widget: TextButton(
            onPressed: _isPhone
                ? () {
                    setState(() {
                      _isNumber = true;
                    });
                  }
                : null,
            child: Text(
              _isNumber ? request : certification,
              style: TextStyles.contentM.copyWith(
                  color: _isNumber ? ColorSchemes.gray300 : ColorSchemes.red),
            ),
          ),
        ),
        _isNumber
            ? CustomTextFieldForm(
                controller: numberEditingController,
                hintText: " 인증번호",
                obscureText: false,
                autofillhints: const [AutofillHints.telephoneNumber],
                maxLength: 6,
                textInputType: TextInputType.number,
                onChange: (number) => onNumberChanged(number),
                borderColor:
                    _isRequest ? ColorSchemes.gray300 : ColorSchemes.red,
                widget: TextButton(
                  onPressed: () {
                    setState(() {
                      if (numberEditingController.text.length == 6 &&
                          numberEditingController.text.isNumericOnly) {
                        number = "전화번호 인증이 완료되었습니다.";
                        _isRequest = true;
                      } else {
                        _isRequest = false;
                      }
                      if (_isEmail == true &&
                          _isPassword == true &&
                          _isRequest == true) {
                        _isNextButton = true;
                      }
                    });
                  },
                  child: Text(
                    _isRequest ? "" : requestComplete,
                    style: TextStyles.contentM.copyWith(
                      color: ColorSchemes.red,
                    ),
                  ),
                ),
              )
            : Container(),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            number,
            style: TextStyles.explainM,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildBody(
            child: Column(
              children: [
                buildBodyTopIcon(),
                buildBodyCenter(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(
          bool: _isNextButton,
          func: () {
            setState(() {
              email = emailEditingController.text;
              password = passwordEditingController.text;
              phoneNumber = phoneEditingController.text;
              pageController.jumpToPage(1);
            });
          }),
    );
  }
}

///////////////////////// ProfileForm /////////////////////////

String? name;
String companyId = companyIdEditingController.text;
String? department;
String? dateTimeString;
DateTime? dateOfBirth;
String? gender = "";
final companyIdEditingController = TextEditingController();

class _ProFileForm extends StatefulWidget {
  const _ProFileForm({Key? key}) : super(key: key);

  @override
  __ProFileFormState createState() => __ProFileFormState();
}

class __ProFileFormState extends State<_ProFileForm> {
  // final _formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final departmentEditingController = TextEditingController();
  final dateOfBirthEditingController = TextEditingController();

  dynamic _value = 1;

  String signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
  String signBottomSubmitText = "결재 비밀번호가 일치합니다.";

  bool _isdateOfBirth = false;
  bool _isName = false;
  bool _iscompanyId = false;
  // bool _isGender = false;
  final bool _isLabel = false;

  String? _male = "MALE";
  String? _female = "FEMALE";

  onNextButton() {
    setState(() {
      if (nameEditingController.text.isEmpty) {
        _isName = false;
      } else if (nameEditingController.text.isNotEmpty) {
        _isName = true;
      }
      if (companyIdEditingController.text.isEmpty) {
        _iscompanyId = false;
      } else if (companyIdEditingController.text.isNotEmpty) {
        _iscompanyId = true;
      }

      if (_isName == true && _iscompanyId == true) {
        _isdateOfBirth = true;
      } else if (!_isName && !_iscompanyId) {
        _isdateOfBirth = false;
      }
    });
  }

  ondateOfBirthChanged(String dateOfBirth) {
    setState(() {
      if (dateOfBirth.isEmpty &&
          dateOfBirthEditingController.text.isEmpty &&
          nameEditingController.text.isEmpty &&
          departmentEditingController.text.isEmpty) {
        _isdateOfBirth = false;
      } else if (!dateOfBirth.isNumericOnly &&
          !dateOfBirthEditingController.text.isNumericOnly) {
        _isdateOfBirth = false;
      } else if (dateOfBirth.length >= 8 &&
          dateOfBirthEditingController.text.length >= 8 &&
          nameEditingController.text.isNotEmpty &&
          departmentEditingController.text.isNotEmpty) {
        _isdateOfBirth = true;
      }
    });
  }

  Widget buildBodyTopIcon() {
    return Column(
      children: [
        topBackIcon(),
        const TopStepIcon(
          oneIcon: Icon(
            FlutterRemix.checkbox_blank_circle_fill,
            size: 12,
            color: ColorSchemes.red,
          ),
          oneStepColor: ColorSchemes.red,
          oneLineColor: ColorSchemes.red,
          twoIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.red,
          ),
          twoStepColor: ColorSchemes.gray300,
          twoLineColor: ColorSchemes.gray300,
          threeIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.gray300,
          ),
          threeStepColor: ColorSchemes.gray300,
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget buildBodyCenter() {
    return Column(
      children: [
        const StepTitle(
          titletext: "프로필 정보 입력해 주세요.",
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextFieldForm(
          controller: nameEditingController,
          autofillhints: const [AutofillHints.email],
          mainText: Text(
            "이름",
            style: TextStyles.explainM.copyWith(color: ColorSchemes.black1),
          ),
          hintText: "   이름",
          borderColor: ColorSchemes.gray300,
          obscureText: false,
          textInputType: TextInputType.name,
          onChange: onNextButton(),
        ),
        const SizedBox(
          height: 36,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "소속",
            style: TextStyles.explainM,
          ),
        ),
        TextFormField(
          readOnly: true,
          onChanged: (companyId) {
            companyIdEditingController.text = companyId;
            onNextButton();
          },
          controller: companyIdEditingController,
          obscureText: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: _isLabel ? companyId : "   소속",
            hintStyle: TextStyles.contentM.copyWith(
                color: ColorSchemes.gray400, fontFamily: Fonts.notoSansKR),
            suffixIcon: TextButton(
              onPressed: () {
                pageController.jumpToPage(5);
              },
              child: Text("소속 찾기",
                  style: TextStyles.contentM.copyWith(color: ColorSchemes.red)),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorSchemes.gray300),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorSchemes.orangeMain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        CustomTextFieldForm(
          controller: departmentEditingController,
          mainText: Text("직급/직책", style: TextStyles.explainM),
          hintText: "   직급/직책",
          obscureText: false,
          textInputType: TextInputType.text,
          autofillhints: const [AutofillHints.name],
          borderColor: ColorSchemes.gray300,
          onChange: onNextButton(),
        ),
        const SizedBox(
          height: 36,
        ),
        SizedBox(
          width: Get.width,
          height: 100,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "생일",
                      style: TextStyles.contentM,
                    ),
                    SizedBox(
                      width: Get.width * 0.3,
                      height: 40,
                      child: TextFormField(
                        maxLength: 8,
                        controller: dateOfBirthEditingController,
                        onChanged: (dateOfBirth) {
                          ondateOfBirthChanged(dateOfBirth);
                          onNextButton();
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "20020202",
                          hintStyle: TextStyles.contentM.copyWith(
                              color: ColorSchemes.gray400,
                              fontFamily: Fonts.notoSansKR),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: ColorSchemes.orangeMain),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "성별",
                      style: TextStyles.contentM,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          activeColor: ColorSchemes.red,
                          value: _male!,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                        Text("남성", style: TextStyles.contentM),
                        Radio(
                          activeColor: ColorSchemes.red,
                          value: _female!,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                        Text("여성", style: TextStyles.contentM),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                buildBodyTopIcon(),
                buildBodyCenter(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(
          bool: _isdateOfBirth,
          func: () {
            setState(() {
              name = nameEditingController.text;
              companyId = companyIdEditingController.text;
              department = departmentEditingController.text;
              dateTimeString = dateOfBirthEditingController.text;
              dateOfBirth = DateTime.parse(dateTimeString!);
              gender = _value.toString();
              pageController.jumpToPage(2);
            });
          }),
    );
  }
}

String? approvalCode = "";

/////////////////// PayForm //////////////////
class _PayForm extends StatefulWidget {
  const _PayForm({Key? key}) : super(key: key);

  @override
  __PayFormState createState() => __PayFormState();
}

class __PayFormState extends State<_PayForm> {
  bool _ispayNumber = false;
  bool _isVisibleT = false;
  bool _isVisible = false;

  String signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
  String signBottomSubmitText = "결재 비밀번호가 일치합니다.";

  final payNumberEditingController = TextEditingController();
  final payNumberTwoEditingController = TextEditingController();

  onNumberChanged(String password) {
    setState(() {
      if (password.isEmpty || !password.isNumericOnly) {
        signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
      } else if (payNumberEditingController.text !=
          payNumberTwoEditingController.text) {
        signBottomText = "결재 비밀번호가 틀립니다.";
        _ispayNumber = false;
      } else if (payNumberEditingController.text ==
              payNumberTwoEditingController.text &&
          password.length == 6 &&
          password.isNumericOnly) {
        _ispayNumber = true;
      } else {
        _ispayNumber = false;
      }
    });
  }

  Widget buildBodyTopIcon() {
    return Column(
      children: [
        topBackIcon(),
        const TopStepIcon(
          oneIcon: Icon(
            FlutterRemix.checkbox_blank_circle_fill,
            size: 12,
            color: ColorSchemes.red,
          ),
          oneStepColor: ColorSchemes.red,
          oneLineColor: ColorSchemes.red,
          twoIcon: Icon(
            FlutterRemix.checkbox_blank_circle_fill,
            size: 12,
            color: ColorSchemes.red,
          ),
          twoStepColor: ColorSchemes.red,
          twoLineColor: ColorSchemes.red,
          threeIcon: Icon(
            FlutterRemix.checkbox_blank_circle_line,
            size: 12,
            color: ColorSchemes.red,
          ),
          threeStepColor: ColorSchemes.gray300,
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget buildBodyCenter() {
    return Column(
      children: [
        const StepTitle(
          titletext: "결재 비밀번호 등록",
        ),
        const SizedBox(
          height: 24,
        ),
        SubTitle(
          text: "결재 시 이용할 비밀번호를 입력해 주세요.",
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextFieldForm(
          controller: payNumberEditingController,
          mainText: Text(
            "결재 비밀번호",
            style: TextStyles.explainM,
          ),
          hintText: "   결재 비밀번호",
          obscureText: !_isVisible,
          maxLength: 6,
          textInputType: TextInputType.visiblePassword,
          autofillhints: const [AutofillHints.newPassword],
          borderColor: _ispayNumber ? ColorSchemes.gray300 : ColorSchemes.red,
          widget: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              icon: _isVisible
                  ? const Icon(FlutterRemix.eye_line)
                  : const Icon(FlutterRemix.eye_close_line)),
        ),
        CustomTextFieldForm(
          controller: payNumberTwoEditingController,
          hintText: "   결재 비밀번호 확인",
          obscureText: !_isVisibleT,
          maxLength: 6,
          textInputType: TextInputType.visiblePassword,
          autofillhints: const [AutofillHints.password],
          borderColor: _ispayNumber ? ColorSchemes.gray300 : ColorSchemes.red,
          widget: IconButton(
              onPressed: () {
                setState(() {
                  _isVisibleT = !_isVisibleT;
                });
              },
              icon: _isVisibleT
                  ? const Icon(FlutterRemix.eye_line)
                  : const Icon(FlutterRemix.eye_close_line)),
          onChange: onNumberChanged,
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            _ispayNumber ? signBottomSubmitText : signBottomText,
            style: TextStyles.explainM,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                buildBodyTopIcon(),
                buildBodyCenter(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(
          bool: _ispayNumber,
          func: () {
            if (payNumberEditingController.text ==
                payNumberTwoEditingController.text) {
              approvalCode = payNumberTwoEditingController.text;
            }
            pageController.jumpToPage(3);
          }),
    );
  }
}

String? bloodType = "$typeOne$typeTwo";
String? typeOne = "";
String? typeTwo = "";

class BloodForm extends StatefulWidget {
  const BloodForm({Key? key}) : super(key: key);

  @override
  _BloodFormState createState() => _BloodFormState();
}

class _BloodFormState extends State<BloodForm> {
  User? user;
  UserController userController = UserController();
  bool _isBlood = false;

  dynamic _value = 0;
  dynamic _valueTwo = 0;
  String? _rhP = "RH_PLUS_";
  String? _rhM = "RH_MINUS_";
  String? _dont = "UNKNOWN_";
  String? a = "A";
  String? b = "B";
  String? ab = "AB";
  String? o = "O";

  onBloodChanged() {
    setState(() {
      _isBlood = false;
      if (_value != null && _valueTwo != null) {
        _isBlood = true;
      } else if (_value == 0 || _valueTwo == 0) {
        _isBlood = false;
      }
    });
  }

  Widget buildTopImage() {
    return Column(
      children: [
        const SizedBox(
          height: 36,
        ),
        Image.asset("./assets/images/warning.png"),
        const SizedBox(
          height: 24,
        ),
        const Text(
          "안전사고시",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 35,
              color: ColorSchemes.red),
        ),
        Text(
          "빠른대처를 위해",
          style: TextStyles.title3.copyWith(color: ColorSchemes.black1),
        ),
        RichText(
          text: TextSpan(
            text: "혈액형",
            style: TextStyles.title2.copyWith(color: ColorSchemes.red),
            children: [
              TextSpan(
                  text: "을 알려주세요",
                  style:
                      TextStyles.title3.copyWith(color: ColorSchemes.black1)),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 140,
          child: Image.asset("./assets/images/medical_care.png"),
        )
      ],
    );
  }

  Widget buildBodyCenter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "RH",
              style: TextStyles.title3,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "1개 선택해 주세요.",
              style: TextStyles.explainR.copyWith(color: ColorSchemes.red),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              activeColor: ColorSchemes.red,
              value: _rhP!,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            Text(
              "RH+",
              style: TextStyles.smallTitleM,
            ),
            Radio(
              activeColor: ColorSchemes.red,
              value: _rhM!,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            Text(
              "RH-",
              style: TextStyles.smallTitleM,
            ),
            Radio(
              activeColor: ColorSchemes.red,
              value: _dont!,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            Text(
              "모름",
              style: TextStyles.smallTitleM,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "ABO 형",
              style: TextStyles.title3,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "1개 선택해 주세요.",
              style: TextStyles.explainR.copyWith(color: ColorSchemes.red),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              activeColor: ColorSchemes.red,
              value: a!,
              groupValue: _valueTwo,
              onChanged: (value) {
                setState(() {
                  _valueTwo = value;
                  onBloodChanged();
                });
              },
            ),
            Text(
              a!,
              style: TextStyles.smallTitleM,
            ),
            Radio(
              activeColor: ColorSchemes.red,
              value: b!,
              groupValue: _valueTwo,
              onChanged: (value) {
                setState(() {
                  _valueTwo = value;
                  onBloodChanged();
                });
              },
            ),
            Text(
              b!,
              style: TextStyles.smallTitleM,
            ),
            Radio(
              activeColor: ColorSchemes.red,
              value: ab!,
              groupValue: _valueTwo,
              onChanged: (value) {
                setState(() {
                  _valueTwo = value;
                  onBloodChanged();
                });
              },
            ),
            Text(
              ab!,
              style: TextStyles.smallTitleM,
            ),
            Radio(
              activeColor: ColorSchemes.red,
              value: o!,
              groupValue: _valueTwo,
              onChanged: (value) {
                setState(() {
                  _valueTwo = value;
                  onBloodChanged();
                });
              },
            ),
            Text(
              o!,
              style: TextStyles.smallTitleM,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                buildTopImage(),
                buildBodyCenter(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(
        bool: _isBlood,
        func: () async {
          typeOne = _value.toString();
          typeTwo = _valueTwo.toString();
          pageController.jumpToPage(4);
          // final DateFormat formatter = DateFormat("yyyy-mm-dd");
          // final DateTime dateTimer = formatter.format(dateOfBirth);
          userController.createdata(
            User(
                approvalCode: "123123",
                bloodType: bloodType,
                companyId: "20d17cc1-5bd3-4289-8ca0-4747ebdae5c9",
                dateOfBirth: dateOfBirth,
                department: "팀",
                email: "email@email.com",
                password: "password!12",
                gender: "MALE",
                name: "김기우",
                phoneCountryId: "c0311c86-66ad-4d9d-8dac-8a4ae122cf3d",
                phoneNumber: "01012341234"),
          );
          // userController.PostData(
          //   User(
          //       approvalCode: "123123",
          //       bloodType: bloodType,
          //       companyId: "20d17cc1-5bd3-4289-8ca0-4747ebdae5c9",
          //       dateOfBirth: dateTimeme,
          //       department: "팀",
          //       email: "email@email.com",
          //       password: "password!12",
          //       gender: "MALE",
          //       name: "김기우",
          //       phoneCountryId: "c0311c86-66ad-4d9d-8dac-8a4ae122cf3d",
          //       phoneNumber: "01012341234"),
          // );
        },
      ),
    );
  }
}

class _SubmitPage extends StatefulWidget {
  const _SubmitPage({Key? key}) : super(key: key);

  @override
  SubmitPageState createState() => SubmitPageState();
}

class SubmitPageState extends State<_SubmitPage> {
  bool isEmailConfirmed = false;

  bool isCertified = false;

  bool isResendButton = false;

  bool isResend = false;

  PageController pageController = PageController(
    initialPage: 0,
  );

  Widget buildBodyTop() {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        const StepTitle(
          titletext: "회원가입 완료",
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          "계정 가입이 완료되었습니다.",
          style: TextStyles.contentM,
        ),
        Text(
          "이메일 인증이 완료되면 서비스를 시작할 수 있습니다.",
          style: TextStyles.contentM,
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }

  Widget buildBodyEmail() {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emailEditingController.text,
            style: TextStyles.smallTitleB,
          ),
          isEmailConfirmed
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isEmailConfirmed = false;
                    });
                  },
                  icon: const Icon(
                    FlutterRemix.checkbox_circle_line,
                    color: ColorSchemes.red,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      pageController.jumpToPage(1);
                    });
                  },
                  icon: const Icon(FlutterRemix.edit_2_line),
                ),
        ],
      ),
    );
  }

  Widget buildEmailChangeTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldForm(
          textInputType: TextInputType.emailAddress,
          hintText: "oooooo@ooooo.com",
          borderColor: ColorSchemes.gray200,
          controller: emailEditingController,
          widget: isCertified
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FlutterRemix.checkbox_circle_line,
                    color: ColorSchemes.red,
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FlutterRemix.edit_2_line,
                  ),
                ),
          onChange: (email) {
            setState(() {
              if (!GetUtils.isEmail(email)) {
                isCertified = false;
              } else {
                isCertified = true;
                isResendButton = false;
              }
            });
          },
        ),
        isCertified
            ? Container()
            : isResendButton
                ? Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "이메일 인증 요청을 보냈습니다. 확인해주세요.",
                      style:
                          TextStyles.explainR.copyWith(color: ColorSchemes.red),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "이메일을 정확히 입력해 주세요.",
                      style:
                          TextStyles.explainR.copyWith(color: ColorSchemes.red),
                    ),
                  ),
      ],
    );
  }

// isEmailBottomText
  Widget buildBodyBottomText(bool isEmailBottomText) {
    if (!isEmailBottomText) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "인증 이메일을 받지 못했다면 이메일을 다시 확인해주세요.",
            style: TextStyles.explainR.copyWith(color: ColorSchemes.red),
          ),
          Text(
            "이메일 인증 완료 후 진행할 수 있습니다.",
            style: TextStyles.explainR.copyWith(color: ColorSchemes.red),
          ),
        ],
      );
    } else {
      return SizedBox(
        child: Text(
          "인증이 확인되었습니다. '시작하기'버튼을 눌러주세요.",
          style: TextStyles.explainR.copyWith(color: const Color(0xff757575)),
        ),
      );
    }
  }

  Widget buildBodyBottomButton(double bottomPaddingSize, Color? backgroundColor,
      Color? borderside, Widget child, Function()? onPressed) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: bottomPaddingSize),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(343, 45),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(color: borderside!),
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: child,
      ),
    );
  }

  Widget buildTimerButton() {
    return TweenAnimationBuilder<Duration>(
        duration: const Duration(seconds: 180),
        tween: Tween(begin: const Duration(seconds: 180), end: Duration.zero),
        onEnd: () {
          Get.back();
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('0$minutes:$seconds',
                  textAlign: TextAlign.center,
                  style:
                      TextStyles.contentR.copyWith(color: ColorSchemes.red)));
        });
  }

  Widget buildCupertinoDialog() {
    return CupertinoAlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FlutterRemix.alert_fill, color: ColorSchemes.red),
                Text(
                  "잠시 기다려 주세요.",
                  style: TextStyles.contentB,
                ),
              ],
            ),
          ),
          Text(
            "이미 인증요청을 보냈습니다. 잠시 후에 다시",
            style: TextStyles.contentR,
          ),
          Text(
            "시도해 주세요.",
            style: TextStyles.contentR,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: buildTimerButton(),
        ),
      ],
    );
  }

  Widget buildEmailFirst() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            buildBodyTop(),
            buildBodyEmail(),
            buildBodyBottomText(isEmailConfirmed),
          ],
        ),
        Column(
          children: [
            buildBodyBottomButton(
                5,
                isEmailConfirmed ? ColorSchemes.gray300 : ColorSchemes.white,
                isEmailConfirmed ? ColorSchemes.gray300 : ColorSchemes.red,
                Text(
                  "다시 인증하기",
                  style: TextStyles.contentM.copyWith(
                      color: isEmailConfirmed
                          ? ColorSchemes.white
                          : ColorSchemes.red),
                ),
                isEmailConfirmed
                    ? null
                    : () => {
                          Get.dialog(buildCupertinoDialog(),
                              barrierDismissible: false)
                        }),
            buildBodyBottomButton(
                10,
                isEmailConfirmed
                    ? ColorSchemes.orangeMain
                    : ColorSchemes.gray300,
                isEmailConfirmed
                    ? ColorSchemes.orangeMain
                    : ColorSchemes.gray300,
                Text(
                  "시작하기",
                  style: TextStyles.contentM.copyWith(
                      color: isEmailConfirmed
                          ? ColorSchemes.black1
                          : ColorSchemes.white),
                ),
                isEmailConfirmed ? () => {} : null)
          ],
        ),
      ],
    );
  }

  Widget buildEmailSecond() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            buildBodyTop(),
            buildEmailChangeTextField(),
          ],
        ),
        Column(
          children: [
            buildBodyBottomButton(
                5,
                isCertified ? ColorSchemes.red : ColorSchemes.white,
                isCertified ? ColorSchemes.red : ColorSchemes.red,
                Text(
                  "다시 인증하기",
                  style: TextStyles.contentM.copyWith(
                      color:
                          isCertified ? ColorSchemes.white : ColorSchemes.red),
                ), () {
              setState(() {
                isCertified = false;
                isResendButton = true;

                Get.dialog(buildCupertinoDialog(), barrierDismissible: false);

                //TODO : 이메일 재전송
              });
            }),
            buildBodyBottomButton(
                10,
                isEmailConfirmed
                    ? ColorSchemes.orangeMain
                    : ColorSchemes.gray300,
                isEmailConfirmed
                    ? ColorSchemes.orangeMain
                    : ColorSchemes.gray300,
                Text(
                  "시작하기",
                  style: TextStyles.contentM.copyWith(
                      color: isEmailConfirmed
                          ? ColorSchemes.black1
                          : ColorSchemes.white),
                ),
                () => null)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildEmailFirst(),
                buildEmailSecond(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// companyIdSearch Page
class _CompanyIdSearchPage extends StatefulWidget {
  const _CompanyIdSearchPage({Key? key}) : super(key: key);

  @override
  State<_CompanyIdSearchPage> createState() => __CompanyIdSearchPageState();
}

class __CompanyIdSearchPageState extends State<_CompanyIdSearchPage> {
  final searchEditingController = TextEditingController();
  String searchSubmit = "검색 결과";

  AppBar buildSearchAppBar() {
    return AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "소속 검색",
          style: TextStyles.contentM.copyWith(color: ColorSchemes.black1),
        ),
      ),
      elevation: 0,
      backgroundColor: ColorSchemes.white,
      leading: IconButton(
        icon: const Icon(
          FlutterRemix.arrow_left_line,
          size: 15,
          color: ColorSchemes.black1,
        ),
        onPressed: () {
          pageController.jumpToPage(1);
        },
      ),
    );
  }

  Widget buildTopSearchField() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: ColorSchemes.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: ColorSchemes.orangeMain),
      ),
      child: TextField(
        controller: searchEditingController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Icon(FlutterRemix.search_line),
          ),
        ),
      ),
    );
  }

  Widget buildBodySearchList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: GestureDetector(
            onTap: () {
              setState(() {
                searchEditingController.text = searchSubmit;
                companyIdEditingController.text = searchEditingController.text;
              });
              pageController.jumpToPage(1);
            },
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text("$searchSubmit $index"),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchAppBar(),
      backgroundColor: ColorSchemes.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              buildTopSearchField(),
              buildBodySearchList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget topBackIcon() {
  return SizedBox(
    width: Get.width,
    child: Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          FlutterRemix.arrow_left_line,
          size: 15,
          color: ColorSchemes.black1,
        ),
      ),
    ),
  );
}

class TopStepIcon extends StatelessWidget {
  const TopStepIcon({
    Key? key,
    this.oneIcon,
    this.twoIcon,
    this.threeIcon,
    this.oneLineColor,
    this.twoLineColor,
    this.oneStepColor,
    this.twoStepColor,
    this.threeStepColor,
  }) : super(key: key);
  final Icon? oneIcon;
  final Icon? twoIcon;
  final Icon? threeIcon;
  final Color? oneLineColor;
  final Color? twoLineColor;
  final Color? oneStepColor;
  final Color? twoStepColor;
  final Color? threeStepColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: oneIcon,
                ),
                Text(
                  "STEP 1",
                  style: TextStyles.caption.copyWith(color: oneStepColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 1,
            color: oneLineColor,
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: twoIcon,
                ),
                Text(
                  "STEP 2",
                  style: TextStyles.caption.copyWith(color: twoStepColor),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 1,
            color: twoLineColor,
          ),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: threeIcon,
                ),
                Text(
                  "STEP 3",
                  style: TextStyles.caption.copyWith(color: threeStepColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DropDownList Demo
List<DropdownMenuItem<String>> getDropdown() {
  List<DropdownMenuItem<String>> dropdownItems = [];
  for (int i = 0; i < dropDownList.length; i++) {
    String currency = dropDownList[i];
    var newItem = DropdownMenuItem(child: Text(currency), value: currency);
    dropdownItems.add(newItem);
  }

  return dropdownItems;
}

const List<String> dropDownList = [
  '+82',
  '+83',
  '+84',
  '+85',
  '+86',
  '+87',
  '+88',
  '+89',
  '+90',
  '+91',
  '+92',
  '+93',
  '+94',
  '+95',
  '+96',
  '+97',
];
