import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';
import 'package:lkctc_student_app/constants/colors.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  static Color buttonColor = Colors.green;
  static int selectedIndex = 0;

  static ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Button(
                label: 'Small',
                onTap: () {},
                buttonSize: ButtonSize.small,
              ),
              Button.secondary(
                label: 'Small',
                onTap: () {},
                buttonSize: ButtonSize.small,
              ),
              Button.outlined(
                label: 'Small',
                onTap: () {},
                buttonSize: ButtonSize.small,
              ),
              Button(
                label: 'Medium',
                onTap: () {},
                buttonSize: ButtonSize.medium,
              ),
              Button.secondary(
                label: 'Medium',
                onTap: () {},
                buttonSize: ButtonSize.medium,
              ),
              Button.outlined(
                label: 'Medium',
                onTap: () {},
                buttonSize: ButtonSize.medium,
              ),
              Button(
                label: 'Large',
                onTap: () {},
                buttonSize: ButtonSize.large,
              ),
              Button.secondary(
                label: 'Large',
                onTap: () {},
                buttonSize: ButtonSize.large,
              ),
              Button.outlined(
                label: 'Large',
                onTap: () {},
                buttonSize: ButtonSize.large,
              ),
              Button(
                label: 'Get Color',
                buttonColor: buttonColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Select Color'),
                      content: SizedBox(
                        height: size.height * 0.3,
                        width: size.width * 0.7,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: subjectColors.length,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: subjectColors[index],
                              ),
                              child: selectedIndex == index
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Button.secondary(
                          label: 'Cancel',
                          onTap: () => Navigator.pop(context),
                        ),
                        Button(
                          label: 'Select',
                          onTap: () {
                            setState(() {
                              buttonColor = subjectColors[selectedIndex];
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        navBarItems: [
          BottomNavBarItem(icon: Icons.dashboard_rounded),
          BottomNavBarItem(icon: Icons.note_alt_rounded),
          BottomNavBarItem(icon: Icons.calendar_today_rounded),
          BottomNavBarItem(icon: Icons.settings_rounded),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                themeController.changeTheme(ThemeMode.light);
              },
              label: const Text('Light Theme'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                themeController.changeTheme(ThemeMode.dark);
              },
              label: const Text('Dark Theme'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                themeController.changeTheme(ThemeMode.system);
              },
              label: const Text('System Theme'),
            ),
          ),
        ],
      ),
    );
  }
}
