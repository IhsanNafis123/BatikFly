import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/log_activity_controller.dart';

class LogActivityView extends GetView<LogActivityController> {
  const LogActivityView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(

        title: const Text("Log Activity"),

        centerTitle: true,

        elevation: 0,

      ),

      body: Obx(() {

        if (controller.isLoading.value) {

          return const Center(
            child: CircularProgressIndicator(),
          );

        }

        if (controller.activities.isEmpty) {

          return const Center(

            child: Text(

              "Belum ada aktivitas",

              style: TextStyle(
                fontSize: 16,
              ),

            ),

          );

        }

        return RefreshIndicator(

          onRefresh: controller.refreshData,

          child: ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: controller.activities.length,

            itemBuilder: (context, index) {

              final item =
                  controller.activities[index];

              return Card(

                margin:
                    const EdgeInsets.only(bottom: 15),

                elevation: 2,

                shape: RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(15),

                ),

                child: ListTile(

                  leading: CircleAvatar(

                    backgroundColor:
                        Colors.brown.shade100,

                    child: const Icon(

                      Icons.history,

                      color: Colors.brown,

                    ),

                  ),

                  title: Text(

                    item["activity"],

                    style: const TextStyle(

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                  subtitle: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const SizedBox(height: 5),

                      Text(
                        item["description"],
                      ),

                      const SizedBox(height: 5),

                      Text(

                        item["created_at"],

                        style: const TextStyle(

                          color: Colors.grey,

                          fontSize: 12,

                        ),

                      ),

                    ],

                  ),

                ),

              );

            },

          ),

        );

      }),

    );

  }

}