import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/util/cubit/cubit.dart';
import '../../core/util/cubit/state.dart';

import '../../core/util/constants.dart';
import '../../core/util/enums.dart';
import '../../core/util/widgets/main_scaffold.dart';
import '../../core/util/widgets/primary_form_field.dart';

// import 'dart:math' show pow;

import 'package:helpoo_insurance_dashboard/features/service_requests/components/confirm_text_component.dart';

// 1. when to call a new request
// 2. when to draw anything in map
// 3. how to call a new request
// 4. how to draw anything in map
class TrackingPage extends StatefulWidget {
  const TrackingPage({
    super.key,
  });

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GlobalKey originKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // html.window.name = '/tracking?id=$idParam';

    if (idParam.isNotEmpty) {
      appBloc.setSelectedServiceRequestId(
        id: int.parse(idParam),
        isForActiveService: true,
      );
    }

    debugPrint(
        'selected Service request id is >>> ${appBloc.selectedServiceRequestId}');
    appBloc.polylineCoordinates = [];
    appBloc.originMarker = null;
    appBloc.destinationMarker = null;

    if (userRoleName == Rules.Corporate.name) {
      if (appBloc.serviceRequestListModel?.serviceRequestDetails.status !=
              ServiceRequestStatus.canceled.name ||
          appBloc.serviceRequestListModel?.serviceRequestDetails.status !=
              ServiceRequestStatus.done.name) {
        appBloc.locationTimer = Timer.periodic(
          Duration(minutes: appBloc.intervalTimeInMinutes),
          (timer) {
            appBloc.getCurrentActiveServiceRequest(isRefresh: true);
          },
        );
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
    return MainScaffold(
      scaffold: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Center(
                child: Container(
                  width: double.infinity,
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
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
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
                      // appBloc.selectedServiceRequestModel?.status !=
                      //             'canceled' ||
                      appBloc.serviceRequestListModel?.serviceRequestDetails
                                  .status !=
                              ServiceRequestStatus.canceled.name
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.all(14.0),
                              child: SelectionArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: Colors.green
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              child: Text(
                                                'Discount : ${appBloc.getHighestDiscount([
                                                      appBloc
                                                              .serviceRequestListModel
                                                              ?.serviceRequestDetails
                                                              .adminDiscount ??
                                                          0,
                                                      appBloc
                                                              .serviceRequestListModel
                                                              ?.serviceRequestDetails
                                                              .discountPercentage ??
                                                          0,
                                                      // appBloc
                                                      //         .selectedServiceRequestModel!
                                                      //         .policyAndPackage!
                                                      //         .packageDiscountPercentage ??
                                                      //     0
                                                    ])} %',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // driver data area
                                        appBloc
                                                    .serviceRequestListModel
                                                    ?.serviceRequestDetails
                                                    .driverRequestDetailsModel
                                                    ?.id !=
                                                null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          appBloc
                                                                  .serviceRequestListModel
                                                                  ?.serviceRequestDetails
                                                                  .driverRequestDetailsModel
                                                                  ?.user
                                                                  ?.name ??
                                                              '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          appBloc
                                                                  .serviceRequestListModel
                                                                  ?.serviceRequestDetails
                                                                  .driverRequestDetailsModel
                                                                  ?.user
                                                                  ?.phoneNumber ??
                                                              '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          '${appBloc.serviceRequestListModel?.serviceRequestDetails.vehicle?.VecName ?? ''} ${appBloc.serviceRequestListModel?.serviceRequestDetails.vehicle?.VecNum.toString() ?? ''}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                    space10Horizontal(),
                                                    CachedNetworkImage(
                                                      imageUrl: appBloc
                                                              .serviceRequestListModel
                                                              ?.serviceRequestDetails
                                                              .driverRequestDetailsModel
                                                              ?.user
                                                              ?.photo ??
                                                          '',
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 50,
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2,
                                                          ),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        width: 50,
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2,
                                                          ),
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/user.png'),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // request status and time
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                // vertical: 5,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                appBloc.getServiceRequestStatusName(appBloc
                                                        .serviceRequestListModel
                                                        ?.serviceRequestDetails
                                                        .status ??
                                                    ''),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            Container(
                                              // width: 90,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                // vertical: 5,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                appBloc.returnStringAsHoursOrMinutes(),
                                                textAlign: TextAlign.center,
                                                // maxLines: 1,
                                                // overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //waiting time area
                                        if (appBloc
                                                .serviceRequestListModel
                                                ?.serviceRequestDetails
                                                .isWaitingTimeApplied ??
                                            false)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 5.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Text(
                                              'Waiting Time : ${appBloc.serviceRequestListModel?.serviceRequestDetails.waitingTime ?? ''} Minutes',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.white),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Text(
                                                  'Original Fees : ${appBloc.serviceRequestListModel?.serviceRequestDetails.originalFees.toString() ?? ''} EGP',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                // clipBehavior:
                                                //     Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Text(
                                                  appBloc
                                                              .serviceRequestListModel
                                                              ?.serviceRequestDetails
                                                              .paymentMethod ==
                                                          ''
                                                      ? 'Payment Not selected'
                                                      : appBloc
                                                              .serviceRequestListModel
                                                              ?.serviceRequestDetails
                                                              .paymentMethod ??
                                                          '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors.black),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Request Canceled',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
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
          ),
        ),
      ),
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
