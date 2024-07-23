import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import '../../../core/util/widgets/primary_padding.dart';
import '../../../core/util/widgets/primary_pop_up_menu.dart';
import '../../service_requests/components/service_component.dart';

class CreatePackageScreen extends StatefulWidget {
  const CreatePackageScreen({super.key});

  @override
  State<CreatePackageScreen> createState() => _CreatePackageScreenState();
}

class _CreatePackageScreenState extends State<CreatePackageScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey packageIsActiveKey = GlobalKey();
  GlobalKey packageIsPrivateKey = GlobalKey();
  GlobalKey packageCorporateKey = GlobalKey();
  GlobalKey packageInsuranceKey = GlobalKey();
  GlobalKey packageBrokerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.getAllCorporates();
    appBloc.getAllInsuranceCompanies();
    appBloc.getAllBrokers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CreatePackageCustomizationSuccessState) {
          HelpooInAppNotification.showSuccessMessage(
            message: 'Package Created Successfully',
          );
          appBloc.changeStackNav(
            index: appBloc.currentSideMenuIndex,
            isAdd: false,
          );
        }
      },
      builder: (context, state) {
        return PrimaryPadding(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  space20Vertical(),
                  SizedBox(
                    width: 1122,
                    child: Row(
                      children: [
                        const BackButtonWidget(),
                        Text(
                          'Create Package',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                  space40Vertical(),
                  Expanded(
                    child: Container(
                      width: 1122,
                      height: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: borderGrey,
                        ),
                      ),
                      child: PrimaryPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Please fill the form below',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: secondaryGrey,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  'scroll down to see more',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: secondaryGrey,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ],
                            ),
                            space20Vertical(),
                            const MyDivider(),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    space20Vertical(),

                                    ///* Package Name
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Name',
                                            label: 'Package Name (EN)*',
                                            controller: appBloc.packageNameEnController,
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Name',
                                            label: 'Package Name (Ar)*',
                                            controller: appBloc.packageNameArController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    space20Vertical(),

                                    ///* Package Description
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Description',
                                            label: 'Package Description (EN)*',
                                            controller: appBloc.packageDescriptionENController,
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Description',
                                            label: 'Package Description (Ar)*',
                                            controller: appBloc.packageDescriptionARController,
                                          ),
                                        ),
                                      ],
                                    ),

                                    space20Vertical(),

                                    ///* Number of Days , Number of Cars
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Number of Days',
                                            label: 'Number of Days *',
                                            controller: appBloc.packageNumberOfDaysController,
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Number of Cars',
                                            label: 'Number of Cars *',
                                            controller: appBloc.packageNumberOfCarsController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    space20Vertical(),

                                    ///* Package isActive , isPrivate
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              showPrimaryMenu(
                                                context: context,
                                                key: packageIsActiveKey,
                                                items: [
                                                  ...['true', 'false'].map(
                                                    (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.packageIsActiveController.text = e;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: PrimaryFormField(
                                              key: packageIsActiveKey,
                                              enabled: false,
                                              validationError: 'Please Enter Package status',
                                              label: 'Package status (Active / InActive ) *',
                                              controller: appBloc.packageIsActiveController,
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              showPrimaryMenu(
                                                context: context,
                                                key: packageIsPrivateKey,
                                                items: [
                                                  ...['true', 'false'].map(
                                                    (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.packageIsPrivateController.text = e;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: PrimaryFormField(
                                              key: packageIsPrivateKey,
                                              enabled: false,
                                              validationError: 'Please Enter Package private ',
                                              label: 'Is Package Private *',
                                              controller: appBloc.packageIsPrivateController,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    space20Vertical(),

                                    ///* Package Fees , maxDiscountPerTime , discountPercentage
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Fees',
                                            label: 'Package Fees *',
                                            controller: appBloc.packageFeesController,
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Package Max Discount Per Time',
                                            label: 'Max Discount Per Time *',
                                            controller: appBloc.packageMaxDiscountPerTimeController,
                                          ),
                                        ),
                                        space10Horizontal(),
                                        Expanded(
                                          child: PrimaryFormField(
                                            validationError: 'Please Enter Discount Percentage',
                                            label: 'Discount Percentage (%)*',
                                            controller: appBloc.packageDiscountPercentageController,
                                          ),
                                        ),
                                      ],
                                    ),

                                    space20Vertical(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              showPrimaryMenu(
                                                context: context,
                                                key: packageCorporateKey,
                                                items: [
                                                  ...appBloc.corporatesModel!.rows!.map(
                                                    (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e.enName!,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.selectedPackageCorporate = e;
                                                        appBloc.selectedPackageInsurance = null;
                                                        appBloc.selectedPackageBroker = null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: PrimaryFormField(
                                              key: packageCorporateKey,
                                              enabled: false,
                                              isValidate: false,
                                              validationError: 'Please Choose package Corporate',
                                              label: 'Package Corporate *',
                                              controller: appBloc.packageCorporateController,
                                            ),
                                          ),
                                        ),
                                        space20Horizontal(),
                                        ///* Insurance
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              showPrimaryMenu(
                                                context: context,
                                                key: packageInsuranceKey,
                                                items: [
                                                  ...appBloc.insuranceCompanies.map(
                                                    (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e.enName!,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                              fontSize: 16.0,
                                                              color: secondaryGrey,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.selectedPackageCorporate = null;
                                                        appBloc.selectedPackageBroker = null;
                                                        appBloc.selectedPackageInsurance = e;

                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: PrimaryFormField(
                                              key: packageInsuranceKey,
                                              enabled: false,
                                              validationError: 'Please Choose package Insurance',
                                              label: 'Package Insurance *',
                                              isValidate: false,
                                              controller: appBloc.packageInsuranceController,
                                            ),
                                          ),
                                        ),
                                        space20Horizontal(),
                                        ///* Broker
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              showPrimaryMenu(
                                                context: context,
                                                key: packageBrokerKey,
                                                items: [
                                                  ...appBloc.brokersList.map(
                                                        (e) => PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        e.user!.name,
                                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                          fontSize: 16.0,
                                                          color: secondaryGrey,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        appBloc.selectedPackageCorporate = null;
                                                        appBloc.selectedPackageInsurance = null;
                                                        appBloc.selectedPackageBroker = e;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: PrimaryFormField(
                                              key: packageBrokerKey,
                                              enabled: false,
                                              validationError: 'Please Choose package Broker',
                                              label: 'Package Broker *',
                                              isValidate: false,
                                              controller: appBloc.packageBrokerController,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    space20Vertical(),
                                    Row(
                                      children: [
                                        Text(
                                          'Package Benefits',
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                color: secondaryGrey,
                                              ),
                                        ),
                                        const Spacer(),
                                        // Text(
                                        //   'you can add more than one',
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .titleLarge!
                                        //       .copyWith(
                                        //         color: secondaryGrey,
                                        //         fontSize: 16.0,
                                        //       ),
                                        // ),
                                        PrimaryButton(
                                          text: 'Add Benefit',
                                          icon: Icons.add_circle_outline,
                                          isIconButton: true,
                                          width: 150.0,
                                          onPressed: () {
                                            appBloc.addControllerToBenefitsList();
                                          },
                                        ),
                                      ],
                                    ),
                                    space20Vertical(),
                                    ...List.generate(
                                      appBloc.benefitsNameEnControllers.length,
                                      (index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: PrimaryFormField(
                                                  validationError: '',
                                                  label: 'Benefit Name (EN)*',
                                                  controller: appBloc.benefitsNameEnControllers[index],
                                                ),
                                              ),
                                              space10Horizontal(),
                                              Expanded(
                                                child: PrimaryFormField(
                                                  validationError: '',
                                                  label: 'Benefit Name (Ar)*',
                                                  controller: appBloc.benefitsNameArControllers[index],
                                                ),
                                              ),
                                              space5Horizontal(),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  appBloc.removeControllerFromBenefitsList(index);
                                                },
                                              ),
                                              space5Horizontal(),
                                            ],
                                          ),
                                          space20Vertical(),
                                        ],
                                      ),
                                    ),
                                    space20Vertical(),
                                    Wrap(
                                      children: appBloc.packageCustomizations.entries
                                          .map((e) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                child: ServiceComponent(
                                                  onSelectChanged: (value) {
                                                    appBloc.changePackageCustomization(key: e.key, value: value!);
                                                  },
                                                  serviceName: e.key,
                                                  isSelected: e.value,
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    space20Vertical(),
                                    PrimaryFormField(
                                      validationError: '',
                                      label: 'Sms',
                                      controller: appBloc.packageCustomizationMessageController,
                                      isValidate: false,
                                    ),

                                    space20Vertical(),
                                    PrimaryButton(
                                      isDisabled: appBloc.isCreatePackageLoading,
                                      text: 'Create Package',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          //TODO : Create Package Function

                                          if (appBloc.selectedPackageCorporate != null &&
                                              appBloc.selectedPackageInsurance != null) {
                                            HelpooInAppNotification.showErrorMessage(
                                                message:
                                                    'Please Choose package For one of them Corporate or Insurance');
                                            return;
                                          }
                                          appBloc.createPackage();
                                        } else {
                                          HelpooInAppNotification.showErrorMessage(
                                            message: 'Please fill all required fields',
                                          );
                                        }
                                      },
                                      isLoading: appBloc.isCreatePackageLoading,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
