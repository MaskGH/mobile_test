import 'package:flutter/material.dart';

// packages
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:mobile_version/mobile/styles.dart';

enum SignupState {
  accountWrite,
  accountEmailVerify,
  accountPhoneVerify,
  accountDone,
  profileWrite,
  profileCompanySelect,
  profileDone,
  bloodTypeWrite,
  bloodTypeDone,
  done
}

class SignupPageDesktop extends StatefulWidget {
  const SignupPageDesktop({Key? key}) : super(key: key);

  @override
  _SignupPageDesktopState createState() => _SignupPageDesktopState();
}

class _SignupPageDesktopState extends State<SignupPageDesktop> {
  SignupState state = SignupState.accountWrite;
  final pageController = PageController(initialPage: 0);
  final formKey = GlobalKey<FormState>();
  bool isVisibleOne = false;
  bool isVisibleTwo = false;
  bool isPassword = false;
  bool isNumber = false;
  bool isRequest = false;
  bool isEmail = false;
  bool isNextButton = false;
  bool isPhone = false;
  bool isProfileColorTwo = false;
  bool isProfileColorOne = false;
  bool isBirth = false;
  bool isName = false;
  bool isTeam = false;
  bool isGender = false;
  bool isPayNumber = true;

  String? name;
  // String team = teamEditingController.text;
  String? position;
  String? birth;
  String? gender = "";
  String? paynumber = "";
  String? male = "남성";
  String? female = "여성";

  dynamic _value = 1;

  String mailBottomText = "메일 주소까지 입력해 주세요.";
  String passwordBottomText =
      "비밀번호는 영문 대소문자, 숫자, 특수문자(.!@#%)를 혼합하여 8~20자로 입력해 주세요.";
  String passwordText = "비밀번호가 일치합니다.";
  String number = "";
  String approvalCodeRequest = "인증요청";
  String request = "재요청";
  String requestComplete = "인증확인";
  String certification = "";
  String signBottomText = "결재 비밀번호는 숫자로 6자리 입력해 주세요.";
  String signBottomSubmitText = "결재 비밀번호가 일치합니다.";

  _buildPageView() {
    late List<Function> pages;

    _buildPageBox({
      String? title,
      Widget? child,
      bool enableNextButton = false,
    }) {
      late List<Widget> children;
      _buildTitle(String title) {
        return Text(title, style: TextStyles.title3);
      }

      _buildNextButton() {
        return LargeButton(
          borderRadius: 10,
          width: MediaQuery.of(context).size.width,
          backgroundColor:
              enableNextButton ? ColorSchemes.orangeMain : ColorSchemes.gray300,
          onPressed: () {
            if (enableNextButton) {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn);
            }
          },
          child: Text(
            "다음",
            style: TextStyles.buttonMdM.copyWith(
                color: enableNextButton
                    ? ColorSchemes.white
                    : ColorSchemes.black1),
          ),
        );
      }

      children = [
        if (title != null) _buildTitle(title),
        if (title != null && child != null) const SizedBox(height: 48),
        if (child != null) child,
        const Spacer(),
        _buildNextButton()
      ];
      return Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 760),
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        width: 500,
        height: 760,
        decoration: BoxDecoration(
          border: Border.all(color: ColorSchemes.gray200),
        ),
        child: Column(
          children: children,
        ),
      );
    }

    _buildAccountPage() {
      late List<Widget> children;
      _buildAccountForm() {
        late List<Widget> children;
        late Widget emailForm;
        late Widget passwordForm;
        late Widget phoneForm;

        emailForm = CustomTextFieldForm(
          autofillhints: const [AutofillHints.email],
          mainText: Text(
            "이메일",
            style: TextStyles.explainM.copyWith(color: ColorSchemes.black1),
          ),
          hintText: "   이메일",
          borderColor: isEmail ? ColorSchemes.gray300 : ColorSchemes.red,
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
        );
        passwordForm = Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                mailBottomText,
                style: isEmail
                    ? TextStyles.explainM
                    : TextStyles.explainM.copyWith(color: ColorSchemes.red),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFieldForm(
              mainText: Text(
                "비밀번호",
                style: TextStyles.explainM,
              ),
              hintText: "   비밀번호",
              obscureText: !isVisibleOne,
              textInputType: TextInputType.text,
              autofillhints: const [AutofillHints.newPassword],
              widget: IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleOne = !isVisibleOne;
                  });
                },
                icon: isVisibleOne
                    ? const Icon(FlutterRemix.eye_line)
                    : const Icon(FlutterRemix.eye_close_line),
              ),
              borderColor: isPassword ? ColorSchemes.gray300 : ColorSchemes.red,
            ),
            CustomTextFieldForm(
              hintText: "   비밀번호 확인",
              obscureText: !isVisibleTwo,
              textInputType: TextInputType.text,
              autofillhints: const [AutofillHints.password],
              borderColor: isPassword ? ColorSchemes.gray300 : ColorSchemes.red,
              widget: IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleTwo = !isVisibleTwo;
                  });
                },
                icon: isVisibleTwo
                    ? const Icon(FlutterRemix.eye_line)
                    : const Icon(FlutterRemix.eye_close_line),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 12, bottom: 24),
              alignment: Alignment.centerLeft,
              child: Text(
                isPassword ? passwordText : passwordBottomText,
                style: TextStyles.explainM.copyWith(
                    color: isPassword ? ColorSchemes.black1 : ColorSchemes.red),
              ),
            )
          ],
        );

        phoneForm = Column(
          children: [
            CustomTextFieldForm(
              mainText: Text(
                "전화번호",
                style: TextStyles.explainM,
              ),
              hintText: "   전화번호('ㅡ'없이",
              obscureText: false,
              textInputType: TextInputType.phone,
              autofillhints: const [AutofillHints.telephoneNumber],
              borderColor: ColorSchemes.gray300,
              widget: TextButton(
                onPressed: isPhone
                    ? () {
                        setState(() {
                          isNumber = true;
                        });
                      }
                    : null,
                child: Text(
                  isNumber ? request : certification,
                  style: TextStyles.contentM.copyWith(
                      color:
                          isNumber ? ColorSchemes.gray300 : ColorSchemes.red),
                ),
              ),
            ),
            isNumber
                ? CustomTextFieldForm(
                    hintText: " 인증번호",
                    obscureText: false,
                    autofillhints: const [AutofillHints.telephoneNumber],
                    maxLength: 6,
                    textInputType: TextInputType.number,
                    borderColor:
                        isRequest ? ColorSchemes.gray300 : ColorSchemes.red,
                    widget: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        isRequest ? "" : requestComplete,
                        style: TextStyles.contentM.copyWith(
                          color: ColorSchemes.red,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        );
        children = [emailForm, passwordForm, phoneForm];
        return Column(children: children);
      }

      children = [
        // TODO : implement indicator
        _buildPageBox(
            title: "계정 정보를 입력해 주세요.",
            child: _buildAccountForm(),
            enableNextButton: true),
      ];
      return Column(children: children);
    }

    _buildProfilePage() {
      return Column(
        children: [
          Text("Page 2"),
        ],
      );
    }

    _buildBloodTypePage() {
      return Column(
        children: [
          Text("Page 3"),
        ],
      );
    }

    _buildVerifyPage() {
      return Column(
        children: [
          Text("Page 4"),
        ],
      );
    }

    _buildCompanyPage() {
      return Column(
        children: [
          Text("Page 5"),
        ],
      );
    }

    pages = [
      () => _buildAccountPage(),
      () => _buildProfilePage(),
      () => _buildBloodTypePage(),
      () => _buildVerifyPage(),
      () => _buildCompanyPage(),
    ];

    return PageView.builder(
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) => pages[index](),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildPageView());
  }
}
