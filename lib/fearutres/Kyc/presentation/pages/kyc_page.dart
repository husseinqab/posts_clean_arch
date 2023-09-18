import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posts_clean_arch/core/widgets_helpers/decorated_text_field.dart';
import 'package:posts_clean_arch/core/widgets_helpers/rounded_button.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/kyc_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets_helpers/custom_dropdown_widget.dart';

class KycPage extends StatelessWidget {
  const KycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KycProvider(), child: const KycBody());
  }
}

class KycBody extends StatefulWidget {
  const KycBody({super.key});

  @override
  State<KycBody> createState() => _KycBodyState();
}

class _KycBodyState extends State<KycBody> with SingleTickerProviderStateMixin {
  static List<Widget> tabBarViews = <Widget>[
    const RegisterInStrigaPage(),
    const VerifyMailPage(),
    const VerifyPhonePage(),
    const UpdateUserPage()
  ];

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarViews.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KYC"),
      ),
      body: DefaultTabController(
        length: tabBarViews.length,
        child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: tabBarViews),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RoundedButton(
          title: 'Next',
          onPressed: () {

            if (_tabController.index < tabBarViews.length - 1) {
              if (_tabController.index == 0){
                context.read<KycProvider>().validateRegister(context);
                if (context.read<KycProvider>().isValidRegister()){
                  _tabController.animateTo(_tabController.index + 1);
                }
              }

              if (_tabController.index == 1){
                context.read<KycProvider>().validateEmailVCode(context);
                if (context.read<KycProvider>().isValidEmailCode()){
                  _tabController.animateTo(_tabController.index + 1);
                }
              }

              if (_tabController.index == 2){
                context.read<KycProvider>().validatePhoneVCode(context);
                if (context.read<KycProvider>().isValidPhoneCode()){
                  _tabController.animateTo(_tabController.index + 1);
                }
              }

            }
          },
        ),
      ),
    );
  }
}

class RegisterInStrigaPage extends StatelessWidget {
  const RegisterInStrigaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<KycProvider>(builder: (_, provider, child) {
        return Form(
          key: provider.registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedTextField(
                validator: provider.firstNameValidator,
                height: 20,
                corner: 10,
                hint: 'First Name',
                textChanged: (value){
                  provider.setFirstName(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                validator: provider.lastNameValidator,
                height: 20,
                corner: 10,
                hint: 'Last Name',
                textChanged: (value){
                  provider.setLastName(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                validator: provider.emailValidator,
                height: 20,
                corner: 10,
                hint: 'Email',
                textChanged: (value){
                  provider.setEmail(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                validator: provider.phoneValidator,
                height: 20,
                corner: 10,
                hint: 'Phone Number',
                textChanged: (value){
                  provider.setPhone(value);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class VerifyMailPage extends StatelessWidget {
  const VerifyMailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<KycProvider>(builder: (_,provider,child) {
        return Form(
          key: provider.emailVFormKey,
          child: Column(
            children: [
              const Text('We sent a 6 digit verification code to your mail'),
              const SizedBox(
                height: 10,
              ),
              DecoratedTextField(
                validator: provider.emailVCodeValidator,
                hint: 'Verification Code',
                corner: 10,
                height: 20,
                textChanged: (value){
                  provider.setEmailVCode(value);
                },
              )

            ],
          ),
        );
      })
    );
  }
}

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<KycProvider>(builder: (_,provider,child) {
        return Form(
          key: provider.phoneVFormKey,
          child: Column(
            children: [
              const Text('We sent a 6 digit verification code sms to your phone]'),
              const SizedBox(
                height: 10,
              ),
              DecoratedTextField(
                corner: 10,
                hint: 'Verification Code',
                height: 20,
                textChanged: (value){
                  provider.setPhoneVCode(value);
                },
              ),
            ],
          ),
        );
      })
    );
  }
}

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  String occupation = '';
  String sourceOfFunds = '';
  String purposeOfAccount = '';
  String annualIncome = '';
  String annualOutcome = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RoundedButton(
              title: 'Document issuing country',
              backgroundColor: Colors.white,
              titleColor: Colors.black,
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                  },
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              title: 'Nationality',
              backgroundColor: Colors.white,
              titleColor: Colors.black,
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                  },
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomDropDownWidget(
              dropdownValue: occupation,
              hint: 'Occupation',
              items: const ['Public Sector', 'Audit'],
              onChanged: (value) {
                setState(() {
                  occupation = value!;
                });
              },
            ),
            SizedBox(height: 20),
            CustomDropDownWidget(
              dropdownValue: sourceOfFunds,
              hint: 'Source Of funds',
              items: const ['Personal Savings', 'FamilySavings'],
              onChanged: (value) {
                setState(() {
                  sourceOfFunds = value!;
                });
              },
            ),
            SizedBox(height: 20),
            RoundedButton(
              title: 'Place Of Birth',
              backgroundColor: Colors.white,
              titleColor: Colors.black,
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                  },
                );
              },
            ),
            SizedBox(height: 20),
            CustomDropDownWidget(
              dropdownValue: annualIncome,
              hint: 'Annually Incoming transaction volume',
              items: const [
                'Between 10000 abd 15000',
                'Between 5000 and 10000'
              ],
              onChanged: (value) {
                setState(() {
                  annualIncome = value!;
                });
              },
            ),
            SizedBox(height: 20),
            CustomDropDownWidget(
              dropdownValue: annualOutcome,
              hint: 'Annually Incoming transaction volume',
              items: const [
                'Between 10000 abd 15000',
                'Between 5000 and 10000'
              ],
              onChanged: (value) {
                setState(() {
                  annualOutcome = value!;
                });
              },
            ),
            SizedBox(height: 20),
            DecoratedTextField(
              corner: 10,
              hint: 'Address Line 1',
              height: 20,
            ),
            SizedBox(height: 20),
            DecoratedTextField(
              corner: 10,
              hint: 'Address Line 2',
              height: 20,
            ),
            SizedBox(height: 20),
            DecoratedTextField(
              corner: 10,
              hint: 'City',
              height: 20,
            ),
            SizedBox(height: 20),
            DecoratedTextField(
              corner: 10,
              hint: 'Postal code',
              height: 20,
            ),
            SizedBox(height: 20),
            DecoratedTextField(
              corner: 10,
              hint: 'Province',
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              title: 'Nationality',
              backgroundColor: Colors.white,
              titleColor: Colors.black,
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    print('Select country: ${country.displayName}');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
