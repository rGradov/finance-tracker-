import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:finance_tracker/app/ui/shared/fill_button.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/bloc/wallet/wallet_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Header == Navigation arrow? and Name
///
///AnimatedContainer ->Two DropDowns -> type? display something and change the
/// height of Animated Container
/// continue button with validations ()
///
/// */
///
/// Important to trace this account types
enum AccountTypes { wallet, creditCard, bank }

class AddedNewAccountScreen extends StatelessWidget {
  const AddedNewAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewWalletCubit(const InitialState()),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.violet[100]!,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TopNavigation(
                  headerText: 'Added new wallet',
                ),
                _BalanceInput(),
                Spacer(flex: 5,),
                SizedBox(height: 20),
                Expanded(flex: 5, child: _InputWalletData()),
                _AnimatedBodyWrapper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBodyWrapper extends StatefulWidget {
  const _AnimatedBodyWrapper({Key? key}) : super(key: key);

  @override
  State<_AnimatedBodyWrapper> createState() => _AnimatedBodyWrapperState();
}

class _AnimatedBodyWrapperState extends State<_AnimatedBodyWrapper> {
  bool _keyboardIsOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewWalletCubit, AddedNewWalletState>(
        builder: (_, state) {
      return AnimatedContainer(
          width: double.infinity,
          height: _keyboardIsOpen ? 250 : 0,
          alignment: Alignment.bottomCenter,
          duration: const Duration(microseconds: 250),
          child: const SizedBox.expand());
    }, listener: (_, state) {
      if (state is KeyboardIsOpened) {
        _keyboardIsOpen = true;
      }
    });
  }
}

/// FIXME: change my name ( make it more better )
/// it should be rounded container with dropdown and inputted field
///IMPORTANT!! DON'T USE EXPANDED IN THIS
class _InputWalletData extends StatelessWidget {
  const _InputWalletData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ConstrainedBox(
          constraints:const BoxConstraints(minHeight: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InputWalletName(),
              _DropDownAccountType(),
              _ContinueButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropDownAccountType extends StatefulWidget {
  const _DropDownAccountType({Key? key}) : super(key: key);

  @override
  _DropDownAccountTypeState createState() => _DropDownAccountTypeState();
}

class _DropDownAccountTypeState extends State<_DropDownAccountType> {
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
    final _walletCubit = BlocProvider.of<NewWalletCubit>(context);

    return TextField(
      onTap: () => _walletCubit.onTextFieldTap(),
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.green,
        filled: false,
        hintStyle: const TextStyle(color: Colors.blue, fontSize: 12),
        hintText: 'name',
      ),
    );
  }
}

class _InputWalletName extends StatefulWidget {
  const _InputWalletName({Key? key}) : super(key: key);

  @override
  __InputWalletNameState createState() => __InputWalletNameState();
}

class __InputWalletNameState extends State<_InputWalletName> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// FIXME: if this widget not provide the option to input balance value rename it
class _BalanceInput extends StatelessWidget {
  const _BalanceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textStyle = TextStyle(
        color: AppColor.baseLight[80],
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 18);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Balance', style: _textStyle),
          Text('\$00.0', style: _textStyle.copyWith(fontSize: 64)),
        ],
      ),
    );
  }
}

/// TODO: add reusable ui for this button form let's go screen
/// TODO: added opacity to validate this button
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: true ? 1 : 0.5,
      duration: const Duration(milliseconds: 250),
      child: const FillButton(
        text: 'continue',
        routeName: AppRoutes.addedNewAccount,
      ),
    );
  }
}
