import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/AppColors.dart';
import '../../provider/chat_Provider.dart';

class LiveChatScreen extends StatelessWidget {
  LiveChatScreen({super.key});

  final TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatProvider>(context);

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: Center(
        child: Container(
          width: w * 0.90,
          margin: EdgeInsets.only(top: h * 0.04),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [

              /// 🔵 TOP HEADER
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: h * 0.02,
                  horizontal: w * 0.05,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Live Chat Support",
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Typically replies within minutes.",
                      style: GoogleFonts.inter(
                        color: AppColors.white.withOpacity(0.85),
                        fontSize: w * 0.035,
                      ),
                    ),
                  ],
                ),
              ),

              /// 🟦 CHAT AREA
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(w * 0.04),
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) {
                    final msg = chat.messages[index];

                    return Align(
                      alignment: msg["isMe"]
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: w * 0.65),
                        margin: EdgeInsets.symmetric(vertical: h * 0.006),
                        padding: EdgeInsets.all(w * 0.03),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg["msg"],
                              style: GoogleFonts.inter(
                                fontSize: w * 0.040,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              msg["time"],
                              style: GoogleFonts.inter(
                                fontSize: w * 0.030,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// 📝 INPUT BOX
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Row(
                  children: [
                    /// TEXT FIELD
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03,
                          vertical: h * 0.014,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                          color: AppColors.white,
                        ),
                        child: TextField(
                          controller: msgController,
                          style: GoogleFonts.inter(
                            fontSize: w * 0.038,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type your message...",
                            hintStyle: GoogleFonts.inter(
                              color: AppColors.textGrey,
                              fontSize: w * 0.036,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: w * 0.03),

                    /// SEND BUTTON
                    GestureDetector(
                      onTap: () {
                        if (msgController.text.trim().isNotEmpty) {
                          chat.sendMessage(msgController.text.trim());
                          msgController.clear();
                        }
                      },
                      child: CircleAvatar(
                        radius: w * 0.06,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.send,
                          color: AppColors.white,
                          size: w * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
