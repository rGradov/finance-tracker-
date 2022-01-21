import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:finance_tracker/resources/resources.dart';
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
            Expanded(flex: 4, child: _FormWrapper()),
            Spacer(
              flex: 2,
            )
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
      // textInputAction: widget.position == TextFieldPosition.last
      //     ? TextInputAction.send
      //     : TextInputAction.continueAction,
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
      children: [
        /// TODO: added checkbox
        /// TODO: added text
        /// TODO: added link
      ],
    );
  }
}
/// use it to wrap all action button's in signUp screen
/// like [_SignUpButton] && [_SignUpGoogleButton] && [_AlreadyHaveAccount]
class _SignUpButtonsWrapper extends StatelessWidget {
  const _SignUpButtonsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// [_OrWith] use it like separator between buttons
class _OrWith extends StatelessWidget {
  const _OrWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
/// use it if user have an account
class _AlreadyHaveAccount extends StatelessWidget {
  const _AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class _SignUpGoogleButton extends StatelessWidget {
  const _SignUpGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
