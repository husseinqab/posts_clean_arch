import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posts_clean_arch/core/widgets_helpers/decorated_text_field.dart';
import 'package:posts_clean_arch/core/widgets_helpers/rounded_button.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/kyc_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets_helpers/custom_dropdown_widget.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
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
    const UpdateUserPage(),
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
            if (_tabController.index < tabBarViews.length) {
              if (_tabController.index == 0) {
                context.read<KycProvider>().validateRegister(context);
                if (context.read<KycProvider>().isValidRegister()) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              } else if (_tabController.index == 1) {
                context.read<KycProvider>().validateEmailVCode(context);
                if (context.read<KycProvider>().isValidEmailCode()) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              } else if (_tabController.index == 2) {
                context.read<KycProvider>().validatePhoneVCode(context);
                if (context.read<KycProvider>().isValidPhoneCode()) {
                  _tabController.animateTo(_tabController.index + 1);
                }
              } else if (_tabController.index == 3) {
                context.read<KycProvider>().validateUpdateData(context);
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
                textChanged: (value) {
                  provider.setFirstName(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                validator: provider.lastNameValidator,
                height: 20,
                corner: 10,
                hint: 'Last Name',
                textChanged: (value) {
                  provider.setLastName(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                validator: provider.emailValidator,
                height: 20,
                corner: 10,
                hint: 'Email',
                textChanged: (value) {
                  provider.setEmail(value);
                },
              ),
              const SizedBox(height: 10),
              DecoratedTextField(
                keyboard: TextInputType.phone,
                validator: provider.phoneValidator,
                height: 20,
                corner: 10,
                hint: 'Phone Number',
                textChanged: (value) {
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
        child: Consumer<KycProvider>(builder: (_, provider, child) {
          return Form(
            key: provider.emailVFormKey,
            child: Column(
              children: [
                const Text('We sent a 6 digit verification code to your mail'),
                const SizedBox(
                  height: 10,
                ),
                DecoratedTextField(
                  keyboard: TextInputType.number,
                  validator: provider.emailVCodeValidator,
                  maxLength: 6,
                  hint: 'Verification Code',
                  corner: 10,
                  height: 20,
                  textChanged: (value) {
                    provider.setEmailVCode(value);
                  },
                )
              ],
            ),
          );
        }));
  }
}

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<KycProvider>(builder: (_, provider, child) {
          return Form(
            key: provider.phoneVFormKey,
            child: Column(
              children: [
                const Text(
                    'We sent a 6 digit verification code sms to your phone]'),
                const SizedBox(
                  height: 10,
                ),
                DecoratedTextField(
                  keyboard: TextInputType.number,
                  validator: provider.phoneVCodeValidator,
                  corner: 10,
                  maxLength: 6,
                  hint: 'Verification Code',
                  height: 20,
                  textChanged: (value) {
                    provider.setPhoneVCode(value);
                  },
                ),
              ],
            ),
          );
        }));
  }
}

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          child: Consumer<KycProvider>(builder: (_, provider, child) {
        return Form(
          key: provider.updateDataFormKey,
          child: Column(
            children: [
              DecoratedTextField(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      provider.documentIssuingCountry = country;
                    },
                  );
                },
                validator: provider.documentIssueValidator,
                corner: 10,
                hint: 'Document Issuing Country',
                height: 20,
                controller: provider.documentIssueController,
                isReadOnly: true,
              ),
              const SizedBox(height: 20),
              DecoratedTextField(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      provider.nationality = country;
                    },
                  );
                },
                validator: provider.nationalityValidator,
                corner: 10,
                hint: 'Nationality',
                height: 20,
                controller: provider.nationalityController,
                isReadOnly: true,
              ),
              const SizedBox(height: 20),
              CustomDropDownWidget(
                validator: provider.occupationValidator,
                dropdownValue: provider.occupation,
                hint: 'Occupation',
                items: const ['Public Sector', 'Audit'],
                onChanged: (value) {
                  provider.occupation(value);
                },
              ),
              const SizedBox(height: 20),
              CustomDropDownWidget(
                validator: provider.sourceOfFundsValidator,
                dropdownValue: provider.sourceOfFunds,
                hint: 'Source Of funds',
                items: const ['Personal Savings', 'FamilySavings'],
                onChanged: (value) {
                  provider.sourceOfFunds(value);
                },
              ),
              const SizedBox(height: 20),
              DecoratedTextField(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      provider.placeOfBirth = country;
                    },
                  );
                },
                validator: provider.placeOfBirthValidator,
                corner: 10,
                hint: 'Nationality',
                height: 20,
                controller: provider.placeOfBirthController,
                isReadOnly: true,
              ),
              SizedBox(height: 20),
              CustomDropDownWidget(
                validator: provider.expectedIncomingValidator,
                dropdownValue: provider.expectedIncomingTxVolumeYearly,
                hint: provider.expectedIncomingTxVolumeYearly,
                items: const [
                  'Between 10000 abd 15000',
                  'Between 5000 and 10000'
                ],
                onChanged: (value) {
                  provider.expectedIncomingTxVolumeYearly(value);
                },
              ),
              const SizedBox(height: 20),
              CustomDropDownWidget(
                validator: provider.expectedOutgoingValidator,
                dropdownValue: provider.expectedOutgoingTxVolumeYearly,
                hint: provider.expectedOutgoingTxVolumeYearly,
                items: const [
                  'Between 10000 abd 15000',
                  'Between 5000 and 10000'
                ],
                onChanged: (value) {
                  provider.expectedOutgoingTxVolumeYearly(value);
                },
              ),
              const SizedBox(height: 20),
              DecoratedTextField(
                validator: provider.addressLine1NameValidator,
                corner: 10,
                hint: 'Address Line 1',
                height: 20,
                textChanged: (value) {
                  provider.addressLine1 = value;
                },
              ),
              SizedBox(height: 20),
              DecoratedTextField(
                validator: provider.addressLine2NameValidator,
                corner: 10,
                hint: 'Address Line 2',
                height: 20,
                textChanged: (value) {
                  provider.addressLine2 = value;
                },
              ),
              SizedBox(height: 20),
              DecoratedTextField(
                validator: provider.cityNameValidator,
                corner: 10,
                hint: 'City',
                height: 20,
                textChanged: (value) {
                  provider.city = value;
                },
              ),
              const SizedBox(height: 20),
              DecoratedTextField(
                validator: provider.postalCodeValidator,
                corner: 10,
                hint: 'Postal code',
                height: 20,
                textChanged: (value) {
                  provider.postalCode = value;
                },
              ),
              const SizedBox(height: 20),
              DecoratedTextField(
                validator: provider.provinceCodeValidator,
                corner: 10,
                hint: 'Province',
                height: 20,
                textChanged: (value) {
                  provider.province = value;
                },
              ),
              SizedBox(height: 20),
              DecoratedTextField(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      provider.country = country;
                    },
                  );
                },
                validator: provider.countryValidator,
                corner: 10,
                hint: 'Address Country',
                height: 20,
                controller: provider.countryController,
                isReadOnly: true,
              ),
              SizedBox(height: 20),
              DecoratedTextField(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
                    firstDate: DateTime(1920),
                    lastDate:  DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day)
                  );
                  if (picked != null){
                    provider.birthday = DateFormat('yyyy-MM-dd').format(picked!);
                  }
                },
                validator: provider.birthdayValidator,
                corner: 10,
                hint: 'Date of Birth',
                height: 20,
                controller: provider.birthdayController,
                isReadOnly: true,
              ),
            ],
          ),
        );
      })),
    );
  }
}
