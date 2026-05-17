import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView
    extends GetView<SettingController> {

  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0D0F1A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        iconTheme:
            const IconThemeData(
          color: Colors.amber,
        ),

        title: const Text(
          "Settings",

          style: TextStyle(
            color: Colors.amber,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color:
                    const Color(
                  0xFF1A1F3A,
                ),

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Obx(
                () => Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.dark_mode,
                          color:
                              Colors.amber,
                        ),

                        SizedBox(
                          width: 12,
                        ),

                        Text(
                          "Dark Mode",

                          style:
                              TextStyle(
                            color:
                                Colors
                                    .white,

                            fontSize:
                                18,
                          ),
                        ),
                      ],
                    ),

                    Switch(
                      value: controller.isDarkMode.value,

                      activeColor:
                          Colors.amber,

                      onChanged:
                          controller.changeTheme,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}