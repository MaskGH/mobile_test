import 'package:flutter/material.dart';

// packages
import 'package:get/get.dart';
import 'package:mobile_version/mobile/styles.dart';

// styles

import 'package:flutter_remix/flutter_remix.dart';

class SignUpList extends StatefulWidget {
  const SignUpList({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpList> createState() => SignUpListState();
}

class SignUpListState extends State<SignUpList> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      reverse: false,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _EmailForm(),
        _ProfileForm(),
        _BloodForm(),
        _SubmitPage(),
        _TeamSearchPage(),
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

// email form
class _EmailForm extends StatefulWidget {
  const _EmailForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_EmailForm> createState() => _EmailFormState();
}


class _EmailFormState extends State<_EmailForm> {
  final _formKey = GlobalKey<FormState>();
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

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final passwordTwoEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final numberEditingController = TextEditingController();

  onEmailChanged(String email) {
    setState(() {
      _isEmail = false;
      if (email.length >= 8 && !GetUtils.isEmail(email)) {
        _isEmail = false;
        mailBottomText = "사용할 수 없는 이메일 입니다.";
      } else if (email.isEmpty || email.length < 8) {
        _isEmail = false;
        mailBottomText = "메일 주소까지 입력해 주세요.";
      } else if (GetUtils.isEmail(email)) {
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
      if (!GetUtils.isNumericOnly(number)) {
        number = "숫자만 입력해 주세요.";
        _isRequest = false;
      } else if (number.isNotEmpty && number.length == 6) {
        _isRequest = true;
      }
      onNextButton();
    });
  }

  onPhone(String phone) {
    setState(() {
      if (!phone.isNumericOnly && !GetUtils.isNumericOnly(phone)) {
        _isPhone = false;
      } else if (phone.isNumericOnly &&
          GetUtils.isNumericOnly(phone) &&
          phone.length <= 6) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const StepOne(
                padding: EdgeInsets.only(top: 30, bottom: 30),
              ),
              Container(
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 760),
                height: 760,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: Form(
                      key: _formKey,
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 12),
                            const StepTitle(
                              titletext: "계정 정보를 입력해 주세요.",
                            ),
                            const SizedBox(height: 24),
                            CustomTextFieldForm(
                              controller: emailEditingController,
                              autofillhints: const [AutofillHints.email],
                              mainText: Text(
                                "이메일",
                                style: TextStyles.explainM
                                    .copyWith(color: ColorSchemes.black1),
                              ),
                              hintText: "   이메일",
                              onChange: (email) => onEmailChanged(email),
                              borderColor: _isEmail
                                  ? ColorSchemes.gray300
                                  : ColorSchemes.red,
                              widget: TextButton(
                                onPressed: () {},
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
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                mailBottomText,
                                style: _isEmail
                                    ? TextStyles.explainM
                                    : TextStyles.explainM
                                        .copyWith(color: ColorSchemes.red),
                              ),
                            ),
                            const SizedBox(height: 5),
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
                              onChange: (password) =>
                                  onPasswordChanged(password),
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
                              borderColor: _isPassword
                                  ? ColorSchemes.gray300
                                  : ColorSchemes.red,
                            ),
                            CustomTextFieldForm(
                              controller: passwordTwoEditingController,
                              hintText: "   비밀번호 확인",
                              obscureText: !_isVisibleT,
                              textInputType: TextInputType.text,
                              autofillhints: const [AutofillHints.password],
                              onChange: (password) =>
                                  onPasswordChanged(password),
                              borderColor: _isPassword
                                  ? ColorSchemes.gray300
                                  : ColorSchemes.red,
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
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _isPassword ? passwordText : passwordBottomText,
                                style: TextStyles.explainM.copyWith(
                                    color: _isPassword
                                        ? ColorSchemes.black1
                                        : ColorSchemes.red),
                              ),
                            ),
                            const SizedBox(height: 5),
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
                              autofillhints: const [
                                AutofillHints.telephoneNumber
                              ],
                              borderColor: ColorSchemes.gray300,
                              prefixIcon: DropdownButton<String>(
                                underline: DropdownButtonHideUnderline(
                                  child: Container(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    countryId = value!;
                                  });
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
                                      color: _isNumber
                                          ? ColorSchemes.gray300
                                          : ColorSchemes.red),
                                ),
                              ),
                            ),
                            _isNumber
                                ? CustomTextFieldForm(
                                    controller: numberEditingController,
                                    hintText: " 인증번호",
                                    obscureText: false,
                                    autofillhints: const [
                                      AutofillHints.telephoneNumber
                                    ],
                                    maxLength: 6,
                                    textInputType: TextInputType.number,
                                    onChange: (number) =>
                                        onNumberChanged(number),
                                    borderColor: _isRequest
                                        ? ColorSchemes.gray300
                                        : ColorSchemes.red,
                                    widget: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numberEditingController
                                                  .text.length <
                                              6) {
                                            number = "인증번호 6자리 입력 해주세요.";
                                          } else if (numberEditingController
                                                      .text.length ==
                                                  6 &&
                                              numberEditingController
                                                  .text.isNumericOnly) {
                                            number = "전화번호 인증이 완료되었습니다.";
                                            _isRequest = true;
                                          }
                                          if (_isEmail == true &&
                                              _isPassword == true &&
                                              _isRequest == true) {
                                            _isNextButton = true;
                                          } else if (!_isEmail &&
                                              !_isPassword &&
                                              !_isRequest) {
                                            _isNextButton = false;
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
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                number,
                                style: TextStyles.explainM,
                              ),
                            ),
                            const SizedBox(height: 12),
                            LargeButton(
                              borderRadius: 10,
                              width: Get.width,
                              backgroundColor: _isNextButton
                                  ? ColorSchemes.orangeMain
                                  : ColorSchemes.gray300,
                              onPressed: _isNextButton
                                  ? () {
                                      setState(() {
                                        if (_isNextButton == true) {
                                          email = emailEditingController.text;
                                          password =
                                              passwordEditingController.text;
                                          _phoneNumber =
                                              phoneEditingController.text;
                                          pageController.jumpToPage(1);
                                        }
                                      });
                                    }
                                  : () {
                                      null;
                                    },
                              child: Text(
                                "다음",
                                style: TextStyles.buttonMdM.copyWith(
                                    color: _isNextButton
                                        ? ColorSchemes.white
                                        : ColorSchemes.black1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/////// profile

String? name;
String companyId = teamEditingController.text;
String? department;
String? dateOfBirth;
String? gender = "";
String? approvalCode = "";
final teamEditingController = TextEditingController();
final nameEditingController = TextEditingController();
final departmentEditingController = TextEditingController();
final birthEditingController = TextEditingController();
final genderEditingController = TextEditingController();
final payNumberEditingController = TextEditingController();
final payNumberTwoEditingController = TextEditingController();

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({Key? key}) : super(key: key);
  @override
  State<_ProfileForm> createState() => __ProfileFormState();
}

class __ProfileFormState extends State<_ProfileForm> {
  dynamic _value = 1;

  String signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
  String signBottomSubmitText = "결재 비밀번호가 일치합니다.";

  final bool _islabel = false;

  String? male = "남성";
  String? female = "여성";

  bool _isVisibleT = false;
  bool _isVisible = false;
  bool _isBirth = false;
  bool _isName = false;
  bool _isTeam = false;
  bool _isGender = false;
  bool _ispayNumber = false;

  onBirthChanged(String birth) {
    setState(() {
      if (birth.isEmpty &&
          birthEditingController.text.isEmpty &&
          nameEditingController.text.isEmpty &&
          departmentEditingController.text.isEmpty) {
        _isBirth = false;
      } else if (!birth.isNum && !birthEditingController.text.isNum) {
        _isBirth = false;
      } else if (birth.length >= 8 &&
          birthEditingController.text.length >= 8 &&
          nameEditingController.text.isNotEmpty &&
          departmentEditingController.text.isNotEmpty) {
        _isBirth = true;
      }
    });
  }

  onNumberChanged(String password) {
    setState(() {
      _ispayNumber = false;
      if (password.isEmpty || !password.isNumericOnly) {
        signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
      } else if (payNumberEditingController.text !=
          payNumberTwoEditingController.text) {
        signBottomText = "결재 비밀번호가 틀립니다.";
        _ispayNumber = false;
      } else if (payNumberEditingController.text ==
              payNumberTwoEditingController.text ||
          password.length == 6 ||
          password.isNumericOnly) {
        _ispayNumber = true;
      } else if (payNumberEditingController.value !=
              payNumberTwoEditingController.value &&
          password.length > 6 &&
          password.length < 6) {
        _ispayNumber = false;
      }
    });
  }

  onNextButton() {
    setState(() {
      if (nameEditingController.text.isEmpty) {
        _isName = false;
      } else if (nameEditingController.text.isNotEmpty) {
        _isName = true;
      }
      if (teamEditingController.text.isEmpty) {
        _isTeam = false;
      } else if (teamEditingController.text.isNotEmpty) {
        _isTeam = true;
      }
      if (birthEditingController.text.isEmpty) {
        _isBirth = false;
      } else if (birthEditingController.text.isNotEmpty) {
        _isBirth = true;
      }
      if (_value.toString().isEmpty) {
        _isGender = false;
      } else if (_value.toString().isNotEmpty) {
        _isGender = true;
      }
      if (_isName == true &&
          _isTeam == true &&
          _isBirth == true &&
          _isGender == true) {
        _ispayNumber = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const StepTwo(
                padding: EdgeInsets.only(top: 30, bottom: 30),
              ),
              Container(
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 760),
                height: 760,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(height: 12),
                        const StepTitle(
                          titletext: "프로필 정보를 입력해 주세요.",
                        ),
                        const SizedBox(height: 24),
                        CustomTextFieldForm(
                          controller: nameEditingController,
                          autofillhints: const [AutofillHints.name],
                          mainText: Text(
                            "이름",
                            style: TextStyles.explainM,
                          ),
                          hintText: "   이름",
                          obscureText: false,
                          textInputType: TextInputType.name,
                          borderColor: ColorSchemes.gray300,
                          onChange: (value) {
                            onNextButton();
                          },
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "소속",
                            style: TextStyles.explainM,
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          onChanged: (team) {
                            team = teamEditingController.text;
                            onNextButton();
                          },
                          controller: teamEditingController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: _islabel ? department : "   소속",
                            hintStyle: TextStyles.contentM.copyWith(
                                color: ColorSchemes.gray400,
                                fontFamily: Fonts.notoSansKR),
                            suffixIcon: TextButton(
                              onPressed: () {
                                pageController.jumpToPage(5);
                              },
                              child: Text("소속 찾기",
                                  style: TextStyles.contentM
                                      .copyWith(color: ColorSchemes.red)),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorSchemes.gray300),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorSchemes.orangeMain,
                              ),
                            ),
                          ),
                        ),
                        CustomTextFieldForm(
                          controller: departmentEditingController,
                          autofillhints: const [AutofillHints.name],
                          borderColor: ColorSchemes.gray300,
                          mainText: Text(
                            "직급/직책",
                            style: TextStyles.explainM,
                          ),
                          hintText: "   직급/직책",
                          obscureText: false,
                          textInputType: TextInputType.text,
                          onChange: (value) {
                            onNextButton();
                          },
                        ),
                        const SizedBox(height: 5),
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
                                        controller: birthEditingController,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: "20020202",
                                          hintStyle: TextStyles.contentM
                                              .copyWith(
                                                  color: ColorSchemes.gray400,
                                                  fontFamily: Fonts.notoSansKR),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Radio(
                                          activeColor: ColorSchemes.red,
                                          value: male!,
                                          groupValue: _value,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          },
                                        ),
                                        Text(male!),
                                        Radio(
                                          activeColor: ColorSchemes.red,
                                          value: female!,
                                          groupValue: _value,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          },
                                        ),
                                        Text(female!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          borderColor: _ispayNumber
                              ? ColorSchemes.gray300
                              : ColorSchemes.red,
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
                          borderColor: _ispayNumber
                              ? ColorSchemes.gray300
                              : ColorSchemes.red,
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
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _ispayNumber
                                ? signBottomSubmitText
                                : signBottomText,
                            style: TextStyles.explainM,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LargeButton(
                          backgroundColor: _ispayNumber
                              ? ColorSchemes.orangeMain
                              : ColorSchemes.gray300,
                          borderRadius: 10,
                          width: Get.width,
                          onPressed: _ispayNumber
                              ? () {
                                  if (_ispayNumber == true) {
                                    name = nameEditingController.text;
                                    department = teamEditingController.text;
                                    department =
                                        departmentEditingController.text;
                                    dateOfBirth = birthEditingController.text;
                                    approvalCode =
                                        payNumberTwoEditingController.text;
                                    gender = _value.toString();
                                    pageController.jumpToPage(2);
                                  }
                                }
                              : () {
                                  null;
                                },
                          child: Text("다음",
                              style: TextStyles.buttonMdM.copyWith(
                                  color: _ispayNumber
                                      ? ColorSchemes.black1
                                      : ColorSchemes.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? bloodType = "$typeOne $typeTwo";
String? typeOne = "";
String? typeTwo = "";

class _BloodForm extends StatefulWidget {
  const _BloodForm({Key? key}) : super(key: key);
  @override
  State<_BloodForm> createState() => _BloodFormState();
}

class _BloodFormState extends State<_BloodForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isBlood = false;

  dynamic _value = 0;
  dynamic _valueTwo = 0;
  String? rhP = "RH+";
  String? rhM = "RH-";
  String? dont = "모름";
  String? a = "A";
  String? b = "B";
  String? ab = "AB";
  String? o = "O";

  onBloodChanged() {
    setState(() {
      if (_value != null && _valueTwo != null) {
        _isBlood = true;
      } else if (_value == 0 || _valueTwo == 0) {
        _isBlood = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const StepThree(
                padding: EdgeInsets.only(top: 30, bottom: 30),
              ),
              Container(
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 760),
                height: 760,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: Form(
                      key: _formKey,
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("./assets/images/warning.png"),
                                const SizedBox(width: 10),
                                const Text(
                                  "안전사고시",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 35),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                text: "빠른대처를 위해 ",
                                style: TextStyles.subTitleB,
                                children: [
                                  TextSpan(
                                      text: "혈액형",
                                      style: TextStyles.subTitleB
                                          .copyWith(color: ColorSchemes.red)),
                                  const TextSpan(text: "을 알려주세요"),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 140,
                              child: Image.asset(
                                  "./assets/images/medical_care.png"),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RH",
                                      style: TextStyles.explainM,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "1개 선택해 주세요.",
                                      style: TextStyles.caption
                                          .copyWith(color: ColorSchemes.red),
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
                                      value: rhP!,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      rhP!,
                                      style: TextStyles.smallTitleM,
                                    ),
                                    Radio(
                                      activeColor: ColorSchemes.red,
                                      value: rhM!,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      rhM!,
                                      style: TextStyles.smallTitleM,
                                    ),
                                    Radio(
                                      activeColor: ColorSchemes.red,
                                      value: dont!,
                                      groupValue: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                    Text(dont!, style: TextStyles.smallTitleM),
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
                                      style: TextStyles.explainM,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "1개 선택해 주세요.",
                                      style: TextStyles.caption
                                          .copyWith(color: ColorSchemes.red),
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
                            ),
                            const SizedBox(height: 24),
                            LargeButton(
                              backgroundColor: _isBlood
                                  ? ColorSchemes.orangeMain
                                  : ColorSchemes.gray300,
                              borderRadius: 10,
                              width: Get.width,
                              onPressed: _isBlood
                                  ? () {
                                      typeOne = _value.toString();
                                      typeTwo = _valueTwo.toString();
                                      pageController.jumpToPage(3);
                                    }
                                  : () {
                                      null;
                                    },
                              child: Text(
                                "다음",
                                style: TextStyles.buttonMdM.copyWith(
                                    color: _isBlood
                                        ? ColorSchemes.black1
                                        : ColorSchemes.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitPage extends StatefulWidget {
  const _SubmitPage({Key? key}) : super(key: key);

  @override
  State<_SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<_SubmitPage> {
  final bool _isSubmit = false;

  static get user => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 542),
            width: 500,
            height: 542,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StepTitle(
                    titletext: "안녕하세요!",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "계정 가입이 완료되었습니다.",
                    style: TextStyles.contentM,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "TIMWORK",
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.orangeMain),
                      children: [
                        TextSpan(
                          text: "와 함께 건설 안전과 품질을 지켜나가요.",
                          style: TextStyles.contentM
                              .copyWith(color: ColorSchemes.black1),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 10),
                    width: 100,
                    height: 100,
                    child: Image.asset("./assets/images/info_profile.png"),
                  ),
                  Text(email!, style: TextStyles.subTitleB),
                  const SizedBox(
                    height: 50,
                  ),
                  LargeButton(
                    onPressed: () {
                      Get.offAllNamed("/login");
                      // UserController.to.signup(
                      //     email: email!,
                      //     password: password!,
                      //     user: User(
                      //         approvalCode: approvalCode,
                      //         bloodType: bloodType,
                      //         companyId: companyId,
                      //         countryId: countryId,
                      //         dateOfBirth: dateOfBirth,
                      //         department: department,
                      //         email: email,
                      //         gender: gender,
                      //         name: name,
                      //         password: password,
                      //         phoneNumber: phoneNumber));
                      // print(
                      //     "유저 정보 : ${UserController.to.user!.name} ${UserController.to.user!.phoneNumber}");
                    },
                    borderRadius: 5,
                    child: Text(
                      "시작하기",
                      style: TextStyles.buttonMdM.copyWith(
                          color: _isSubmit
                              ? ColorSchemes.black1
                              : ColorSchemes.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// teamSearch Page
class _TeamSearchPage extends StatefulWidget {
  const _TeamSearchPage({Key? key}) : super(key: key);

  @override
  State<_TeamSearchPage> createState() => __TeamSearchPageState();
}

class __TeamSearchPageState extends State<_TeamSearchPage> {
  final searchEditingController = TextEditingController();
  String searchSubmit = "검색 결과";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.white,
      body: Center(
        child: Card(
          elevation: 5,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 300),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 343,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "소속 검색",
                          style: TextStyles.contentM,
                        ),
                        IconButton(
                          onPressed: () {
                            pageController.jumpToPage(1);
                          },
                          icon: const Icon(FlutterRemix.close_fill),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 343,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: ColorSchemes.white,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(width: 1, color: ColorSchemes.orangeMain),
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
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: GestureDetector(
                          onTap: () {
                            setState(() {
                              searchEditingController.text = searchSubmit;
                              teamEditingController.text =
                                  searchEditingController.text;
                            });
                            pageController.jumpToPage(1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("$searchSubmit $index"),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SmallButton(
                      backgroundColor: ColorSchemes.red,
                      onPressed: () {
                        pageController.jumpToPage(1);
                      },
                      child: Text(
                        "확인",
                        style: TextStyles.contentM
                            .copyWith(color: ColorSchemes.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  const _TopIcon({
    Key? key,
    this.oneIcon,
    this.twoIcon,
    this.threeIcon,
    this.oneLineColor,
    this.twoLineColor,
    this.stepOneColor,
    this.stepTwoColor,
    this.stepThreeColor,
  }) : super(key: key);
  final Icon? oneIcon;
  final Icon? twoIcon;
  final Icon? threeIcon;
  final Color? oneLineColor;
  final Color? twoLineColor;
  final Color? stepOneColor;
  final Color? stepTwoColor;
  final Color? stepThreeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(child: oneIcon),
              Text(
                "STEP 1",
                style: TextStyles.caption.copyWith(color: stepOneColor),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 14),
            width: 130,
            height: 1,
            color: oneLineColor,
          ),
          Column(
            children: [
              Container(
                child: twoIcon,
              ),
              Text(
                "STEP 2",
                style: TextStyles.caption.copyWith(color: stepTwoColor),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 14),
            width: 130,
            height: 1,
            color: twoLineColor,
          ),
          Column(
            children: [
              Container(
                child: threeIcon,
              ),
              Text(
                "STEP 3",
                style: TextStyles.caption.copyWith(color: stepThreeColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Step One Two Three
// Refactory

class StepOne extends StatelessWidget {
  const StepOne({Key? key, this.padding}) : super(key: key);
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: 390,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              _TopIcon(
                oneIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                oneLineColor: ColorSchemes.gray300,
                stepOneColor: ColorSchemes.black1,
                twoIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.gray300,
                ),
                twoLineColor: ColorSchemes.gray300,
                stepTwoColor: ColorSchemes.gray300,
                threeIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.gray300,
                ),
                stepThreeColor: ColorSchemes.gray300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepTwo extends StatelessWidget {
  const StepTwo({Key? key, this.padding}) : super(key: key);
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: 390,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              _TopIcon(
                oneIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_fill,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                oneLineColor: ColorSchemes.red,
                stepOneColor: ColorSchemes.red,
                twoIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                twoLineColor: ColorSchemes.gray300,
                stepTwoColor: ColorSchemes.black1,
                threeIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.gray300,
                ),
                stepThreeColor: ColorSchemes.gray300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StepThree extends StatelessWidget {
  const StepThree({Key? key, this.padding}) : super(key: key);
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: 390,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              _TopIcon(
                oneIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_fill,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                oneLineColor: ColorSchemes.red,
                stepOneColor: ColorSchemes.red,
                twoIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_fill,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                twoLineColor: ColorSchemes.red,
                stepTwoColor: ColorSchemes.red,
                threeIcon: Icon(
                  FlutterRemix.checkbox_blank_circle_line,
                  size: 12,
                  color: ColorSchemes.red,
                ),
                stepThreeColor: ColorSchemes.black1,
              ),
            ],
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
