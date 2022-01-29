import 'package:finance_tracker/analytics/analytics_repository.dart';
import 'package:finance_tracker/app/repository/auth_repository.dart';
import 'package:finance_tracker/app/repository/user_code_repo.dart';
import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/bloc/auth/auth_bloc.dart';
import 'package:finance_tracker/bloc/auth/password_bloc.dart';
import 'package:finance_tracker/resources/resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TextFieldType { password, email, repeatPassword }

/// @example [0,1,2,3,4,5] 0 - fist 1,2,3,4 - middle, 5 -last
enum TextFieldPosition { first, last, middle }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    AppAnalyticsRepository().screenTracking(AppRoutes.signUpRoute);/// TODO: remade that
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    /// REFACTOR THIS PART
    return WillPopScope(
      onWillPop: () async {
        debugPrint('wil');
        _controller.animateTo(0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate);
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        return true;
      },
      child: BlocProvider(
        create: (_) => SignUpCubit(UserRepo(),AuthRepository()),
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              child: SizedBox(
                width: double.infinity,
                height: _height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopNavigation(
                      headerText: 'Sign Up',
                      isBlack: true,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _FormWrapper(
                            controller: _controller,
                          ),
                        )),
                    const _PrivacyPoliceWrapper(),
                    const Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: _SignUpButtonsWrapper())),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormWrapper extends StatefulWidget {
  final ScrollController controller;

  const _FormWrapper({Key? key, required this.controller}) : super(key: key);

  @override
  __FormWrapperState createState() => __FormWrapperState();
}

class __FormWrapperState extends State<_FormWrapper> {

 late final  FocusNode _emailFocus;
 late final  FocusNode _passwordFocus;
 late final  FocusNode _rePasswordFocus;

 @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _rePasswordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _rePasswordFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FieldWrapper(
            currentFocus: _emailFocus,
            nextFocus: _passwordFocus,
            type: TextFieldType.email,
            position: TextFieldPosition.first,
            controller: widget.controller,
            action: _signUpCubit.updateEmail,
          ),
          _FieldWrapper(
              currentFocus: _passwordFocus,
              nextFocus: _rePasswordFocus,
              controller: widget.controller,
              type: TextFieldType.password,
              action: _signUpCubit.updatePassword,
              position: TextFieldPosition.last),
          _FieldWrapper(
            currentFocus: _rePasswordFocus,
            action: _signUpCubit.updateRePassword,
            type: TextFieldType.repeatPassword,
            position: TextFieldPosition.last,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}

/// use it to wrap all available field
class _FieldWrapper extends StatefulWidget {
  final TextFieldType type;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final TextFieldPosition position;
  final ScrollController? controller;
  final void Function(String) action;

  const _FieldWrapper(
      {Key? key, this.controller,
        required this.currentFocus,
        required this.action,
        this.nextFocus,
        required this.type, required this.position})
      : super(key: key);

  @override
  _FieldWrapperState createState() => _FieldWrapperState();
}

class _FieldWrapperState extends State<_FieldWrapper> {
  late TextEditingController _controller;
  bool _needShow = true;

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
    final _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return BlocConsumer<PasswordCubit, PasswordBlocState>(listener: (_, state) {
      if (state is HidePassword) {
        _needShow = true;
      }
      if (state is ShowPassword) {
        _needShow = false;
      }
    }, builder: (_, state) {
      return TextField(
        focusNode: widget.currentFocus,
        obscureText: _needShow &&
            (widget.type == TextFieldType.password ||
                widget.type == TextFieldType.repeatPassword),
        enableSuggestions: false,
        autocorrect: false,
        onTap: () {
          if (widget.type == TextFieldType.email) {
            widget.controller?.animateTo(0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
          } else if (widget.type == TextFieldType.repeatPassword) {
            widget.controller?.animateTo(
                widget.controller!.position.maxScrollExtent,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
          } else {
            widget.controller?.animateTo(
                widget.controller!.position.maxScrollExtent / 2,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
          }
        },
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: false,
          selectAll: true,
        ),
        decoration: InputDecoration(
          fillColor: AppColor.baseLight[60],
          hoverColor: AppColor.baseLight[60],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.baseLight[60]!, width: 2.0),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.baseLight[60]!, width: 2.0),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.violet[100]!, width: 2.0),
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: widget.type == TextFieldType.email ? 'Email' : 'Password',
          suffixIcon: widget.type == TextFieldType.repeatPassword
              ? const _HideIcon()
              : const SizedBox(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        minLines: 1,
        maxLines: 1,
        onChanged: widget.action,
        onSubmitted: (value){
          widget.currentFocus.unfocus();
          FocusScope.of(context).requestFocus(widget.nextFocus);
          if(widget.nextFocus == null){
            widget.controller?.animateTo(0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
          }
        },
        controller: _controller,
      );
    });
  }
}

/// [_PrivacyPolice] use
class _PrivacyPoliceWrapper extends StatelessWidget {
  const _PrivacyPoliceWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: const [
          _CheckBox(),
          Expanded(child: _PrivacyText()),

          /// TODO: added text
          /// TODO: added link
        ],
      ),
    );
  }
}

class _PrivacyText extends StatelessWidget {
  const _PrivacyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _style = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    );
    final _linkStyle = TextStyle(
      color: AppColor.violet[100],
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return RichText(
      text: TextSpan(
        style: _style,
        children: <TextSpan>[
          const TextSpan(text: 'By signing up, you agree to the '),
          TextSpan(
              text: 'Terms of Service  and Privacy Policy',
              style: _linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
        ],
      ),
    );
  }
}

class _CheckBox extends StatefulWidget {
  const _CheckBox({Key? key}) : super(key: key);

  @override
  __CheckBoxState createState() => __CheckBoxState();
}

class __CheckBoxState extends State<_CheckBox> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      activeColor: AppColor.violet[100],
      checkColor: Colors.white,
      hoverColor: AppColor.violet[100],
      tristate: false,
      value: isAgree,
      onChanged: (status) {
        if (status != null) {
          isAgree = status;
          setState(() {});
        }
      },
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
    final _signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return  AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 300),
      child: FillButton(
        needPadding: false,
        action: _signUpCubit.signUpClick,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Or with',
        style: _style,
      ),
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
        padding: const EdgeInsets.symmetric(vertical: 14),
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
          widthFactor: 0.6,
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
    final _action = BlocProvider.of<PasswordCubit>(context);
    return Transform.scale(
      scale: 0.6,
      child: GestureDetector(
        onTap: () => _action.showPassword(),
        child: SvgPicture.asset(
          AppIcons.show,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
