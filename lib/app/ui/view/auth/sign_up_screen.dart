import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TextFieldType { password, email, repeatPassword }

/// @example [0,1,2,3,4,5] 0 - fist 1,2,3,4 - middle, 5 -last
enum TextFieldPosition { first, last, middle }

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TopNavigation(
              headerText: 'Sign Up',
              isBlack: true,
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(flex: 3, child: _FormWrapper()),
            Spacer(
              flex: 1,
            ),
            _PrivacyPoliceWrapper(),
            Expanded(flex: 2, child: _SignUpButtonsWrapper()),
          ],
        ),
      ),
    );
  }
}

class _FormWrapper extends StatelessWidget {
  const _FormWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _FieldWrapper(
          type: TextFieldType.email,
          position: TextFieldPosition.first,
        ),
        _FieldWrapper(
            type: TextFieldType.password, position: TextFieldPosition.last),
        _FieldWrapper(
            type: TextFieldType.repeatPassword,
            position: TextFieldPosition.last),
      ],
    );
  }
}

/// use it to wrap all available field
class _FieldWrapper extends StatefulWidget {
  final TextFieldType type;
  final TextFieldPosition position;

  const _FieldWrapper({Key? key, required this.type, required this.position})
      : super(key: key);

  @override
  _FieldWrapperState createState() => _FieldWrapperState();
}

class _FieldWrapperState extends State<_FieldWrapper> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.type == TextFieldType.repeatPassword ||
          widget.type == TextFieldType.password,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: widget.type == TextFieldType.email ? 'Email' : 'Password',
        suffixIcon: widget.type == TextFieldType.repeatPassword
            ? const _HideIcon()
            : const SizedBox(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      ),
      minLines: 1,
      maxLines: 1,
      onChanged: (value) {},
      controller: _controller,
    );
  }
}

/// [_PrivacyPolice] use
class _PrivacyPoliceWrapper extends StatelessWidget {
  const _PrivacyPoliceWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:const [
         _CheckBox(),
       Expanded(child: _PrivacyText()),

        /// TODO: added text
        /// TODO: added link
      ],
    );
  }
}

class _PrivacyText extends StatelessWidget {
  const _PrivacyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _style = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    );
    final _linkStyle = TextStyle(
      color: AppColor.violet[100],
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
      return RichText(
        text: TextSpan(
          style: _style,
          children: <TextSpan>[
           const  TextSpan(text: 'By signing up, you agree to the '),
            TextSpan(
                text: 'Terms of Service  and Privacy Policy',
                style: _linkStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  }),
          ],
        ),
      );
  }
}
class _CheckBox extends StatelessWidget {
  const _CheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      activeColor: AppColor.violet[100],
      checkColor: AppColor.violet[100],
      hoverColor: AppColor.violet[100],
      tristate: false,
      value: false,
      onChanged: (status) {},
    );
  }
}

/// use it to wrap all action button's in signUp screen
/// like [_SignUpButton] && [_SignUpGoogleButton] && [_AlreadyHaveAccount]
class _SignUpButtonsWrapper extends StatelessWidget {
  const _SignUpButtonsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        _SignUpButton(),
        _OrWith(),
        _SignUpGoogleButton(),
        _AlreadyHaveAccountWrapper(),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 300),
      child: FillButton(
        needPadding: false,
        text: 'Sign Up',
        routeName: AppRoutes.addedNewAccount,
      ),
    );
  }
}

/// [_OrWith] use it like separator between buttons
class _OrWith extends StatelessWidget {
  const _OrWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// FIXME: added to Theme data
    final _style = TextStyle(
      color: AppColor.baseLight[20],
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    return Text(
      'Or with',
      style: _style,
    );
  }
}

/// use it if user have an account
class _AlreadyHaveAccountWrapper extends StatelessWidget {
  const _AlreadyHaveAccountWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
        color: AppColor.baseLight[20],
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: _style,
        ),
        const _LoginButton(),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      color: AppColor.violet[100]!,
      fontSize: 16,
      fontFamily: 'Inter',
      decoration: TextDecoration.underline,
    );
    final _buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.zero),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all<Color>(
        AppColor.violet[100]!.withOpacity(0.2),
      ),
    );
    return TextButton(
      onPressed: _onPress,
      child: Text(
        'login',
        style: _style,
      ),
      style: _buttonStyle,
    );
  }

  void _onPress() {}
}

class _SignUpGoogleButton extends StatelessWidget {
  const _SignUpGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      color: AppColor.baseDark[50],
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    );
    return Container(
        constraints: const BoxConstraints(maxHeight: 80, minHeight: 60),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColor.baseLight[60]!),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AppIcons.flatColorIconsGoogle),
              Text(
                'Sign Up with Google',
                style: _style,
              ),
            ],
          ),
        ));
  }
}

class _HideIcon extends StatelessWidget {
  const _HideIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// TODO: implement logic
      },
      child: SvgPicture.asset(AppIcons.show),
    );
  }
}
