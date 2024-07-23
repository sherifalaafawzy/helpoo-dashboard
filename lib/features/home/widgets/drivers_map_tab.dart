import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import 'driver_filter_item.dart';

class DriversMapTab extends StatefulWidget {
  const DriversMapTab({super.key});

  @override
  State<DriversMapTab> createState() => _DriversMapTabState();
}

class _DriversMapTabState extends State<DriversMapTab> {
  bool isFirstTimeToOpen = true;

  @override
  void initState() {
    super.initState();
    // appBloc.getAllDriversMap();
    // appBloc.trucksMarkers.clear();
    // appBloc.clientsCarsMarkers.clear();
    // appBloc.getDriversMap(
    //   isFirstTime: true,
    // );
    appBloc.getAllOpenServiceRequests(
      isFirstTime: true,
    );

    appBloc.driversMapTimer ??= Timer.periodic(
      const Duration(seconds: 15),
      (timer) {
        // appBloc.markers.clear();
        // appBloc.markers = {};

        // appBloc.driversMapTimer ??= timer;
        // appBloc.getDriversMap();
        appBloc.getAllOpenServiceRequests();
      },
    );
  }

  @override
  void dispose() {
    debugPrint("Drivers Map Tab Disposed");
    if (appBloc.driversMapTimer != null) {
      appBloc.driversMapTimer!.cancel();
      appBloc.driversMapTimer = null;
    }
    super.dispose();
  }

  // Widget _map() {
  //   const String htmlId = "driversMap";
  //
  //   ui.platformViewRegistry.registerViewFactory(
  //     htmlId,
  //     (int viewId) {
  //       final mapOptions = gMap.MapOptions()
  //         ..zoom = 11.0
  //         ..disableDoubleClickZoom = false
  //         ..disableDefaultUI = true
  //         ..center = gMap.LatLng(30.081559, 31.664924);
  //
  //       final elem = DivElement()..id = htmlId;
  //
  //       appBloc.driversMap = gMap.GMap(elem, mapOptions);
  //
  //       final _icon = gMap.Icon()
  //         ..scaledSize = gMap.Size(40, 40)
  //         ..url =
  //             "https://lh3.googleusercontent.com/ogw/ADGmqu_RzXtbUv4nHU9XjdbNtDNQ5XAIlOh_1jJNci48=s64-c-mo";
  //
  //       gMap.Marker(gMap.MarkerOptions()
  //         ..anchorPoint = gMap.Point(0.5, 0.5)
  //         ..icon = _icon
  //         ..position = gMap.LatLng(35.7560423, 139.7803552)
  //         ..map = appBloc.driversMap
  //         ..title = htmlId);
  //
  //       gMap.Marker(gMap.MarkerOptions()
  //         ..anchorPoint = gMap.Point(0.5, 0.5)
  //         ..icon = _icon
  //         ..position = gMap.LatLng(35.7713573, 139.7754953)
  //         ..map = appBloc.driversMap
  //         ..title = htmlId);
  //
  //       // map.onCenterChanged.listen((event) {
  //       //   debugPrint(map.center.toString());
  //       //   debugPrint(map.zoom.toString());
  //       // });
  //
  //       appBloc.driversMap!.onDrag.listen((event) {
  //         // debugPrint(map.center.toString());
  //         // debugPrint(map.zoom.toString());
  //       });
  //
  //       appBloc.driversMap!.onDragstart.listen((event) {
  //         debugPrint('drag start');
  //       });
  //
  //       appBloc.driversMap!.onDragend.listen((event) {
  //         debugPrint('drag end');
  //       });
  //
  //       // final icon = gMap.Icon()
  //       //   ..scaledSize = gMap.Size(42, 96)
  //       //   ..url = "http://i.epvpimg.com/qQGXbab.png";
  //
  //       // gMap.Marker(gMap.MarkerOptions()
  //       //   ..position = gMap.LatLng(30.081559, 31.664924)
  //       // // ..icon = icon
  //       //   ..map = appBloc.driversMap
  //       //   ..label = (
  //       //       gMap.MarkerLabel()
  //       //         ..text = "Driver 1"
  //       //   )
  //       //   ..title = htmlId,
  //       // );
  //       //
  //       // gMap.Marker(gMap.MarkerOptions()
  //       //   ..position = gMap.LatLng(30.081559 + 5, 31.664924 + 5)
  //       // // ..icon = icon
  //       //   ..map = appBloc.driversMap
  //       //   ..label = (
  //       //       gMap.MarkerLabel()
  //       //         ..text = "Driver 2"
  //       //   )
  //       //   ..title = htmlId,
  //       // );
  //
  //       // for(int i = 0 ; i < 10 ; i++) {
  //       //
  //       //   gMap.Marker(gMap.MarkerOptions()
  //       //     ..position = gMap.LatLng(30.081559 + (i * 5), 31.664924 + (i * 5))
  //       //     // ..icon = icon
  //       //     ..map = appBloc.driversMap
  //       //     ..label = (
  //       //         gMap.MarkerLabel()
  //       //           ..text = "Driver $i"
  //       //     )
  //       //     ..title = "Driver $i"
  //       //   );
  //       //
  //       //   debugPrint("Marker Added -- $i ");
  //       // }
  //
  //       appBloc.driversMap!.onClick.listen((event) {
  //         debugPrint(event.latLng!.toJSON()!.lat.toString());
  //         debugPrint(event.latLng!.toJSON()!.lng.toString());
  //         if (event.latLng != null) {
  //           if (event.latLng!.toJSON()!.lat != null &&
  //               event.latLng!.toJSON()!.lng != null) {
  //             // displayIcon(
  //             //   map: map,
  //             //   htmlId: htmlId,
  //             //   lat: event.latLng!.toJSON()!.lat!,
  //             //   lng: event.latLng!.toJSON()!.lng!,
  //             // );
  //           }
  //         }
  //       });
  //
  //       appBloc.driversMap!.onRightclick.listen((event) {
  //         debugPrint('right click');
  //       });
  //
  //       return elem;
  //     },
  //   );
  //
  //   return const HtmlElementView(viewType: htmlId);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // if (state is GetAllOpenServiceRequestsSuccessState) {
        //   if (isFirstTimeToOpen) {
        //     isFirstTimeToOpen = false;
        //   }
        // }

        // if (state is GetDriversMapSuccessState) {
        //   if (isFirstTimeToOpen) {
        //     isFirstTimeToOpen = false;
        //   }
        // }

        // if (state is GetDriversMapLoadingState ||
        //     state is GetAllOpenServiceRequestsLoadingState) {
        //   showPrimaryPopUp(
        //     context: context,
        //     popUpBody: const LoadingPopup(),
        //   );
        // }
        // if (state is GetDriversMapSuccessState ||
        //     state is GetAllOpenServiceRequestsSuccessState) {
        //   context.pop;
        // }
      },
      builder: (context, state) {
        if ((state is GetDriversMapLoadingState ||
            state is GetAllOpenServiceRequestsLoadingState)) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
          ),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Drivers Map',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                space10Vertical(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DriverFilterItem(
                            isOn: appBloc.isN300Vehicle,
                            title: 'N300',
                            onChanged: (value) {
                              appBloc.isN300Vehicle = value;
                            },
                          ),
                          space10Vertical(),
                          DriverFilterItem(
                            isOn: appBloc.isWinchVehicle,
                            title: 'Winch',
                            onChanged: (value) {
                              appBloc.isWinchVehicle = value;
                            },
                          ),
                        ],
                      ),
                      space10Horizontal(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DriverFilterItem(
                            isOn: appBloc.busyDrivers,
                            title: 'Busy',
                            onChanged: (value) {
                              if (appBloc.isWinchVehicle) {
                                appBloc.busyDrivers = value;
                              } else {
                                HelpooInAppNotification.showMessage(
                                  message:
                                      "Please make sure that winch toggle button is on",
                                );
                              }
                            },
                          ),
                          space10Vertical(),
                          DriverFilterItem(
                            isOn: appBloc.freeDrivers,
                            title: 'Free',
                            onChanged: (value) {
                              if (appBloc.isWinchVehicle) {
                                appBloc.freeDrivers = value;
                              } else {
                                HelpooInAppNotification.showMessage(
                                  message:
                                      "Please make sure that winch toggle button is on",
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      space10Horizontal(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DriverFilterItem(
                            isOn: appBloc.hideClients,
                            title: 'Clients',
                            onChanged: (value) {
                              appBloc.hideClients = value;
                            },
                          ),
                          space10Vertical(),
                          DriverFilterItem(
                            isOn: false,
                            title: 'Auto zoom on all cars ',
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      space10Horizontal(),
                      InkWell(
                        onTap: () {
                          appBloc.getAllOpenServiceRequests();
                          // appBloc.getDriversMap();
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
                space20Vertical(),
                Flexible(
                  child: SizedBox(
                    child: GoogleMap(
                      markers: {
                        ...appBloc.availableWinchMarkers,
                        ...appBloc.passengersCarsMarkers,
                        ...appBloc.busyWinchMarkers,
                        ...appBloc.busyPassengersCarMarkers,
                        ...appBloc.carsMarkers,
                      },
                      onMapCreated: (GoogleMapController controller) {
                        appBloc.mapController = controller;
                      },
                      // cameraTargetBounds: CameraTargetBounds(
                      //   LatLngBounds(
                      //     northeast: LatLng(30.081559, 31.664924),
                      //     southwest: LatLng(30.081559, 31.664924),
                      //   ),
                      // ),
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(30.0428104, 31.4513689),
                        zoom: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
