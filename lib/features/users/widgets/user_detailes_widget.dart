import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpoo_insurance_dashboard/core/models/service_request/existing_user_cars_model.dart';
import 'package:helpoo_insurance_dashboard/core/models/user_model.dart';
import 'package:helpoo_insurance_dashboard/core/util/extensions/build_context_extension.dart';
import 'package:helpoo_insurance_dashboard/core/util/extensions/days_extensions.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../core/models/service_request/get_all.dart';
import '../../../core/models/users/users_model.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/widgets/back_button_widget.dart';
import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/shared_widgets/empty_text.dart';
import '../../../core/util/widgets/show_pop_up.dart';
import '../../client_fnol_and_inspection_req/widgets/my_rich_text.dart';
import '../../../main.dart';

class UserDetailsWidget extends StatefulWidget {
  final bool isFromSearch;
  final Users userModel;
  final SearchedUserByPhoneResponseModel? searchedUserModel;

  const UserDetailsWidget({super.key, required this.userModel, this.isFromSearch = false, this.searchedUserModel});

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          width: 1000,
          height: 1000,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                space10Vertical(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButtonWidget(),
                    Text(
                      'User Details',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                    ),
                    const SizedBox(),
                  ],
                ),

                space20Vertical(),
                MyRichText(text: 'User Id : ', text2: widget.userModel.id.toString() ?? ''),
                space20Vertical(),
                MyRichText(
                  text: 'Name : ',
                  text2: widget.userModel.name ?? '',
                ),
                space20Vertical(),
                MyRichText(
                  text: 'Phone Number : ',
                  text2: widget.userModel.phoneNumber ?? '',
                ),
                space20Vertical(),
                MyRichText(
                  text: 'User Email : ',
                  text2: widget.userModel.email ?? '--',
                ),
                space20Vertical(),
                MyRichText(
                  text: 'User Type : ',
                  text2: widget.userModel.role?.name ?? '--',
                ),
                space20Vertical(),

                if (widget.isFromSearch && widget.searchedUserModel != null) ...[
                  const Divider(),
                  space20Vertical(),

                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TabBar(
                            onTap: (index) {
                              debugPrint('$index');
                            },
                            indicatorColor: HexColor(mainColor),
                            unselectedLabelColor: HexColor(darkGreyColor),
                            labelColor: HexColor(mainColor),
                            tabs: const [
                              Tab(text: 'User Packages'),
                              Tab(text: 'User Cars'),
                              Tab(text: 'User Orders'),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 500,
                          child: TabBarView(
                            children: [
                              PackagesTab(widget.searchedUserModel), // Create PackagesTab widget
                              CarsTab(widget.searchedUserModel),     // Create CarsTab widget
                              OrdersTab(),   // Create OrdersTab widget
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  space20Vertical(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}


/// *****************************************

class PackagesTab extends StatelessWidget {
  final SearchedUserByPhoneResponseModel? searchedUserModel;

  const PackagesTab(this.searchedUserModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (searchedUserModel?.packages ?? []).isEmpty ? <Widget>[Container(alignment: Alignment.center, padding: const EdgeInsets.all(100), child: const Text('Client has no packages'))] : searchedUserModel?.packages?.map((e) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              space20Vertical(),
              MyRichText(
                text: 'Package Name : ',
                text2: e.enName ?? '--',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Package Description : ',
                text2: e.arDescription ?? '--',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Benifits : ',
                text2: '${e.packageBenefits?.map((b) => '- ${b.arName}').toString().replaceAll(',', '\n').replaceFirst('(', ' ').replaceFirst(')', ' ')}',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Discount (Towing) : ',
                text2: '${e.discountPercentage ?? '?'}%  |  up to ${e.maxDiscountPerTime ?? '?'} egp  |  valid for ${e.numberOfDiscountTimes ?? '?'} requests  |  Basic discount ${e.discountAfterMaxTimes ?? '?'}%',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Number of requests (Towing) : ',
                text2: '${e.requestsInThisPackag ?? '?'} / ${e.numberOfDiscountTimes ?? '?'} requests',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Discount (Other Services) : ',
                text2: '${e.discountPercentage ?? '?'}%  |  up to ${e.maxDiscountPerTime ?? '?'} egp  |  valid for ${e.numberOfDiscountTimesOther ?? '?'} requests  |  Basic discount ${e.discountAfterMaxTimes ?? '?'}%',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Number of requests (Other Services) : ',
                text2: '${e.requestsInThisPackageOtherServices ?? '?'} / ${e.numberOfDiscountTimesOther ?? '?'} requests',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Is Active : ',
                text2: e.active ?? false ? 'Yes  |  Active due ${DateTime.parse(e.endDate!).dateAndTimeFormat ?? '?'}' : 'Pending  |  Will be active after ${e.activateAfterDays ?? '?'} days',
              ),
              space20Vertical(),
              MyRichText(
                text: 'Added Cars : ',
                text2: '${e.carPackages?.map((cp) => ' ${appBloc.manufacturersModel?.manufacturers.firstWhere((element) => element.id == cp.car?.manufacturerId).enName}  |  ${appBloc.carsModel?.models.firstWhere((element) => element.id == cp.car?.carModelId).enName}  |  ${cp.car?.year}  |  ${cp.car?.plateNumber}  |  ${cp.car?.vinNumber} ')}\n',
              ),
              space20Vertical(),
              const Divider(),
            ],
          );
        }).toList() ?? [],
      ),
    );
  }
}

// userCarsModel
class CarsTab extends StatefulWidget {
  final SearchedUserByPhoneResponseModel? searchedUserModel;

  const CarsTab(this.searchedUserModel, {super.key});

  @override
  State<CarsTab> createState() => _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  @override
  void initState() {
    appBloc.getExistingCustomerCarsByPhone(phone: widget.searchedUserModel!.user!.phoneNumber!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return appBloc.isGetExistingCustomerCarsByPhoneLoading
              ? const CupertinoActivityIndicator()
              : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (appBloc.userCarsModel?.cars ?? []).isEmpty ? <Widget>[Container(alignment: Alignment.center, padding: const EdgeInsets.all(100), child: const Text('Client has no cars'))] : appBloc.userCarsModel?.cars?.map((e) {

              // +201210000922

              Packages? pkg = widget.searchedUserModel!.packages?.firstWhere((p) => p.carPackages?.firstWhere((cp) => cp.carId == e.id, orElse: () => CarPackages()).carId != null, orElse: () => Packages());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  space20Vertical(),
                  MyRichText(
                    text: 'Car Brand : ',
                    text2: e.manufacturer?.enName ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Car Model : ',
                    text2: e.carModel?.enName ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Car Color : ',
                    text2: e.color ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Car Year : ',
                    text2: e.year?.toString() ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Insurance Company : ',
                    text2: e.insuranceCompany?.arName ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Plate Number : ',
                    text2: e.plateNumber ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Vin Number : ',
                    text2: e.vinNumber ?? '--',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Is Active : ',
                    text2: e.active ?? false ? 'Yes' : 'No',
                  ),
                  space20Vertical(),
                  MyRichText(
                    text: 'Is Added To Package : ',
                    text2: pkg?.id != null
                        ? 'Yes  |  ${pkg!.enName ?? pkg!.arName}'
                        : 'No',
                  ),
                  space20Vertical(),
                  pkg?.id != null
                      ? PrimaryButton(
                    text: 'View car package details',
                    backgroundColor: whiteColor,
                    textColor: mainColorHex,
                    onPressed: () {
                      showPrimaryPopUp(
                        context: context,
                        isDismissible: false,
                        horizontalPadding: 400,
                        isScrollable: true,
                        popUpBody: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                space20Vertical(),
                                MyRichText(
                                  text: 'Package Name : ',
                                  text2: pkg?.enName ?? '--',
                                ),
                                space20Vertical(),
                                MyRichText(
                                  text: 'Package Description : ',
                                  text2: pkg?.arDescription ?? '--',
                                ),
                                space20Vertical(),
                                MyRichText(
                                  text: 'Benifits : ',
                                  text2: '${pkg?.packageBenefits?.map((b) => '- ${b.arName}').toString().replaceAll(',', '\n').replaceFirst('(', ' ').replaceFirst(')', ' ')}',
                                ),
                                space20Vertical(),
                                MyRichText(
                                  text: 'Discount : ',
                                  text2: '${pkg?.discountPercentage ?? '?'}%  |  up to ${pkg?.maxDiscountPerTime ?? '?'} egp  |  valid for ${pkg?.numberOfDiscountTimes ?? '?'} requests  |  Basic discount ${pkg?.discountAfterMaxTimes ?? '?'}%',
                                ),
                                space20Vertical(),
                                MyRichText(
                                  text: 'Is Active : ',
                                  text2: pkg?.active ?? false ? 'Yes  |  Active due ${DateTime.parse(pkg!.endDate!).dateAndTimeFormat ?? '?'}' : 'Pending  |  Will be active after ${pkg?.activateAfterDays ?? '?'} days',
                                ),
                                space20Vertical(),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      : PrimaryButton(
                    text: 'Add to package',
                    onPressed: () {
                      if (widget.searchedUserModel!.packages!.isNotEmpty) {
                        showPrimaryPopUp(
                          context: context,
                          isDismissible: false,
                          horizontalPadding: 400,
                          isScrollable: true,
                          title: 'باقات العميل',
                          label: 'باقات العميل المتاحة',
                          popUpBody: BlocConsumer<AppBloc, AppState>(
                            listener: (context, state) {
                              if (state is AddCarToPackageSuccessState) {
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ],
                                  ),
                                  ...widget.searchedUserModel!.packages!.map((p) => Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: p.id == appBloc.selectedClientPackageToSubscribe?.id ? mainColorHex.withOpacity(0.5) : whiteColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: ListTile(
                                          title: Text(p.enName?? ''),
                                          subtitle: Text(p.enName?? ''),
                                          onTap: () {
                                            appBloc.setSelectedClientPackageToSubscribe(p);
                                          },
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  )),
                                  PrimaryButton(
                                    isLoading: appBloc.isAddCarToPackageLoading,
                                    text: 'Add Car To Package',
                                    onPressed: () {
                                      if (appBloc.selectedClientPackageToSubscribe != null) {
                                        appBloc.addCarToPackage(
                                          carId: e.id.toString(),
                                          clientId: e.clientId.toString(),
                                          clientPackageId: appBloc.selectedClientPackageToSubscribe!.id.toString(),
                                          packageId: appBloc.selectedClientPackageToSubscribe!.packageId.toString(),
                                        );
                                      } else {
                                        HelpooInAppNotification.showErrorMessage(message: 'Select a package first');
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          ),
                        );
                      } else {
                        HelpooInAppNotification.showErrorMessage(message: 'User has no packages.');
                      }
                    },
                  ),
                  const Divider(),
                ],
              );
            }).toList() ?? [],
          ),
        );
      }
    );
  }
}

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Orders Tab Content'),
    );
  }
}