import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lkctc_student_app/constants/colors.dart';

import '../../../widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static final List<_SettingsTileModal> _settingTiles = [
    _SettingsTileModal(
      color: kSubjectColors[14],
      iconData: Icons.wb_sunny_outlined,
      title: 'Theme',
      onTap: () {},
    ),
    _SettingsTileModal(
      color: kSubjectColors[0],
      iconData: Icons.help_outline_outlined,
      title: 'FAQs',
      onTap: () {},
    ),
    _SettingsTileModal(
      color: kSubjectColors[9],
      iconData: Icons.info_outlined,
      title: 'About',
      onTap: () {},
    ),
    _SettingsTileModal(
      color: kSubjectColors[5],
      iconData: Icons.support_agent_outlined,
      title: 'Help & Support',
      onTap: () {},
    ),
    _SettingsTileModal(
      color: kErrorColor,
      iconData: Icons.logout_outlined,
      title: 'Log Out',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Settings'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label('Account', style: Get.textTheme.subtitle1),
              const _ProfileTile(),
              const SizedBox(height: 16),
              Label('Settings', style: Get.textTheme.subtitle1),
              const SizedBox(height: 16),
              for (_SettingsTileModal settingsModal in _settingTiles) ...[
                _SettingsTile(settingsModal: settingsModal)
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    Key? key,
    required this.settingsModal,
  }) : super(key: key);

  final _SettingsTileModal settingsModal;

  @override
  Widget build(BuildContext context) {
    return TapHandler(
      onTap: settingsModal.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: settingsModal.color.withOpacity(0.2),
                child: Center(
                  child: Icon(
                    settingsModal.iconData,
                    color: settingsModal.color,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Label(
                settingsModal.title,
                style: Get.textTheme.subtitle1,
              ),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: kPrimaryColor,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label('Jatin', style: Get.textTheme.headline6),
              const SizedBox(height: 4),
              Label('Personal Info', style: Get.textTheme.bodyText2),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _SettingsTileModal {
  final Color color;
  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  const _SettingsTileModal({
    required this.color,
    required this.iconData,
    required this.title,
    required this.onTap,
  });
}
