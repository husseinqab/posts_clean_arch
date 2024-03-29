import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:posts_clean_arch/core/constants/kyc_data_constants.dart';
import 'package:posts_clean_arch/core/constants/kyc_status.dart';
import 'package:posts_clean_arch/core/widgets_helpers/decorated_text_field.dart';
import 'package:posts_clean_arch/core/widgets_helpers/rounded_button.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/regsiter_striga_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/update_data_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/user_info_response.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/verify_identity_request.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_bloc.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_event.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_state.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/user_info_state.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/verify_identity_state.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/kyc_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets_helpers/custom_dropdown_widget.dart';
import '../../../../injection_container.dart ';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterInStrigaBloc>(
          create: (context) => sl<RegisterInStrigaBloc>(),
        ),
        BlocProvider<VerifyEmailBloc>(
          create: (context) => sl<VerifyEmailBloc>(),
        ),
        BlocProvider<VerifyPhoneBloc>(
          create: (context) => sl<VerifyPhoneBloc>(),
        ),
        BlocProvider<UpdateDataBloc>(
          create: (context) => sl<UpdateDataBloc>(),
        ),
        BlocProvider<UserInfoBloc>(
          create: (context) =>
          sl<UserInfoBloc>()
            ..add(const UserInfoEvent()),
        ),

      ],
      child: ChangeNotifierProvider(
          create: (_) => KycProvider(), child: const KycBody()),
    );
  }
}

class KycBody extends StatefulWidget {
  const KycBody({super.key});

  @override
  State<KycBody> createState() => _KycBodyState();
}

class _KycBodyState extends State<KycBody> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<KycProvider>()
        .tabController = TabController(
        vsync: this, length: context
        .read<KycProvider>()
        .tabBarViews
        .length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //Provider.of<KycProvider>(context).tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KycProvider>(builder: (_, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("KYC"),
        ),
        body: DefaultTabController(
          length: provider.tabBarViews.length,
          child: TabBarView(
              controller: provider.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: provider.tabBarViews),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Visibility(
            visible: provider.currentIndex != 0,
            child: RoundedButton(
              title: 'Next',
              onPressed: () {
                if (provider.tabController.index <
                    provider.tabBarViews.length) {
                  if (provider.tabController.index == 1) {
                    context.read<KycProvider>().validateRegister(context);
                    if (context.read<KycProvider>().isValidRegister()) {
                      // Trigger EVENT
                      BlocProvider.of<RegisterInStrigaBloc>(context).add(
                          RegisterInStrigaEvent(
                              request: RegisterStrigaRequest(
                                  firstName:
                                  context
                                      .read<KycProvider>()
                                      .firstName,
                                  lastName:
                                  context
                                      .read<KycProvider>()
                                      .lastName,
                                  email: context
                                      .read<KycProvider>()
                                      .email,
                                  mobile: Mobile(
                                    countryCode:
                                    context
                                        .read<KycProvider>()
                                        .countryCode,
                                    number: context
                                        .read<KycProvider>()
                                        .phone,
                                  ))));
                    }
                  } else if (provider.tabController.index == 2) {
                    context.read<KycProvider>().validateEmailVCode(context);
                    if (context.read<KycProvider>().isValidEmailCode()) {
                      BlocProvider.of<VerifyEmailBloc>(context).add(
                          VerifyEmailStrigaEvent(
                              request: VerifyIdentityRequest(
                                  userId: provider.strigaUserId,
                                  verificationId: provider.emailVCode)));
                    }
                  } else if (provider.tabController.index == 3) {
                    context.read<KycProvider>().validatePhoneVCode(context);
                    if (context.read<KycProvider>().isValidPhoneCode()) {
                      BlocProvider.of<VerifyPhoneBloc>(context).add(
                          VerifyPhoneStrigaEvent(
                              request: VerifyIdentityRequest(
                                  userId: provider.strigaUserId,
                                  verificationCode: provider.phoneVCode)));
                    }
                  } else if (provider.tabController.index == 4) {
                    context.read<KycProvider>().validateUpdateData(context);
                    BlocProvider.of<UpdateDataBloc>(context).add(
                        UpdateDataEvent(
                            request: UpdateDataRequest(
                                userId: provider.strigaUserId,
                                firstName: "KYC",
                                // Take from local storage
                                lastName: "ONE",
                                // Take from local storage
                                dateOfBirth: DateOfBirth(
                                    day: provider.birthday.day,
                                    month: provider.birthday.month,
                                    year: provider.birthday.year),
                                address: Address(
                                  addressLine1: provider.addressLine1,
                                  city: provider.city,
                                  country: provider.country,
                                  postalCode: provider.postalCode,
                                ),
                                expectedIncomingTxVolumeYearly:
                                provider.expectedIncomingTxVolumeYearly,
                                expectedOutgoingTxVolumeYearly:
                                provider.expectedOutgoingTxVolumeYearly,
                                nationality: provider.nationality,
                                occupation: provider.occupation,
                                placeOfBirth: "IRQ",
                                purposeOfAccount: "CRYPTO_PAYMENTS",
                                purposeOfAccountOther: "CRYPTO_PAYMENTS",
                                selfPepDeclaration: provider.pepSelected,
                                sourceOfFunds: provider.sourceOfFunds,
                                sourceOfFundsOther: "Something")));
                  }
                }
              },
            ),
          ),
        ),
      );
    });
  }
}

class KycStateWidget extends StatelessWidget {
  final UserInfoResponse user;

  const KycStateWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (user.kyc!.status == KycStatus.APPROVED.name) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green,),
            Text("Identity Approved")
          ],
        ),
      );
    }

    if (user.kyc!.status == KycStatus.REJECTED_FINAL.name){
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close, color: Colors.red,),
            Text("Rejected Final")
          ],
        ),
      );
    }

    if (user.kyc!.status == KycStatus.PENDING_REVIEW.name){
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review, color: Colors.blue,),
            Text("Under Review")
          ],
        ),
      );
    }

    if (user.kyc!.status == KycStatus.REJECTED.name){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning, color: Colors.orange,),
            const Text("KYC rejected due some reasons"),
            Center(
              child: ElevatedButton(onPressed: () {
                Future.microtask(
                        () => context.read<KycProvider>().checkTheRightFlow(
                        context, user));
              }, child: const Text("Try again")),
            )
          ],
        ),
      );
    }

    return const Center(
      child: Text(
        "User Loaded"
      ),
    );

  }
}


class CheckTheRightFlow extends StatefulWidget {
  const CheckTheRightFlow({super.key});

  @override
  State<CheckTheRightFlow> createState() => _CheckTheRightFlowState();
}

class _CheckTheRightFlowState extends State<CheckTheRightFlow> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///TODO CALL GET USER INFO
    return BlocListener<UserInfoBloc, UserInfoState>(
      listener: (context, state) {
        // TODO: implement listener
        Future.microtask(
                () => context.read<KycProvider>().checkTheRightFlow(
                context, state.userInfoResponse!));
      },
      child: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Collecting Data"),
                SizedBox(height: 20),
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          } else if (state is UserInfoFailed) {
            ///TODO: REMOVE LATER
            ///API shouldn't fail if user doesn't exist on striga yet
            /*Future.microtask(
                    () => context.read<KycProvider>().checkTheRightFlow(context,null));*/
            return Center(child: Text(state.message));
          } else if (state is UserInfoLoaded) {
            ///TODO: Handle better

            return KycStateWidget(user: state.userInfoResponse);
          }
          return const SizedBox();
        },
      ),
    );
    return Consumer<KycProvider>(builder: (_, provider, child) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Collecting Data"),
          SizedBox(height: 20),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    });
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
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: PhoneCodeInput(
                      onTap: () {
                        showCountryPicker(
                          exclude: KycData.unSupportedCountries,
                          context: context,
                          showPhoneCode: true,
                          // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            provider.setCountryCode(country.phoneCode);
                          },
                        );
                      },
                      validator: provider.countryCodeValidator,
                      corner: 10,
                      hint: '+00',
                      height: 20,
                      controller: provider.countryCodeController,
                      isReadOnly: true,
                    ),
                  ),
                  Expanded(
                    child: DecoratedTextField(
                      keyboard: TextInputType.phone,
                      validator: provider.phoneValidator,
                      height: 20,
                      corner: 10,
                      hint: 'Phone Number',
                      textChanged: (value) {
                        provider.setPhone(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocListener<RegisterInStrigaBloc, RegisterStrigaState>(
                  listener: (context, state) {
                    if (state is RegisterStrigaLoaded) {
                      provider.moveToVerifyEmail(
                          context, state.registerStrigaResponse);
                    }
                  },
                  child: BlocBuilder<RegisterInStrigaBloc, RegisterStrigaState>(
                    builder: (context, state) {
                      if (state is RegisterStrigaLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is RegisterStrigaFailed) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ))
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
                ),
                const SizedBox(height: 20),
                BlocListener<VerifyEmailBloc, VerifyIdentityState>(
                    listener: (context, state) {
                      if (state is VerifyIdentityLoaded) {
                        provider.moveToVerifyPhone(context);
                      }
                    }, child: BlocBuilder<VerifyEmailBloc, VerifyIdentityState>(
                  builder: (context, state) {
                    if (state is VerifyIdentityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is VerifyIdentityFailed) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ))
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
                const SizedBox(height: 20),
                BlocListener<VerifyPhoneBloc, VerifyIdentityState>(
                    listener: (context, state) {
                      if (state is VerifyIdentityLoaded) {
                        provider.moveToUpdateData(context);
                      }
                    }, child: BlocBuilder<VerifyPhoneBloc, VerifyIdentityState>(
                  builder: (context, state) {
                    if (state is VerifyIdentityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is VerifyIdentityFailed) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ))
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
                  /* DecoratedTextField(
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
            const SizedBox(height: 20),*/
                  DecoratedTextField(
                    suffixIcon: SuffixIcon.address,
                    validator: provider.addressLine1NameValidator,
                    corner: 10,
                    hint: 'Address Line 1',
                    height: 20,
                    textChanged: (value) {
                      provider.setAddressLine1(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    suffixIcon: SuffixIcon.address,
                    //validator: provider.addressLine2NameValidator,
                    corner: 10,
                    hint: 'Address Line 2',
                    height: 20,
                    textChanged: (value) {
                      provider.setAddressLine2(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    suffixIcon: SuffixIcon.city,
                    validator: provider.cityNameValidator,
                    corner: 10,
                    hint: 'City',
                    height: 20,
                    textChanged: (value) {
                      provider.setCity(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    validator: provider.postalCodeValidator,
                    corner: 10,
                    hint: 'Postal code',
                    height: 20,
                    textChanged: (value) {
                      provider.setPostalCode(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    validator: provider.provinceCodeValidator,
                    corner: 10,
                    hint: 'Province',
                    height: 20,
                    textChanged: (value) {
                      provider.setProvince(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    suffixIcon: SuffixIcon.place,
                    onTap: () {
                      showCountryPicker(
                        exclude: KycData.unSupportedCountries,
                        context: context,
                        showPhoneCode: false,
                        // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          provider.setCountry(country);
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
                  const SizedBox(height: 20),
                  const Divider(color: Colors.black, thickness: 1),
                  const SizedBox(height: 10),
                  DecoratedTextField(
                    onTap: () {
                      showCountryPicker(
                        exclude: KycData.unSupportedCountries,
                        context: context,
                        showPhoneCode: false,
                        // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          provider.setNationality(country);
                        },
                      );
                    },
                    validator: provider.nationalityValidator,
                    corner: 10,
                    hint: 'Nationality',
                    height: 20,
                    controller: provider.nationalityController,
                    isReadOnly: true,
                    suffixIcon: SuffixIcon.place,
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime
                              .now()
                              .year - 18,
                              DateTime
                                  .now()
                                  .month, DateTime
                                  .now()
                                  .day),
                          firstDate: DateTime(1920),
                          lastDate: DateTime(DateTime
                              .now()
                              .year - 18,
                              DateTime
                                  .now()
                                  .month, DateTime
                                  .now()
                                  .day));
                      if (picked != null) {
                        provider.setBirthday(picked);
                      }
                    },
                    validator: provider.birthdayValidator,
                    corner: 10,
                    hint: 'Date of Birth',
                    height: 20,
                    controller: provider.birthdayController,
                    isReadOnly: true,
                    suffixIcon: SuffixIcon.birthday,
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownWidget(
                    validator: provider.occupationValidator,
                    dropdownValue: provider.occupation,
                    hint: 'Occupation',
                    items: KycData.occupations,
                    onChanged: (value) {
                      provider.setOccupation(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownWidget(
                    validator: provider.purposeOfAccountValidator,
                    dropdownValue: provider.purposeOfAccount,
                    hint: 'Purpose of account',
                    items: KycData.purposeOfAccount,
                    onChanged: (value) {
                      provider.setOccupation(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownWidget(
                    validator: provider.sourceOfFundsValidator,
                    dropdownValue: provider.sourceOfFunds,
                    hint: 'Source Of funds',
                    items: KycData.sourceOfFunds,
                    onChanged: (value) {
                      provider.setSourceOfFunds(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    onTap: () {
                      showCountryPicker(
                        exclude: KycData.unSupportedCountries,
                        context: context,
                        showPhoneCode: false,
                        // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          provider.setPlaceOfBirth(country);
                        },
                      );
                    },
                    validator: provider.placeOfBirthValidator,
                    corner: 10,
                    hint: 'Place of Birth',
                    height: 20,
                    controller: provider.placeOfBirthController,
                    isReadOnly: true,
                    suffixIcon: SuffixIcon.place,
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownWidget(
                    validator: provider.expectedIncomingValidator,
                    dropdownValue: provider.expectedIncomingTxVolumeYearly,
                    hint: 'Annually Expected Income',
                    items: KycData.expectedVolumeItems,
                    onChanged: (value) {
                      provider.setExpectedIncomingTxVolumeYearly(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDropDownWidget(
                    validator: provider.expectedOutgoingValidator,
                    dropdownValue: provider.expectedOutgoingTxVolumeYearly,
                    hint: 'Annually Expected Outgoing',
                    items: KycData.expectedVolumeItems,
                    onChanged: (value) {
                      provider.setExpectedOutgoingTxVolumeYearly(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("PEP Declaration"),
                      ),
                      Visibility(
                          visible: provider.pepRequired,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "*",
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Politically Exposed Person (PEP) is somebody who holds a prominent public position",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: provider.pepYes,
                                    onChanged: (val) {
                                      provider.declareYes(val);
                                    }),
                                const Text("YES")
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: provider.pepNo,
                                    onChanged: (val) {
                                      provider.declareNo(val);
                                    }),
                                const Text("No")
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocListener<UpdateDataBloc, VerifyIdentityState>(
                      listener: (context, state) {
                        if (state is VerifyIdentityLoaded) {
                          provider.startKYC(context);
                        }
                      },
                      child: BlocBuilder<UpdateDataBloc, VerifyIdentityState>(
                        builder: (context, state) {
                          if (state is VerifyIdentityLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is VerifyIdentityFailed) {
                            ///TODO:Remove later
                            return Center(child: Text(state.message));
                          }
                          return const SizedBox();
                        },
                      ))
                ],
              ),
            );
          })),
    );
  }
}

class FinalKycPage extends StatelessWidget {
  const FinalKycPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
