import 'dart:io';
import 'package:flutter/material.dart';

// PDF
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

import '../../../colors/AppColors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import 'TrackOrderScreen.dart';

class PlacedOrderScreen extends StatefulWidget {
  final String productName;
  final double totalAmount;
  final String paymentMethod;
  final String address;

  const PlacedOrderScreen({
    super.key,
    required this.productName,
    required this.totalAmount,
    required this.paymentMethod,
    required this.address,
  });

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mq.height * 0.04),
              child: Column(
                children: [

                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.width * 0.04,
                      vertical: mq.height * 0.015,
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: AppColors.primary),
                          SizedBox(width: mq.width * 0.02),
                          Text(
                            loc.getByKey('back'),
                            style: TextStyle(
                              fontSize: mq.width * 0.048,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 📦 ORDER TRACKING
                  _buildBox(
                    mq,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.getByKey('order_tracking'),
                          style: TextStyle(
                            fontSize: mq.width * 0.046,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        _timeline(mq, loc),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  /// 🛍 PRODUCT
                  _buildBox(
                    mq,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: mq.width * 0.042,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "₹${widget.totalAmount.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: mq.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  /// 🚚 DETAILS
                  _buildBox(
                    mq,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detail(
                          "${loc.getByKey('payment')} : ${widget.paymentMethod}",
                          mq,
                        ),
                        _detail(
                          "${loc.getByKey('delivery_address')} : ${widget.address}",
                          mq,
                        ),
                        SizedBox(height: mq.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loc.getByKey('total'),
                              style: TextStyle(
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹${widget.totalAmount.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: mq.width * 0.048,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// 🔘 BUTTONS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: _mainButton(
                            mq,
                            label: loc.getByKey('download_invoice'),
                            onTap: _generateInvoicePDF,
                          ),
                        ),
                        SizedBox(width: mq.width * 0.03),
                        Expanded(
                          child: _mainButton(
                            mq,
                            label: loc.getByKey('track'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const TrackOrderScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  /// ❌ CANCEL
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.25),
                    child: SizedBox(
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _showCancelDialog,
                        child: Text(
                          loc.getByKey('cancelled'),
                          style: TextStyle(
                            fontSize: mq.width * 0.04,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TIMELINE =================
  Widget _timeline(Size mq, AppLocalizations loc) {
    return Column(
      children: [
        _step(mq, 1, loc.getByKey('ordered'), loc.getByKey('today')),
        _step(mq, 2, loc.getByKey('packed'), loc.getByKey('pending')),
        _step(mq, 3, loc.getByKey('shipped'), loc.getByKey('pending')),
        _step(mq, 4, loc.getByKey('delivered'), loc.getByKey('pending')),
      ],
    );
  }

  Widget _step(Size mq, int step, String title, String date) {
    final completed = currentStep >= step;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: completed ? Colors.green : Colors.grey,
            ),
            if (step < 4)
              Container(
                height: mq.height * 0.06,
                width: 2,
                color: completed ? Colors.green : Colors.grey,
              ),
          ],
        ),
        SizedBox(width: mq.width * 0.04),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: completed ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: mq.width * 0.033,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: mq.height * 0.02),
          ],
        ),
      ],
    );
  }

  // ================= COMMON =================
  Widget _buildBox(Size mq, Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.03),
      padding: EdgeInsets.all(mq.width * 0.035),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _detail(String text, Size mq) {
    return Padding(
      padding: EdgeInsets.only(bottom: mq.height * 0.008),
      child: Text(
        text,
        style: TextStyle(
          fontSize: mq.width * 0.04,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _mainButton(
      Size mq, {
        required String label,
        required VoidCallback onTap,
      }) {
    return SizedBox(
      height: mq.height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D6CA3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            fontSize: mq.width * 0.04,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _showCancelDialog() {
    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc.getByKey('cancelled')),
        content: Text(loc.getByKey('cancel_confirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.getByKey('no')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.getByKey('order_cancelled')),
                ),
              );
              Future.delayed(
                const Duration(seconds: 2),
                    () => Navigator.pop(context),
              );
            },
            child: Text(loc.getByKey('yes')),
          ),
        ],
      ),
    );
  }

  // ================= PDF =================
  Future<void> _generateInvoicePDF() async {
    if (!await Permission.storage.request().isGranted) return;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "INVOICE",
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text("Product: ${widget.productName}"),
            pw.Text("Amount: ₹${widget.totalAmount.toStringAsFixed(0)}"),
            pw.Text("Payment: ${widget.paymentMethod}"),
            pw.Text("Address: ${widget.address}"),
            pw.SizedBox(height: 20),
            pw.Text(
              "Thank you for shopping with us!",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      "${dir.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf",
    );

    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
}
