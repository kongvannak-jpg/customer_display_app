import 'package:customer_display_app/screens/routes/route_names.dart';
import 'package:customer_display_app/widgets/buttons/btn_hover_primary_widget.dart';
import 'package:customer_display_app/widgets/buttons/btn_primary_widget.dart';
import 'package:customer_display_app/widgets/container/shadow_container_widget.dart';
import 'package:customer_display_app/widgets/form/custom_text_field.dart';
import 'package:customer_display_app/widgets/popup/create_new_account_popup_widget.dart';
import 'package:customer_display_app/widgets/text/body_lg_widget.dart';
import 'package:customer_display_app/widgets/text/title_lg_widget.dart';
import 'package:customer_display_app/widgets/text/title_md_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadowContainerWidget(
                padding: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleLgWidget(text: "Sign In"),
                        BtnHoverPrimaryWidget(
                          onPressed: () {
                            GoRouter.of(context).go(RouteNames.loginQrPATH);
                          },
                          icon: Icons.qr_code,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TitleMdWidget(text: 'Sign into your account'),
                    SizedBox(height: 10),
                    CustomTextField(
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _enteredEmail = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid password.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _enteredEmail = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    BtnPrimaryWidget(
                      text: 'Sign In',
                      borderRadius: 50,
                      widthType: ButtonWidthType.full,
                      onPressed: () {
                        GoRouter.of(context).go(RouteNames.selectedDevicePATH);
                      },
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 25),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            CreateNewAccountPopupWidget.showCreateAccountPopup(
                              context,
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: BodyLgWidget(
                              text: 'Create your free account',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(CupertinoIcons.globe, size: 25),
                        SizedBox(width: 10),
                        BodyLgWidget(text: 'Change language'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
