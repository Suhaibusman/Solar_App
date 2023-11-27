import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_app/controller/chat_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController msgController = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: ctext(
            text: 'Chat',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: white),
        leading:reusableBackButton(),
        
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            SvgConstants.homeBg,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: double.maxFinite,
            height: Get.height,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Lottie.asset(ImageConstants.bot,
                        height: Get.height * 0.2)),
                smallSpace,
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: chatController.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = chatController.messages[index];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipPath(
                                    clipper: LowerNipMessageClipper(
                                        MessageType.send),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: lightPrimaryTextColor,
                                      ),
                                      child: ctext(
                                        maxLines:
                                            6,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        text: message.toString(),
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ctext(
                                    text: '12:34 PM',
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              mediumSpaceh,
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "https://img.freepik.com/free-photo/woman-with-long-hair-yellow-hoodie-with-word-music-it_1340-39068.jpg?size=626&ext=jpg&ga=GA1.1.117946456.1673173317&semt=sph",
                                ),
                              ).paddingOnly(top: 15),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextField(
                            controller: msgController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: primarycolor.withOpacity(.3),
                              hintText: 'Type Something',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final msg = msgController.text;
                          chatController.addMessage(msg);
                          msgController.clear();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: white.withOpacity(.7),
                          ),
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.send,
                            color: btnPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
