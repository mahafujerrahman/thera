import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thera_track_app/controller/travel/travel_controller.dart';

import 'package:thera_track_app/service/api_constants.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/screens/home/travel/innerWidget/costDetailsWidget.dart';

class CostDetailsScreen extends StatefulWidget {
  @override
  State<CostDetailsScreen> createState() => _CostDetailsScreenState();
}

class _CostDetailsScreenState extends State<CostDetailsScreen> {
  TextEditingController emailController = TextEditingController();
  TravelController travelController = Get.put(TravelController());

  var travelID = Get.arguments;

  @override
  void initState() {
    super.initState();
    travelController.getOneCostDetails(travelID);

  }

  Future<void> _generateAndSendPDF() async {
    final pdf = pw.Document();

    final font = await pw.Font.ttf(await rootBundle.load('assets/fonts/Poppins-Regular.ttf'));
    final displayData = travelController.getOnelWalletDetails.value;

    pw.MemoryImage? receiptImage;

    // Load receipt image from network if available
    if (displayData.receiptImages != null && displayData.receiptImages!.isNotEmpty) {
      try {
        final uri = Uri.parse("${ApiConstants.imageBaseUrl}${displayData.receiptImages}");
        final httpClient = HttpClient();
        final request = await httpClient.getUrl(uri);
        final response = await request.close();

        if (response.statusCode == 200) {
          final bytes = await consolidateHttpClientResponseBytes(response);
          receiptImage = pw.MemoryImage(bytes);
        }
      } catch (e) {
        print("Error loading receipt image: $e");
        // You can choose to continue without the image
      }
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Cost Details', style: pw.TextStyle(fontSize: 24, font: font)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(width: 1, color: PdfColors.green),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Item', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('Value', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Departure', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.departure ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Destination', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.destination ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Distance', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.distance?.toString() ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Food', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.food?.toString() ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Gas', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.gas?.toString() ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text('Other', style: pw.TextStyle(font: font))),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text(displayData.other?.toString() ?? 'N/A', style: pw.TextStyle(font: font))),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              if (receiptImage != null)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Receipt Image:', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    pw.Image(receiptImage, width: 300, height: 200, fit: pw.BoxFit.contain),
                  ],
                ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/cost_details.pdf');
    await file.writeAsBytes(await pdf.save());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('Cost Details', style: AppStyles.fontSize16(color: AppColors.color575757)),
        centerTitle: true,
      ),
      body: Obx(() {
      return travelController.isLoading.value
          ? Center(child: CupertinoActivityIndicator(radius: 32.r, color: CupertinoColors.activeBlue))
          :  Obx(() {
        var displayData = travelController.getOnelWalletDetails.value;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CostDetailsWidget(title: 'Departure', value: displayData.departure ?? 'N/A'),
                CostDetailsWidget(title: 'Destination', value: displayData.destination.toString() ?? 'N/A'),
                CostDetailsWidget(title: 'Distance', value: displayData.distance.toString() ?? 'N/A'),
                CostDetailsWidget(title: 'Food',value: displayData.food.toString() ?? 'N/A'),
                CostDetailsWidget(title: 'Gas', value: displayData.gas.toString() ?? 'N/A'),
                CostDetailsWidget(title: 'Other', value: displayData.other.toString() ?? 'N/A'),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.w),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 250.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: (displayData.receiptImages != null)
                              ? "${ApiConstants.imageBaseUrl}${displayData.receiptImages}"
                              : 'assets/images/image_placeHolder.png',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset('assets/images/image_placeHolder.png'),
                        ),
                      ),
                    )
                  ),
                ),
                _buildEmailInputSection(),
              ],
            ),
          )
      );
    });
  })

  );
}
  Widget _buildEmailInputSection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter email here',
              hintStyle: AppStyles.fontSize14(color: AppColors.greyColor),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text('Data will be sent to the email above.', style: TextStyle(color: AppColors.blackColor)),
          SizedBox(height: 16.h),
          Center(
            child: SizedBox(
              width: 194.w,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _generateAndSendPDF();
                  final output = await getTemporaryDirectory();
                  final file = File('${output.path}/cost_details.pdf');
                  Share.shareXFiles([XFile(file.path)], text: 'Check out my PDF document');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("This PDF is ready for sharing"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: Icon(Icons.send, color: AppColors.whiteColor),
                label: Text('Send', style: TextStyle(color: AppColors.whiteColor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
