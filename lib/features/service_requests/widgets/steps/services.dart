import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../components/service_component.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Services',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: textColor)),
              space3Vertical(),
              Text('Choose your service',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: textColor)),
              space24Vertical(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ...List.generate(
                  //   appBloc.serviceRequestTypes?.length ?? 0,
                  //   (index) {
                  //     return ServiceComponent(
                  //       isSelected: appBloc.currentSelectedServiceType == index,
                  //       serviceName:
                  //           appBloc.serviceRequestTypes?[index].enName ?? '',
                  //       onSelectChanged: (value) {
                  //         appBloc.changeCurrentSelectedServiceType(
                  //             index: index);
                  //       },
                  //     );
                  //   },
                  // ),
                  ServiceComponent(
                    isSelected: appBloc.isTowingService,
                    serviceName: 'Car Towing',
                    onSelectChanged: (value) {
                      appBloc.changeTowingService(value: value!);
                    },
                  ),
                  ServiceComponent(
                    isSelected: false,
                    serviceName: 'Fuel',
                    onSelectChanged: (value) {},
                  ),
                  ServiceComponent(
                    isSelected: false,
                    serviceName: 'Tires Fix',
                    onSelectChanged: (value) {},
                  ),
                  ServiceComponent(
                    isSelected: false,
                    serviceName: 'Batteries',
                    onSelectChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
