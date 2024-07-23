import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/models/accident_report_details_model.dart';
import '../../../core/network/remote/api_endpoints.dart';
import '../../../core/util/cubit/cubit.dart';
import '../../../core/util/extensions/days_extensions.dart';
import '../../../core/util/helpoo_in_app_notifications.dart';
import '../../../core/util/utils.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class PdfController {
  PdfController._();

  ///* generate First Page Fnol Pdf
  static Future<pw.Document> generateFirstPageFnolPdfAndDocsImages({
    required BuildContext context,
    required GetAccidentDetailsModel accidentDetails,
    required List<ImagesModel> docsImages,
    bool isExport = false,
    bool isSend = false,
  }) async {
    final pdf = pw.Document();
    var logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/delta_lodo.jpg'))
          .buffer
          .asUint8List(),
    );
    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));
    pdf.addPage(
      _firstPage(arabicFont, logo, accidentDetails),
    );
    printWarning('Pdf First page created successfully');

    ///* 1- Docs Images
    printWarning('docsImages length : ${docsImages.length}');
    for (int i = 0; i < docsImages.length; i++) {
      printWarning('image : $i');
      printWarning('staticImageTag : ${docsImages[i].imageName}');
      pdf.addPage(
        await _imagesPage(
          title: appBloc.imagesInstructions['${docsImages[i].imageName}']!,
          arabicFont: arabicFont,
          staticImageTag: docsImages[i].imageName ?? '',
          image: docsImages[i].imagePath ?? '',
        ),
      );
    }
    return pdf;
  }

  ///* create pdf Without first page
  static Future<pw.Document> createFnolpdfAccedentImages({
    required BuildContext context,
    required GetAccidentDetailsModel accidentDetails,
    required List<ImagesModel> accentedImages,
    bool isExport = false,
    bool isSend = false,
  }) async {
    final pdf = pw.Document();
    var logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/delta_lodo.jpg'))
          .buffer
          .asUint8List(),
    );

    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));

    ///*  2- Accented Images
    printWarning('accentedImages length : ${accentedImages.length}');
    for (int i = 0; i < accentedImages.length; i++) {
      printWarning('image : $i');
      printWarning('staticImageTag : ${accentedImages[i].imageName}');
      pdf.addPage(
        await _imagesPage(
          title: appBloc.imagesInstructions['${accentedImages[i].imageName}']!,
          arabicFont: arabicFont,
          staticImageTag: accentedImages[i].imageName ?? '',
          image: accentedImages[i].imagePath ?? '',
        ),
      );
    }
    printWarning('create Fnol pdf Without First Page Done');
    return pdf;
  }

  ///* create inspection Pdf
  static Future<pw.Document> generateFnolPdf({
    required BuildContext context,
    required GetAccidentDetailsModel accidentDetails,
    required List<ImagesModel> docsImages,
    required List<ImagesModel> accentedImages,
    bool isExport = false,
    bool isSend = false,
  }) async {
    final pdf = pw.Document();
    var logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/delta_lodo.jpg'))
          .buffer
          .asUint8List(),
    );

    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Amiri-Regular.ttf"));

    pdf.addPage(
      _firstPage(arabicFont, logo, accidentDetails),
    );
    printWarning('Pdf First page created successfully');

    ///* 1- Docs Images
    printWarning('docsImages length : ${docsImages.length}');
    for (int i = 0; i < docsImages.length; i++) {
      printWarning('image : $i');
      printWarning('staticImageTag : ${docsImages[i].imageName}');
      pdf.addPage(
        await _imagesPage(
          title: appBloc.imagesInstructions['${docsImages[i].imageName}']!,
          arabicFont: arabicFont,
          staticImageTag: docsImages[i].imageName ?? '',
          image: docsImages[i].imagePath ?? '',
        ),
      );
    }

    ///*  2- Accented Images
    printWarning('accentedImages length : ${accentedImages.length}');
    for (int i = 0; i < accentedImages.length; i++) {
      printWarning('image : $i');
      printWarning('staticImageTag : ${accentedImages[i].imageName}');
      pdf.addPage(
        await _imagesPage(
          title: appBloc.imagesInstructions['${accentedImages[i].imageName}']!,
          arabicFont: arabicFont,
          staticImageTag: accentedImages[i].imageName ?? '',
          image: accentedImages[i].imagePath ?? '',
        ),
      );
    }
    return pdf;
  }

  static void exportPdf({required pw.Document pdf}) async {
    printWarning('Pdf created successfully');
    final bytes = await pdf.save();
    printWarning('Pdf saved successfully');
    await saveAndDownloadFile(
      bytesUint8List: bytes,
      fileName: 'new_pdf.pdf',
    );
    printWarning('Pdf downloaded successfully');
  }

  ///* First page of inspection pdf
  static pw.Page _firstPage(pw.Font arabicFont, pw.MemoryImage logo,
      GetAccidentDetailsModel accidentDetails) {
    return pw.Page(
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      build: (context) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
            ),
          ),
          child: pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              children: [
                ///* 1
                pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(logo, width: 100, height: 100),
                      pw.Column(
                        children: [
                          pw.Text(
                            'شركة الدلتا للتأمين',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              height: 0.5,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Text(
                            'DELTA INSURANCE COMPANY',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              height: 0.5,
                            ),
                            textDirection: pw.TextDirection.ltr,
                          ),
                          pw.Text(
                            'الإدارة العامة لتعويضات السيارات',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              height: 0.5,
                            ),
                          ),
                          pw.Text(
                            'ت / 01013010592 - 01120900030',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              height: 0.5,
                            ),
                          ),
                          pw.Text(
                            'ف / 01013010592',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///* 2
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 150,
                      height: 60,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                        ),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            ' رقم المطالبة',
                            textDirection: pw.TextDirection.rtl,
                            style: const pw.TextStyle(
                              height: 0.5,
                            ),
                          ),
                          pw.Divider(
                            color: PdfColors.black,
                            thickness: 1,
                          ),
                          pw.Text(
                            ' تاريخ تقديم الإخطار',
                            textDirection: pw.TextDirection.rtl,
                            style: const pw.TextStyle(
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Text(
                      'اخطار عن حادث سيارة',
                      style: const pw.TextStyle(
                        fontSize: 12,
                        height: 1,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.SizedBox(
                      width: 150,
                      height: 60,
                    ),
                  ],
                ),

                ///* 3
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات المؤمن لة',
                      // linkItemKey: 1,
                      // fnolLat: accidentDetails.report?.location?.lat,
                      // fnolLng: accidentDetails.report?.location?.lng,
                      items: [
                        {
                          'الإسم : ': accidentDetails.report?.client ?? '',
                        },
                        {
                          'العنوان : ': '',
                        },
                        {
                          'رقم التليفون : ':
                              accidentDetails.report?.phoneNumber ?? '',
                        },
                        {
                          'رقم الفاكس : ': '',
                        },
                      ],
                    )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات الوثيقة',
                      items: [
                        {
                          'رقم الوثيقة : ':
                              accidentDetails.report?.car?.policyNumber ?? '',
                        },
                        {
                          'جهة الإصدار : ': accidentDetails
                                  .report?.car?.insuranceCompany?.arName ??
                              '',
                        },
                        {
                          'مدة التأمين : ':
                              accidentDetails.report?.car?.policyEnds != null &&
                                      accidentDetails.report?.car?.policyEnds !=
                                          ''
                                  ? DateTime.parse(accidentDetails
                                                  .report?.car?.policyEnds ??
                                              '')
                                          .shortDateMonthYearFormat ??
                                      ''
                                  : '',
                        },
                        {
                          'مبلغ التأمين : ': '',
                        },
                      ],
                    )),
                  ],
                ),

                ///* 4
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات السيارة',
                      items: [
                        {
                          'رقم السيارة : ':
                              accidentDetails.report?.car?.plateNumber ?? '',
                        },
                        {
                          'رقم الشاسية : ':
                              accidentDetails.report?.car?.vinNumber ?? '',
                        },
                        {
                          'الماركة / الموديل : ':
                              '${accidentDetails.report?.car?.manufacturer?.arName ?? ''} ${accidentDetails.report?.car?.carModel?.arName ?? ''}',
                        },
                      ],
                    )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات الحادث',
                      items: [
                        {
                          'تاريخ الحادث : ': DateTime.parse(
                                      accidentDetails.report?.createdAt ??
                                          '' ??
                                          '')
                                  .shortDateMonthYearFormat ??
                              '',
                        },
                        {
                          'وقت وقوع الحادث : ': '',
                        },
                        {
                          'تاريخ الإبلاغ : ': '',
                        },
                      ],
                    )),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات السائق',
                      items: [
                        {
                          'اسم السائق : ': '',
                        },
                        {
                          'رقم ونوع رخصة القيادة : ': '',
                        },
                        {
                          'تاريخ انتهائها : ': '',
                        },
                      ],
                    )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات محضر الشرطة',
                      items: [
                        {
                          'رقم المحضر : ': '',
                        },
                        {
                          'تاريخ المحضر : ': '',
                        },
                        {
                          'مكان تحريرة : ': '',
                        },
                      ],
                    )),
                  ],
                ),
                // if (accidentDetails.report?.location?.address != null) ...[
                //   pw.UrlLink(
                //     child: pw.Text(
                //
                //       style: const pw.TextStyle(
                //         color: PdfColors.green,
                //         fontSize: 8,
                //         height: 1,
                //         decoration: pw.TextDecoration.underline,
                //         decorationColor: PdfColors.green,
                //       ),
                //       textDirection: pw.TextDirection.rtl,
                //     ),
                //     destination:
                //     'https://www.google.com/maps/search/?api=1&query=${accidentDetails.report?.location?.lat},${accidentDetails.report?.location?.lng}',
                //   ),
                //   pw.SizedBox(
                //     width: 5,
                //   ),
                // ],

                ///* 6
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        if (accidentDetails.report?.commentUser != null &&
                            accidentDetails.report?.commentUser != '') ...[
                          pw.UrlLink(
                            child: pw.Text(
                              'اضغط هنا للاستماع',
                              style: const pw.TextStyle(
                                color: PdfColors.blue,
                                fontSize: 8,
                                height: 1,
                                decoration: pw.TextDecoration.underline,
                                decorationColor: PdfColors.blue,
                              ),
                              textDirection: pw.TextDirection.rtl,
                            ),
                            destination:
                                '$imagesBaseUrl${accidentDetails.report?.commentUser ?? ''}',
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                        ],
                        pw.Text(
                          'شرح كيفية وقوع الحادث : ',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        if (accidentDetails.report?.location?.address !=
                            null) ...[
                          pw.UrlLink(
                            child: pw.Text(
                              '${accidentDetails.report?.location?.address}',
                              style: const pw.TextStyle(
                                color: PdfColors.blue,
                                fontSize: 8,
                                height: 1,
                                decoration: pw.TextDecoration.underline,
                                decorationColor: PdfColors.blue,
                              ),
                              textDirection: pw.TextDirection.rtl,
                            ),
                            destination:
                                'https://www.google.com/maps/search/?api=1&query=${accidentDetails.report?.location?.lat},${accidentDetails.report?.location?.lng}',
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                        ],
                        pw.Text(
                          'موقع الحادث : ',
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                        ),
                      ),
                      child: pw.Text(
                        (accidentDetails.report?.comment != null &&
                                (accidentDetails.report?.comment?.isNotEmpty ??
                                    false)
                            ? '${accidentDetails.report!.comment!}\n ${accidentDetails.report?.audioCommentWritten ?? ''}'
                            : accidentDetails.report?.audioCommentWritten ??
                                ''),
                        style: const pw.TextStyle(
                          color: PdfColors.blue,
                          fontSize: 8,
                          height: 1,
                        ),
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        textDirection: pw.TextDirection.rtl,
                      ),
                    ),
                  ],
                ),

                ///* 7
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'بيان تفصيلي عن الاضرار التي لحقت بالسيارة',
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.black,
                        height: 1,
                      ),
                      textDirection: pw.TextDirection.rtl,
                    ),
                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                        ),
                      ),
                      child: pw.Text(
                        'جاري عمل مقايسة وتحديد مكان الإصاح',
                        style: const pw.TextStyle(
                          color: PdfColors.blue,
                          fontSize: 8,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                ///* 8
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيان مكان إصلاح السيارة المؤمن عليها',
                      items: [
                        {
                          'مكان الإصلاح : ': '',
                        },
                        {
                          'العنوان : ': '',
                        },
                        {
                          'رقم التليفون : ': '',
                        },
                      ],
                    )),
                  ],
                ),

                ///* 9
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: _boxInfoItem(
                      title: 'بيانات السيارة الأخري (الخصم)',
                      items: [
                        {
                          'رقم السيارة : ': '',
                        },
                        {
                          'لماركة / الموديل : ': '',
                        },
                        {
                          'اسم مالك السيارة : ': '',
                        },
                        {
                          'العنوان : ': '',
                        },
                        {
                          'بيان الاضرار التي لحقت بسيارة الغير : ': '',
                        },
                      ],
                    )),
                  ],
                ),

                ///* 10
                pw.Text(
                  'اقر أنا الموقع ادناة بأن البيانات الواردة في هذا النموذج صحيحة وأنني مسئول عنها وعن صحتها وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض',
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.red,
                    height: 1,
                  ),
                ),

                ///* 11
                pw.Text(
                  'كما اقر بأن تسليم هذا الإخطار الي الشركة لا يمكن ان يعتبر بأي حال من الأحوال قبولا منها للحادث',
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 8,
                    decoration: pw.TextDecoration.underline,
                    height: 1,
                  ),
                  textAlign: pw.TextAlign.right,
                  textDirection: pw.TextDirection.rtl,
                ),

                ///* 12
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'تحرير في',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        height: 1,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      'توقيع مقدم الاخطار',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        height: 1,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Text(
                      'توقيع المؤمن له',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        height: 1,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///* images Page
  static Future<pw.Page> _imagesPage({
    required pw.Font arabicFont,
    required String title,
    required String staticImageTag,
    required String image,
  }) async {
    var staticImage = staticImageTag.isEmpty
        ? null
        : pw.MemoryImage(
            (await rootBundle
                    .load('assets/images/fnol_images/$staticImageTag.png'))
                .buffer
                .asUint8List(),
          );

    // ///* convert network images to memory images
    // var networkImages = <pw.MemoryImage>[];
    // for (var image in images) {
    //   printWarning('image url $imagesBaseUrl$image');
    //   networkImages.add(
    //     pw.MemoryImage(
    //       (await http.get(Uri.parse('$imagesBaseUrl$image'))).bodyBytes,
    //     ),
    //   );
    // }
    // printWarning('Memory Image ${networkImages.length}');

    var networkImage = pw.MemoryImage(
      (await http.get(Uri.parse('$imagesBaseUrl$image'))).bodyBytes,
    );
    return pw.Page(
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      build: (context) {
        return pw.Container(
          width: double.infinity,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.green,
            ),
          ),
          child: pw.Column(
            children: [
              ///* 1- Container Title
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: const pw.BoxDecoration(
                  color: PdfColors.green,
                  borderRadius: pw.BorderRadius.only(
                    bottomLeft: pw.Radius.circular(20),
                    bottomRight: pw.Radius.circular(20),
                  ),
                ),
                child: pw.Text(
                  title,
                  style: const pw.TextStyle(
                    fontSize: 20,
                    color: PdfColors.white,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),

              ///* 2- static Image
              if (staticImage != null) ...[
                // pw.Expanded(
                //   flex:4,
                //   child: pw.Container(
                //     child: pw.Image(
                //       staticImage,
                //       fit: pw.BoxFit.contain,
                //       height: 150,
                //     ),
                //   ),
                // ),
                pw.Container(
                  height: 150,
                  child: pw.Image(
                    staticImage,
                    fit: pw.BoxFit.contain,
                    height: 150,
                  ),
                ),
              ] else ...[
                // pw.Expanded(
                //   flex: 4,
                //   child: pw.Container(),
                // ),
                pw.Container(
                  height: 150,
                ),
              ],
              pw.SizedBox(
                height: 10,
              ),

              ///* 3- Image
              pw.Expanded(
                flex: 6,
                child: pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.green,
                    ),
                  ),
                  child: pw.UrlLink(
                    child: pw.Image(
                      networkImage,
                      fit: pw.BoxFit.contain,
                    ),
                    destination: '$imagesBaseUrl$image',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static pw.Column _boxInfoItem({
    required String title,
    required List<Map<String, String>> items,
    int? linkItemKey,
    double? fnolLat,
    double? fnolLng,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          title,
          style: const pw.TextStyle(
            fontSize: 10,
            height: 1,
            color: PdfColors.black,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(4),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
            ),
          ),
          child: pw.Column(
            children: [
              for (var item in items) ...{
                _infoItem(
                  title: item.keys.first,
                  value: item.values.first,
                  isLink: linkItemKey == items.indexOf(item),
                  fnolLat: fnolLat,
                  fnolLng: fnolLng,
                ),
              },
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _infoItem({
    required String title,
    required String value,
    bool isLink = false,
    double? fnolLat,
    double? fnolLng,
  }) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Expanded(
            child: isLink
                ? pw.UrlLink(
                    child: pw.Text(
                      value,
                      textDirection: pw.TextDirection.rtl,
                      maxLines: 1,
                      overflow: pw.TextOverflow.clip,
                      style: const pw.TextStyle(
                        fontSize: 8,
                        color: PdfColors.blue,
                        decoration: pw.TextDecoration.underline,
                        decorationColor: PdfColors.blue,
                      ),
                    ),
                    destination:
                        'https://www.google.com/maps/search/?api=1&query=$fnolLat,$fnolLng',
                  )
                : pw.Text(
                    value,
                    textDirection: pw.TextDirection.rtl,
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    style: const pw.TextStyle(
                      height: 1,
                      fontSize: 8,
                      color: PdfColors.blue,
                    ),
                  ),
          ),
          pw.Text(
            title,
            textDirection: pw.TextDirection.rtl,
            style: const pw.TextStyle(
              height: 1,
              fontSize: 8,
              color: PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  ///* create pdf and convert it to base64
  static Future<String> getPdfBase64({
    required pw.Document pdf,
  }) async {
    printWarning('getPdfBase64 -------');
    final pdfBytes = await pdf.save();
    final pdfBase64 = base64Encode(pdfBytes);
    // debugPrintFullText('pdfBase64: $pdfBase64');
    return Future.value(pdfBase64);
  }

  ///* Save pdf file
  static Future saveAndDownloadFile({
    required Uint8List? bytesUint8List,
    required String fileName,
  }) async {
    if (bytesUint8List != null) {
      //* For WEB
      if (kIsWeb) {
        AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytesUint8List)}')
          ..setAttribute('download', fileName)
          ..click();
      }
      //*  For MacOSX
      else {
        String path = await macOSDownloadHelper(
            bytesUint8List: bytesUint8List, fileName: fileName);
        debugPrint(path);
      }
      HelpooInAppNotification.showSuccessMessage(
          message: 'File saved successfully');
    }
  }

  ///* MacOSX Download Helper
  static Future<String> macOSDownloadHelper(
      {required List<int> bytesUint8List, required String fileName}) async {
    Directory directory = await getTemporaryDirectory();
    String path = "${directory.path}/$fileName";
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytesUint8List);
    return path;
  }
}
