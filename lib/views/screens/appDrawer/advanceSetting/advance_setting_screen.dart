import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/prefs_helpers.dart';
import 'package:thera_track_app/utils/app_constants.dart';
import 'package:thera_track_app/utils/style.dart';

class AdvanceSettingScreen extends StatefulWidget {
  @override
  _AdvanceSettingScreenState createState() => _AdvanceSettingScreenState();
}

class _AdvanceSettingScreenState extends State<AdvanceSettingScreen> {
  List<String> options = ['Animal', 'Human'];
  String? selectedOption;
  ProfileController _profileController=Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    _loadSelectedOption();
    SharedPreferences.getInstance().then((prefs) {
      String? selected = prefs.getString(AppConstants.selectedOption) ?? 'Human';
      print('=========> Selected Option - $selected');
    });
  }


  void _loadSelectedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString(AppConstants.selectedOption) ?? 'Human';
    });
  }


  void _saveSelectedOption(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.selectedOption, value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advance Settings', style: AppStyles.fontSize16()),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  String option = options[index];
                  return ListTile(
                    title: Text(option),
                    trailing: Radio<String>(
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          selectedOption = value;
                          _saveSelectedOption(value!);
                          _profileController.updateSelection(isHumanTrue: value!);
                          print('selected : $value');
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
