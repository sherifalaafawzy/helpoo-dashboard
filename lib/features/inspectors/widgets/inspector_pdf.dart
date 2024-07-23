import 'dart:convert';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../core/models/accident_report_details_model.dart';
import '../../../core/util/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

//create a pdf for inspector with inspection details
class InspectorPdf {
  static Future<String> generateBodyBDF({
    required BuildContext context,
    required String clientName,
    required String clientAddress,
    required String clientGovernment,
    required String clientCity,
    required String carType,
    required String carModel,
    required String vinNumber,
    required String plateNumber,
    required String inspectionDate,
    List<PlatformFile>? images,
    List<ImagesModel>? fnolImages,
    List<ImagesModel>? policyImages,
    List<ImagesModel>? beforeImages,
    List<ImagesModel>? supplementImages,
    bool isHasSupplementLocation = false,
    bool isHasBeforeLocation = false,
    bool isHasFnolLocation = false,
    bool isHasPolicyLocation = false,
    double? beforeLat,
    double? beforeLng,
    double? fnolLat,
    double? fnolLng,
    double? policyLat,
    double? policyLng,
    double? supplementLat,
    double? supplementLng,
  }) async {
    final pdf = pw.Document();
    var helpooImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/favicon.png')).buffer.asUint8List(),
    );

    var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/PFDinTextArabic-Regular.ttf"));

    // final netImage = await networkImage();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(4.0),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(8.0),
              border: pw.Border.all(
                color: PdfColors.black,
              ),
            ),
            child: pw.Column(
              children: [
                pw.Center(
                  child: pw.Image(helpooImage, width: 20.0, height: 20.0),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'Client Information',
                        style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5.0),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                              'Client Name : $clientName',
                              style: const pw.TextStyle(fontSize: 5.0),
                              textDirection: pw.TextDirection.rtl,
                            ),
                          ),
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Client Government : $clientGovernment',
                              style: const pw.TextStyle(fontSize: 5.0),
                              textDirection: pw.TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5.0),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.UrlLink(
                              child: pw.Text(
                                'Client Address : $clientAddress',
                                style: const pw.TextStyle(
                                  fontSize: 5.0,
                                  color: PdfColors.blue,
                                ),
                                textDirection: pw.TextDirection.rtl,
                              ),
                              destination: 'https://www.google.com/maps/search/?api=1&query=$fnolLat,$fnolLng',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5.0),
                pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey), height: 0.0),
                pw.Column(
                  children: [
                    pw.SizedBox(height: 5.0),
                    pw.Text('Car Information', style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 8.0),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Car Type : $carType',
                          style: const pw.TextStyle(fontSize: 5.0),
                          textDirection: pw.TextDirection.rtl,
                        ),
                        pw.Text(
                          'Car Model : $carModel',
                          style: const pw.TextStyle(fontSize: 5.0),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Vin Number: $vinNumber', style: const pw.TextStyle(fontSize: 5.0)),
                        pw.Text(
                          'Plate Number: $plateNumber',
                          style: const pw.TextStyle(
                            fontSize: 5.0,
                          ),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 5.0),
                pw.Divider(thickness: 0.5, color: PdfColor.fromHex(regularGrey), height: 0.0),
                pw.Column(
                  children: [
                    pw.SizedBox(height: 5.0),
                    pw.Text(
                      'Inspection Information',
                      style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 8.0),
                    pw.Text('Inspection Date : $inspectionDate', style: const pw.TextStyle(fontSize: 5.0)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    // inspection images
    if (images != null) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(4.0),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8.0),
                border: pw.Border.all(
                  color: PdfColors.black,
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Column(
                    children: [
                      ...{
                      pw.SizedBox(height: 5.0),
                      pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              'Inspection Images',
                              style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5.0),
                      pw.ListView.builder(
                        spacing: 3,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 100,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                            ),
                            child: pw.Image(
                              pw.MemoryImage(
                                images[index].bytes!,
                              ),
                            ),
                          );
                        },
                        itemCount: images.length,
                      ),
                    },
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    if (fnolImages != null) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(4.0),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8.0),
                border: pw.Border.all(
                  color: PdfColors.black,
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Column(
                    children: [
                      // fnol images area
                      ...{
                      pw.SizedBox(height: 5.0),
                      pw.Text(
                        'FNOL Images',
                        style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5.0),
                      if (isHasFnolLocation)
                        pw.UrlLink(
                          child: pw.Text(
                            'FNOL Address',
                            style: const pw.TextStyle(
                              fontSize: 5.0,
                              color: PdfColors.blue,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          destination: 'https://www.google.com/maps/search/?api=1&query=$fnolLat,$fnolLng',
                        ),
                      if (isHasFnolLocation) pw.SizedBox(height: 5.0),
                      pw.ListView.builder(
                        spacing: 5,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 10,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                            ),
                            child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                              pw.Text(
                                '${index + 1} - ',
                                style: pw.TextStyle(
                                  fontSize: 5.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(width: 5.0),
                              pw.UrlLink(
                                child: pw.Text(
                                  fnolImages[index].imageName ?? 'Image ${index + 1}',
                                  style: pw.TextStyle(
                                    fontSize: 5.0,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                                destination: fnolImages[index].imagePath!,
                              ),
                            ]),
                          );
                        },
                        itemCount: fnolImages.length,
                      ),
                    },
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    if (policyImages != null) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(4.0),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8.0),
                border: pw.Border.all(
                  color: PdfColors.black,
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Column(
                    children: [
                      // policy images area
                      ...{
                      pw.SizedBox(height: 5.0),
                      pw.Text(
                        'Policy Images',
                        style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5.0),
                      pw.ListView.builder(
                        spacing: 5,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 10,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                            ),
                            child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                              pw.Text(
                                '${index + 1} - ',
                                style: pw.TextStyle(
                                  fontSize: 5.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(width: 5.0),
                              pw.UrlLink(
                                child: pw.Text(
                                  policyImages[index].imageName ?? 'Image ${index + 1}',
                                  style: pw.TextStyle(
                                    fontSize: 5.0,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                                destination: policyImages[index].imagePath!,
                              ),
                            ]),
                          );
                        },
                        itemCount: policyImages.length,
                      ),
                    },
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    if (beforeImages != null) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(4.0),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8.0),
                border: pw.Border.all(
                  color: PdfColors.black,
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Column(
                    children: [
                      // before images area
                      ...{
                      pw.SizedBox(height: 5.0),
                      pw.Text(
                        'Before Repair Images',
                        style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5.0),
                      if (isHasBeforeLocation)
                        pw.UrlLink(
                          child: pw.Text(
                            'Before Repair Address',
                            style: const pw.TextStyle(
                              fontSize: 5.0,
                              color: PdfColors.blue,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          destination: 'https://www.google.com/maps/search/?api=1&query=$beforeLat,$beforeLng',
                        ),
                      if (isHasBeforeLocation) pw.SizedBox(height: 5.0),
                      pw.ListView.builder(
                        spacing: 5,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 10,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                            ),
                            child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                              pw.Text(
                                '${index + 1} - ',
                                style: pw.TextStyle(
                                  fontSize: 5.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(width: 5.0),
                              pw.UrlLink(
                                child: pw.Text(
                                  beforeImages[index].imageName ?? 'Image ${index + 1}',
                                  style: pw.TextStyle(
                                    fontSize: 5.0,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                                destination: beforeImages[index].imagePath!,
                              ),
                            ]),
                          );
                        },
                        itemCount: beforeImages.length,
                      ),
                    },
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    if (supplementImages != null) {
      pdf.addPage(
        pw.Page(
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(4.0),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8.0),
                border: pw.Border.all(
                  color: PdfColors.black,
                ),
              ),
              child: pw.Column(
                children: [
                  pw.Column(
                    children: [
                      // supplement images area
                      ...{
                      pw.SizedBox(height: 5.0),
                      pw.Text(
                        'Supplement Images',
                        style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5.0),
                      if (isHasSupplementLocation)
                        pw.UrlLink(
                          child: pw.Text(
                            'Supplement Address',
                            style: const pw.TextStyle(
                              fontSize: 5.0,
                              color: PdfColors.blue,
                            ),
                            textDirection: pw.TextDirection.rtl,
                          ),
                          destination:
                              'https://www.google.com/maps/search/?api=1&query=$supplementLat,$supplementLng',
                        ),
                      if (isHasSupplementLocation) pw.SizedBox(height: 5.0),
                      pw.ListView.builder(
                        spacing: 5,
                        itemBuilder: (context, index) {
                          return pw.Container(
                            height: 10,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                            ),
                            child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                              pw.Text(
                                '${index + 1} - ',
                                style: pw.TextStyle(
                                  fontSize: 5.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(width: 5.0),
                              pw.UrlLink(
                                child: pw.Text(
                                  supplementImages[index].imageName ?? 'Image ${index + 1}',
                                  style: pw.TextStyle(
                                    fontSize: 5.0,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                                destination: supplementImages[index].imagePath!,
                              ),
                            ]),
                          );
                        },
                        itemCount: supplementImages.length,
                      ),
                    },
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    var x = await getPdfBase64(pdf: pdf);

    return x;
  }

  ///* create inspection Pdf
  static Future<String> createInspectionPdf({
    required BuildContext context,
    required GetAccidentDetailsModel accidentDetails,
  }) async {
    final pdf = pw.Document();
    var logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/delta_lodo.jpg')).buffer.asUint8List(),
    );

    var arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Ara-Hamah-1982-Regular.ttf"),
    );

    // final netImage = await networkImage();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(4.0),
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
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text(
                            'شركة الدلتا للتأمين',
                            style: const pw.TextStyle(fontSize: 22),
                          ),
                          pw.Text(
                            'DELTA INSURANCE COMPANY',
                            style: const pw.TextStyle(fontSize: 22),
                            textDirection: pw.TextDirection.ltr,
                          ),
                          pw.Text(
                            'الإدارة العامة لتعويضات السيارات',
                            style: const pw.TextStyle(fontSize: 22),
                          ),
                          pw.Text(
                            'ت / 01013010592 - 01120900030',
                            style: const pw.TextStyle(fontSize: 22),
                          ),
                          pw.Text(
                            'ف / 01013010592',
                            style: const pw.TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      pw.Image(logo, width: 100, height: 100),
                    ],
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),

                  ///* 2
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(),
                      pw.Text(
                        'اخطار عن حادث سيارة',
                        style: const pw.TextStyle(
                          fontSize: 22,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                      pw.Container(
                        width: 200,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('رقم المطالبة'),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 1,
                            ),
                            pw.Text('تاريخ تقديم الإخطار'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),

                  ///* 3
                  pw.Row(
                    children: [
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات المؤمن لة',
                        items: [
                          {
                            'title': 'الإسم',
                            'value': 'عبدالله أحمد',
                          },
                          {
                            'title': 'العنوان',
                            'value': 'التجمع الاول',
                          },
                          {
                            'title': 'رقم التليفون',
                            'value': '01013010592',
                          },
                          {
                            'title': 'رقم الفاكس',
                            'value': '01013010592',
                          },
                        ],
                      )),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات الوثيقة',
                        items: [
                          {
                            'title': 'رقم الوثيقة',
                            'value': '133456',
                          },
                          {
                            'title': 'جهة الإصدار',
                            'value': 'الرئيسي',
                          },
                          {
                            'title': 'مدة التأمين',
                            'value': '7/7/2024',
                          },
                          {
                            'title': 'مبلغ التأمين',
                            'value': '600000',
                          },
                        ],
                      )),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 4
                  pw.Row(
                    children: [
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات السيارة',
                        items: [
                          {
                            'title': 'رقم السيارة',
                            'value': 'ا ف ن 258',
                          },
                          {
                            'title': 'رقم الشاسية',
                            'value': '35426025',
                          },
                          {
                            'title': 'الماركة / الموديل',
                            'value': 'نيسان صني 2019',
                          },
                        ],
                      )),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات الحادث',
                        items: [
                          {
                            'title': 'تاريخ الحادث',
                            'value': '28/07/2023',
                          },
                          {
                            'title': 'وقت وقوع الحادث',
                            'value': '',
                          },
                          {
                            'title': 'تاريخ الإبلاغ',
                            'value': '29/07/2023',
                          },
                        ],
                      )),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  pw.Row(
                    children: [
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات السائق',
                        items: [
                          {
                            'title': 'اسم السائق',
                            'value': 'عبدالله أحمد',
                          },
                          {
                            'title': 'رقم ونوع رخصة القيادة',
                            'value': 'خاصة',
                          },
                          {
                            'title': 'تاريخ انتهائها',
                            'value': '07/07/2028',
                          },
                        ],
                      )),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات محضر الشرطة',
                        items: [
                          {
                            'title': 'رقم المحضر',
                            'value': '',
                          },
                          {
                            'title': 'تاريخ المحضر',
                            'value': '',
                          },
                          {
                            'title': 'مكان تحريرة',
                            'value': '',
                          },
                        ],
                      )),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 6
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'شرح كيفية وقوع الحادث',
                        style: const pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 2,
                          ),
                        ),
                        child: pw.Text(
                          'عند السير في منطقة العبور بالقرب من محطة مترو العبور وقع حادث تصادم بين السيارة رقم 1234 والسيارة رقم 5678',
                          style: const pw.TextStyle(
                            color: PdfColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 7
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'بيان تفصيلي عن الاضرار التي لحقت بالسيارة',
                        style: const pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 2,
                          ),
                        ),
                        child: pw.Text(
                          'جاري عمل مقايسة وتحديد مكان الإصاح',
                          style: const pw.TextStyle(
                            color: PdfColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 8
                  pw.Row(
                    children: [
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيان مكان إصلاح السيارة المؤمن عليها',
                        items: [
                          {
                            'title': 'مكان الإصلاح',
                            'value': 'الميكانيكيون العرب',
                          },
                          {
                            'title': 'العنوان',
                            'value': '128 جوزيف تيتو ',
                          },
                          {
                            'title': 'رقم التليفون',
                            'value': '01013010592',
                          },
                        ],
                      )),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 9
                  pw.Row(
                    children: [
                      pw.Expanded(
                          child: _boxInfoItem(
                        title: 'بيانات السيارة الأخري (الخصم)',
                        items: [
                          {
                            'title': 'رقم السيارة',
                            'value': '',
                          },
                          {
                            'title': 'لماركة / الموديل',
                            'value': '',
                          },
                          {
                            'title': 'اسم مالك السيارة',
                            'value': '',
                          },
                          {
                            'title': 'العنوان',
                            'value': '',
                          },
                          {
                            'title': 'بيان الاضرار التي لحقت بسيارة الغير',
                            'value': '',
                          },
                        ],
                      )),
                    ],
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 10
                  pw.Text(
                    'اقر أنا الموقع ادناة بأن البيانات الواردة في هذا النموذج صحيحة وأنني مسئول عنها وعن صحتها وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض وأنني أتعهد بتقديم كافة الوثائق والمستندات الداعمة للمطالبة والتعويض',
                    style: const pw.TextStyle(
                      color: PdfColors.red,
                    ),
                  ),

                  ///* 11
                  pw.Text(
                    'كما اقر بأن تسليم هذا الإخطار الي الشركة لا يمكن ان يعتبر بأي حال من الأحوال قبولا منها للحادث',
                    style: const pw.TextStyle(
                      color: PdfColors.black,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),

                  pw.SizedBox(
                    height: 5,
                  ),

                  ///* 12
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'تحرير في',
                        style: const pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Text(
                        'توقيع مقدم الاخطار',
                        style: const pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Text(
                        'توقيع المؤمن له',
                        style: const pw.TextStyle(
                          fontSize: 16,
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
      ),
    );
    return await getPdfBase64(pdf: pdf);
  }

  static pw.Column _boxInfoItem({
    required String title,
    required List<Map<String, String>> items,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: const pw.TextStyle(
            fontSize: 16,
            color: PdfColors.black,
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(4),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 2,
            ),
          ),
          child: pw.Column(
            children: [
              for (var item in items) ...{
                _infoItem(
                  title: item.keys.first,
                  value: item.values.first,
                ),
              },
            ],
          ),
        ),
      ],
    );
  }

  static pw.Row _infoItem({
    required String title,
    required String value,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: const pw.TextStyle(
            color: PdfColors.black,
          ),
        ),
        pw.Text(
          value,
          style: const pw.TextStyle(
            color: PdfColors.blue,
          ),
        ),
      ],
    );
  }

  ///* create pdf and convert it to base64
  static Future<String> getPdfBase64({
    required pw.Document pdf,
  }) async {
    final pdfBytes = await pdf.save();
    final pdfBase64 = base64Encode(pdfBytes);
    // debugPrintFullText('pdfBase64: $pdfBase64');
    debugPrintFullText('pdfBase64: done');
    return Future.value(pdfBase64);
  }
}
