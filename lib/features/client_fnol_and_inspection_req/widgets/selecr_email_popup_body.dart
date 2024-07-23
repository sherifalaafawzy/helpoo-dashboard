import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';

import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';

import '../../../core/util/widgets/primary_button.dart';
import '../../../core/util/widgets/primary_form_field.dart';
import 'email_card.dart';

class SelectEmailPopUpBody extends StatefulWidget {
  const SelectEmailPopUpBody({
    super.key,
  });

  @override
  State<SelectEmailPopUpBody> createState() => _SelectEmailPopUpBodyState();
}

class _SelectEmailPopUpBodyState extends State<SelectEmailPopUpBody> {
  @override
  void initState() {
    super.initState();
    String type = appBloc.accidentDetailsModel!.report!.car!.manufacturer!.arName;
    String model = appBloc.accidentDetailsModel!.report!.car!.carModel!.arName;
    String plate = appBloc.accidentDetailsModel!.report!.car!.plateNumber!;
    String vin = appBloc.accidentDetailsModel!.report!.car!.vinNumber!;
    String fnolId = appBloc.accidentDetailsModel!.report!.id!.toString();
    appBloc.emailSubjectController.text = 'إخطار حادث $type $model ش $vin';
    String body = 'الساده شركه ${appBloc.accidentDetailsModel!.report!.car!.insuranceCompany?.arName ?? appBloc.accidentDetailsModel!.report!.insuranceCompany?.arName ?? ''}'
        '\n'
        'مرسل لسيادتكم اخطار سيارة $type $model شاسيه رقم ($vin) ،.  '
        '\n'
        'يرجي الإطلاع علي المرفقات الاتية'
        '\n'
        '1.	ملف PDF: يحتوي على تفاصيل وصف الحادث بالكامل، بما في ذلك الأضرار الملحقة بالسيارة وتفاصيل الحادث وملفات'
        ' '
        'صور يحتوي على صور للسيارة بعد الحادث مع تقرير الذكاء الاصطناعى، توضح الأضرار والحالة العامة للمركبة '
        '\n'
        '2.	ملف صوتي: يحتوي على تسجيل صوتي لوصف العميل لتفاصيل الحادث، مما يوفر مزيدًا من الوضوح والدقة في الوصف.'
        '\n'
        'يرجى مراجعة الملفات المرفقة وتحليلها لتقدير التلفيات واتخاذ الخطوات اللازمة للمعالجة السريعة والفعالة للحادث.'
        '\n'
        ' نحن متاحون لتوفير أي معلومات إضافية قد تحتاجونها.'
        '\n'
        'شكرًا لتعاونكم واهتمامكم بمعالجة هذا الحادث. نتطلع إلى تعاوننا المستقبلي.'
        '\n'
        'مع خالص التحية،';
    appBloc.emailBodyController.text = body;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SendPdfThrowEmailSuccessState) {
          HelpooInAppNotification.showSuccessMessage(message: 'Email sent successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Email', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.black)),
              space10Vertical(),
              PrimaryFormField(
                controller: appBloc.emailSubjectController,
                validationError: '',
                label: 'Subject',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              space10Vertical(),
              PrimaryFormField(
                controller: appBloc.emailBodyController,
                validationError: '',
                label: 'Body',
                infiniteLines: true,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              space10Vertical(),
              Expanded(
                child: ListView.builder(
                  itemCount: appBloc.insuranceModel?.emails?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        appBloc.selectedEmail = appBloc.insuranceModel!.emails![index];
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: EmailCard(
                          email: appBloc.insuranceModel!.emails![index],
                          selected: appBloc.selectedEmails.contains(appBloc.insuranceModel!.emails![index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              space10Vertical(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Confirm',
                      isLoading: appBloc.isSendPdfThrowEmailLoading,
                      onPressed: () {
                        if (appBloc.selectedEmails.isEmpty) {
                          HelpooInAppNotification.showErrorMessage(message: 'Please select an email');
                          return;
                        } else {
                          appBloc.sendPdfThrowEmail();
                        }
                      },
                    ),
                  ),
                  space10Horizontal(),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancel',
                      isDisabled: appBloc.isSendPdfThrowEmailLoading,
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
