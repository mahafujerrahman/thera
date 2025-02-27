import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/appDrawer/paid/innerWidget/clientRowWidget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PaidDetailsScreen extends StatefulWidget {
  @override
  State<PaidDetailsScreen> createState() => _PaidDetailsScreenState();
}

class _PaidDetailsScreenState extends State<PaidDetailsScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getAllPaidTreatmentDetails();
  }

  Future<void> _generateAndSendPDF() async {
    final pdf = pw.Document();

    final font = await pw.Font.ttf(await rootBundle.load('assets/fonts/Poppins-Regular.ttf'));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Paid Treatments', style: pw.TextStyle(fontSize: 24, font: font)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(width: 1),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Name', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Date', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Amount', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (var displayData in profileController.getAllPaidTreatmentModels)
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(displayData.name ?? 'N/A', style: pw.TextStyle(font: font)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),
                            style: pw.TextStyle(font: font),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('\$${displayData.finalCost}', style: pw.TextStyle(font: font)),
                        ),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Total: \$${profileController.paidTotalFinalCost}', style: pw.TextStyle(font: font)),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/paid_treatments.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paid Treatments',
          style: AppStyles.fontSize16(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
                  () => profileController.getAllPaidTreatmentModels.isEmpty
                  ? Center(child: Text('No paid treatments added yet.', style: TextStyle(color: Colors.black)))
                  : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profileController.getAllPaidTreatmentModels.length,
                    itemBuilder: (context, index) {
                      final displayData = profileController.getAllPaidTreatmentModels[index];
                      return ClientRowWidget(
                        status: 'paid',
                        name: displayData.name ?? 'N/A',
                        date: TimeFormatHelper.formatDate(DateTime.parse(displayData.createdAt.toString())),
                        amount: int.parse(displayData.finalCost.toString()),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              TimeFormatHelper.formatDate(DateTime.now()),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Obx(() => Text(
                          '${profileController.paidTotalFinalCost} \$',
                          style: TextStyle(
                            color: AppColors.greenColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildEmailInputSection(),
    );
  }

  Widget _buildEmailInputSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250.h,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.secondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter email here',
                hintStyle: AppStyles.fontSize14(color: AppColors.greyColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Data will be sent to the email above.',
              style: TextStyle(color: AppColors.blackColor),
            ),
            SizedBox(height: 16.h),
            Center(
              child: SizedBox(
                width: 194.w,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _generateAndSendPDF();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("This PDF is ready for work"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.send, color: AppColors.whiteColor),
                  label: Text('Send', style: TextStyle(color: AppColors.whiteColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 194.w,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _generateAndSendPDF();
                    final output = await getTemporaryDirectory();
                    final file = File('${output.path}/paid_treatments.pdf');
                    Share.shareXFiles([XFile(file.path)], text: 'Check out my PDF document');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("This PDF is ready for sharing"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.share, color: AppColors.whiteColor),
                  label: Text('Share', style: TextStyle(color: AppColors.whiteColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
