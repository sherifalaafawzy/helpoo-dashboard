import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/cubit/state.dart';
import 'package:screenshot/screenshot.dart';

class PdfFirstPage extends StatefulWidget {
  const PdfFirstPage({super.key});

  @override
  State<PdfFirstPage> createState() => _PdfFirstPageState();
}

class _PdfFirstPageState extends State<PdfFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: appBloc.firstPageController,
      child: _fnolPdfFirstPageView(),
    );
  }

  ///* Order invoice view
  Widget _fnolPdfFirstPageView() {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              width: 1000,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'شركة الدلتا للتأمين',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'DELTA INSURANCE CO',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الإدارة العامة لتعويضات السيارات',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ت /3762191 - 37626190',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ف /37626190',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/delta_lodo.jpg',
                        width: 100,
                        height: 100,
                      )
                    ],
                  ),
                  space5Vertical(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 200,
                      ),
                      const Text(
                        'اخطار عن حادث سيارة',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('رقم المطالبة'),
                            Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            Text('تاريخ تقديم الإخطار'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  space5Vertical(),
                  Row(
                    children: [
                      Expanded(child: _boxItem()),
                      space20Horizontal(),
                      Expanded(child: _boxItem()),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _boxItem()),
                      space20Horizontal(),
                      Expanded(child: _boxItem()),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _boxItem()),
                      space20Horizontal(),
                      Expanded(child: _boxItem()),
                    ],
                  ),
                  _boxItem(),
                  _boxItem(),
                  _boxItem(),
                  _boxItem(),
                  const Text(
                    'ببببببببببببببببببببببببببببببببببببببببببب',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    'ببببببببببببببببببببببببببببببببببببببببببب',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تحرير في',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'توقيع مقدم الاخطار',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'توقيع المؤمن له',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column _boxItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'بيانات المؤمن لة',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              _item('الاســـم : ', 'عبدالله احمد'),
              _item('العنوان : ', 'المنصورة'),
              _item('التليفون : ', '01000000000'),
              _item('رقم الفاكس : ', '01000000000'),
            ],
          ),
        ),
      ],
    );
  }

  Row _item(String value, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
