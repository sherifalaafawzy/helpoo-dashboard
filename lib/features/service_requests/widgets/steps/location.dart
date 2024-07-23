import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';

import '../../../../core/util/constants.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/widgets/primary_button.dart';
import '../../../../core/util/widgets/primary_form_field.dart';


// import 'dart:math' show pow;

import 'package:helpoo_insurance_dashboard/core/util/widgets/show_pop_up.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/components/choose_vehicle_type.dart';
import 'package:helpoo_insurance_dashboard/features/service_requests/components/confirm_text_component.dart';

// 1. when to call a new request
// 2. when to draw anything in map
// 3. how to call a new request
// 4. how to draw anything in map
class MapsWidget extends StatefulWidget {
  final bool isOpenFromSteps;

  const MapsWidget({super.key, this.isOpenFromSteps = true});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  GlobalKey originKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBloc.polylineCoordinates = [];
    appBloc.originMarker = null;
    appBloc.destinationMarker = null;

    if (userRoleName == Rules.Corporate.name) {
      if (appBloc.serviceRequestListModel?.serviceRequestDetails.status != ServiceRequestStatus.canceled.name ||
          appBloc.serviceRequestListModel?.serviceRequestDetails.status != ServiceRequestStatus.done.name) {
        if (!widget.isOpenFromSteps) {
          appBloc.locationTimer = Timer.periodic(
            Duration(minutes: appBloc.intervalTimeInMinutes),
            (timer) {
              appBloc.getCurrentActiveServiceRequest(isRefresh: true);
            },
          );
        }
      } else {
        if (appBloc.locationTimer != null) {
          appBloc.locationTimer!.cancel();
          appBloc.locationTimer = null;
        }
      }
    }
  }

  @override
  void dispose() {
    if (appBloc.locationTimer != null) {
      appBloc.locationTimer!.cancel();
      appBloc.locationTimer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is SearchMapPlaceSuccess) {
          // showPrimaryMenu(
          //   context: context,
          //   key: originKey,
          //   items: [
          //     ...appBloc.mapPlaceModel!.predictions.map(
          //       (e) => PopupMenuItem(
          //         value: 1,
          //         child: Text(
          //           e.mainText,
          //           style: Theme.of(context).textTheme.displaySmall!.copyWith(
          //                 fontSize: 16.0,
          //                 color: secondaryGrey,
          //                 fontWeight: FontWeight.w400,
          //               ),
          //         ),
          //         onTap: () {
          //           appBloc.getMapPlaceDetails(
          //             value: e,
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // );
        }

        // if (state is DrawPathSuccessState) {
        //   appBloc.originalMapController!.animateCamera(
        //     CameraUpdate.newCameraPosition(
        //       CameraPosition(
        //         target: LatLng(
        //           appBloc.polylineCoordinates.last.latitude,
        //           appBloc.polylineCoordinates.last.longitude,
        //         ),
        //         zoom: 10.0,
        //       ),
        //     ),
        //   );
        // }

        if (state is GetMainTripPathSuccessState) {
          if (widget.isOpenFromSteps) {
            // TODO : Get Driver [4 / 5]

            // TODO : MANS
            // TODO : MANS
            // await appBloc.getDriverBasedOnSelectedServiceType(id: 4);
            // await appBloc.getDriverBasedOnSelectedServiceType(id: 5);
            appBloc.calculateServiceFees(isSecondTime: false);
          }
        }

        if (state is CalculateServiceFeesSuccessState) {
          if (!state.isSecondTime) {
            showPrimaryPopUp(
                context: context, width: 550, isDismissible: false, popUpBody: const ChooseVehicleTypeComponent());
          }
        }
      },
      builder: (context, state) {
        if (widget.isOpenFromSteps) {
          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryFormField(
                            controller: appBloc.originController,
                            key: originKey,
                            validationError: '',
                            label: 'Origin',
                            onChange: (value) {
                              if (value.length > 3) {
                                appBloc.isOrigin = true;

                                appBloc.searchMapPlace(
                                  input: value,
                                );
                              }
                            },
                          ),
                        ),
                        space10Horizontal(),
                        Expanded(
                          child: PrimaryFormField(
                            controller: appBloc.destinationController,
                            validationError: '',
                            label: 'Destination',
                            onChange: (value) {
                              if (value.length > 3) {
                                appBloc.isOrigin = false;

                                appBloc.searchMapPlace(
                                  input: value,
                                );
                              }
                            },
                          ),
                        ),
                        if (widget.isOpenFromSteps) space10Horizontal(),
                        if (widget.isOpenFromSteps)
                          SizedBox(
                            width: 200.0,
                            child: PrimaryButton(
                              isLoading: appBloc.isGettingPathLoading,
                              text: 'Go to',
                              onPressed: () {
                                // appBloc.map!.moveCamera(
                                //   gMap.CameraOptions()
                                //     ..center = gMap.LatLng(
                                //       30.092932,
                                //       31.613062,
                                //     ),
                                // );
                                // showPrimaryPopUp(
                                //     context: context,
                                //     width: 550,
                                //     popUpBody: const ChooseVehicleTypeComponent());
                                appBloc.getMainTripPath(isCalltoDrawPath: true);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  // space10Vertical(),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 14),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //           width: 200.0,
                  //           child: Text(
                  //             'Origin : ',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium!
                  //                 .copyWith(color: Colors.grey),
                  //           )),
                  //       space10Horizontal(),
                  //       SizedBox(
                  //           width: 200.0,
                  //           child: Text(
                  //             'Destination : ',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium!
                  //                 .copyWith(color: Colors.grey),
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  space20Vertical(),
                  SizedBox(height: 800, child: _map()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 60,
                ),
                child: Row(
                  children: [
                    if (appBloc.mapPlaceModel != null && appBloc.isOrigin)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ...appBloc.mapPlaceModel!.predictions
                                  .asMap()
                                  .map(
                                    (key, value) => MapEntry(
                                      key,
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              debugPrint('e.mainText');

                                              appBloc.getMapPlaceDetails(
                                                value: value,
                                              );
                                            },
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      value.mainText,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                    Text(
                                                      value.secondaryText,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 12.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (key != 12) const MyDivider(),
                                        ],
                                      ),
                                    ),
                                  )
                                  .values
                                  ,
                            ],
                          ),
                        ),
                      ),
                    if (appBloc.mapPlaceModel != null && !appBloc.isOrigin) const Spacer(),
                    space10Horizontal(),
                    if (appBloc.mapPlaceModel != null && appBloc.isOrigin) const Spacer(),
                    if (appBloc.mapPlaceModel != null && !appBloc.isOrigin)
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ...appBloc.mapPlaceModel!.predictions
                                  .asMap()
                                  .map(
                                    (key, value) => MapEntry(
                                      key,
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              debugPrint('e.mainText');

                                              appBloc.getMapPlaceDetails(
                                                value: value,
                                              );
                                            },
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      value.mainText,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                    Text(
                                                      value.secondaryText,
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 12.0,
                                                            color: secondaryGrey,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (key != 12) const MyDivider(),
                                        ],
                                      ),
                                    ),
                                  )
                                  .values
                                  ,
                            ],
                          ),
                        ),
                      ),
                    space10Horizontal(),
                    const SizedBox(
                      width: 200.0,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Center(
          child: Container(
            width: 1122,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: borderGrey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsetsDirectional.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryFormField(
                              controller: appBloc.originController,
                              key: originKey,
                              validationError: '',
                              enabled: false,
                              label: 'Origin',
                              onChange: (value) {
                                if (value.length > 3) {
                                  appBloc.isOrigin = true;

                                  appBloc.searchMapPlace(
                                    input: value,
                                  );
                                }
                              },
                            ),
                          ),
                          space10Horizontal(),
                          Expanded(
                            child: PrimaryFormField(
                              controller: appBloc.destinationController,
                              validationError: '',
                              label: 'Destination',
                              enabled: false,
                              onChange: (value) {
                                if (value.length > 3) {
                                  appBloc.isOrigin = false;

                                  appBloc.searchMapPlace(
                                    input: value,
                                  );
                                }
                              },
                            ),
                          ),
                          space10Horizontal(),
                          InkWell(
                            onTap: () {
                              appBloc.getCurrentActiveServiceRequest();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // space10Vertical(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 14),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SizedBox(
                    //           width: 200.0,
                    //           child: Text(
                    //             'Origin : ',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .titleMedium!
                    //                 .copyWith(color: Colors.grey),
                    //           )),
                    //       space10Horizontal(),
                    //       SizedBox(
                    //           width: 200.0,
                    //           child: Text(
                    //             'Destination : ',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .titleMedium!
                    //                 .copyWith(color: Colors.grey),
                    //           )),
                    //     ],
                    //   ),
                    // ),
                    space20Vertical(),
                  ],
                ),
                Flexible(
                  child: SizedBox(
                    child: _map(),
                  ),
                ),
                space20Vertical(),
                appBloc.selectedServiceRequestModel!.status != 'canceled'
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //discount area
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/discount.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    space10Horizontal(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                      child: Text(
                                        'Discount : ${appBloc.getHighestDiscount([
                                              appBloc.selectedServiceRequestModel!.adminDiscount ?? 0,
                                              appBloc.selectedServiceRequestModel!.discountPercentage ?? 0,
                                              // appBloc
                                              //         .selectedServiceRequestModel!
                                              //         .policyAndPackage!
                                              //         .packageDiscountPercentage ??
                                              //     0
                                            ])} %',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                // driver data area
                                appBloc.selectedServiceRequestModel?.driver?.id != null
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              appBloc.selectedServiceRequestModel?.driver?.user?.name ?? '',
                                              style:
                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                            ),
                                            space10Horizontal(),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context).primaryColor,
                                                  width: 2,
                                                ),
                                                image: const DecorationImage(
                                                    image: AssetImage('assets/images/user.png'), fit: BoxFit.cover),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),

                            space10Vertical(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // request status and time
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        // vertical: 5,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        appBloc.getServiceRequestStatusName(
                                            appBloc.serviceRequestListModel?.serviceRequestDetails.status ?? ''),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      // width: 90,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        // vertical: 5,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        appBloc.returnStringAsHoursOrMinutes(),
                                        // appBloc.driverPolylineResult?.duration ?? '',
                                        textAlign: TextAlign.center,
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),

                                //waiting time area
                                if (appBloc.selectedServiceRequestModel?.isWaitingTimeApplied ?? false)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      'Waiting Time : ${appBloc.selectedServiceRequestModel?.waitingTime ?? ''} Minutes',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                                    ),
                                  ),

                                //trip Price and payment area

                                SizedBox(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        // clipBehavior:
                                        //     Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                        child: Text(
                                          'Original Fees : ${appBloc.serviceRequestListModel?.serviceRequestDetails.originalFees.toString() ?? ''} EGP',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        // clipBehavior:
                                        //     Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                        child: Text(
                                          appBloc.selectedServiceRequestModel?.paymentMethod == ''
                                              ? 'Payment Not selected'
                                              : appBloc.serviceRequestListModel?.serviceRequestDetails.paymentMethod ??
                                                  '',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            space10Vertical(),

                            // trip data

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConfirmTextComponent(
                                      headline: 'Final Fees',
                                      color: Colors.black,
                                      text:
                                          '${appBloc.serviceRequestListModel?.serviceRequestDetails.fees.toString() ?? ''} EGP',
                                    ),
                                    space30Horizontal(),
                                    ConfirmTextComponent(
                                      headline: 'Arrival Distance',
                                      color: Colors.black,
                                      text: appBloc.returnStringAsKmOrMeters(),
                                    ),
                                    space30Horizontal(),
                                    ConfirmTextComponent(
                                      headline: 'Arrival Time',
                                      color: Colors.black,
                                      text: appBloc.returnStringAsHoursOrMinutes(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'Request Canceled',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                space20Vertical(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///**************** Maps Widgets ****************************

  // Widget _map() {
  //   const String htmlId = "map";

  //   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
  //     final mapOptions = gMap.MapOptions()
  //       ..zoom = 15.0
  //       ..disableDoubleClickZoom = false
  //       ..disableDefaultUI = true
  //       ..center = gMap.LatLng(30.081559, 31.664924);

  //     final elem = DivElement()..id = htmlId;
  //     appBloc.map = gMap.GMap(elem, mapOptions);

  //     // map.onCenterChanged.listen((event) {
  //     //   debugPrint(map.center.toString());
  //     //   debugPrint(map.zoom.toString());
  //     // });

  //     appBloc.map!.onDrag.listen((event) {
  //       // debugPrint(map.center.toString());
  //       // debugPrint(map.zoom.toString());
  //     });

  //     appBloc.map!.onDragstart.listen((event) {
  //       debugPrint('drag start');
  //     });

  //     appBloc.map!.onDragend.listen((event) {
  //       debugPrint('drag end');
  //     });

  //     // getPoints(map);
  //     // drawPolyline(appBloc.map, []);
  //     // showCircle(map);
  //     // displayIcon(
  //     //   map: map,
  //     //   htmlId: htmlId,
  //     // );

  //     appBloc.map!.onClick.listen((event) {
  //       debugPrint(event.latLng!.toJSON()!.lat.toString());
  //       debugPrint(event.latLng!.toJSON()!.lng.toString());
  //       if (event.latLng != null) {
  //         if (event.latLng!.toJSON()!.lat != null &&
  //             event.latLng!.toJSON()!.lng != null) {
  //           // displayIcon(
  //           //   map: map,
  //           //   htmlId: htmlId,
  //           //   lat: event.latLng!.toJSON()!.lat!,
  //           //   lng: event.latLng!.toJSON()!.lng!,
  //           // );
  //         }
  //       }
  //     });

  //     appBloc.map!.onRightclick.listen((event) {
  //       debugPrint('right click');
  //     });

  //     return elem;
  //   });

  //   return const HtmlElementView(viewType: htmlId);
  // }

  Widget _map() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        appBloc.originalMapController = controller;
      },
      polylines: {
        if (appBloc.polylineCoordinates.isNotEmpty)
          Polyline(
            polylineId: const PolylineId('polyline'),
            color: const Color(0xFF085E25),
            width: 5,
            points: appBloc.polylineCoordinates,
          ),
      },
      markers: {
        if (appBloc.originMarker != null) appBloc.originMarker!,
        if (appBloc.destinationMarker != null) appBloc.destinationMarker!,
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.0428104, 31.4513689),
        zoom: 12,
      ),
    );
  }

  ///*********************************************************
}
