import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/common/widgets/animatedBackground.dart';
import 'package:tictac/src/common/widgets/textHeading.dart';
import 'package:tictac/src/common/widgets/textStyle.dart';
import 'package:tictac/src/const/resource.dart';
import 'package:tictac/src/pages/Settings/controller/settings_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int selectedTheme = 0;

  // List of Themes background photos to be displayed
  final List<String> _themeImages = [R.woodenbg, R.glassbg, R.blackbg];

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    return Scaffold(
      body: AnimatedBackground(
        child: Padding(
          padding: EdgeInsets.only(top: 300.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // This will handle the sound settings
                  // toggle button to turn on or off the sound
                  TextHeading(
                      style: appStyle(15, Colors.white, FontWeight.w600),
                      text: "Sound",
                      maxLine: 1),
                  Switch(
                    value: settingsController.isSoundEnable,
                    onChanged: (value) async {
                      await settingsController.toggleSound(value);
                      setState(() {});
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.blueGrey,
                  )
                ],
              ),
              SizedBox(height: 20),

              // This will handle the theme settings of the app
              TextHeading(
                  style: appStyle(15, Colors.white, FontWeight.w600),
                  text: "Theme",
                  maxLine: 1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _themeImages.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        // Change the theme
                        settingsController.setTheme(index);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_themeImages[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
