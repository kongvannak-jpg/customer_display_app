import 'package:customer_display_app/screens/routes/route_names.dart';
import 'package:customer_display_app/widgets/buttons/btn_hover_primary_widget.dart';
import 'package:customer_display_app/widgets/container/shadow_container_widget.dart';
import 'package:customer_display_app/widgets/text/title_lg_widget.dart';
import 'package:customer_display_app/widgets/text/title_md_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginByQrScreen extends StatefulWidget {
  const LoginByQrScreen({super.key});

  @override
  State<LoginByQrScreen> createState() => _LoginByQrScreenState();
}

class _LoginByQrScreenState extends State<LoginByQrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                          GoRouter.of(context).go(RouteNames.loginPATH);
                        },
                        icon: Icons.qr_code,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TitleMdWidget(text: 'Scan to login'),
                  SizedBox(height: 10),
                  Center(
                    child: Icon(
                      Icons.qr_code_2,
                      size: 200,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
