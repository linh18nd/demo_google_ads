import 'dart:developer';

import 'package:demo_google_ads/persenstation/page/rewarded_ads/controller/rewarded_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardedAdView extends GetView<RewardedAdController> {
  const RewardedAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Task'),
      ),
      body: Obx(
        () => !controller.isRewardedAdReady.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.done,
                        color: task.isDone ? Colors.blue : Colors.black,
                      ),
                      onPressed: () {
                        if (task.isDone) {
                          showAboutDialog(context: context, children: [
                            const Text('Nhiệm vụ đã được hoàn thành'),
                          ]);
                          return;
                        }
                        log('run123');
                        if (!controller.isRewardedAdReady.value) {
                          showAboutDialog(context: context, children: [
                            const Text('Quảng cáo chưa được tải'),
                          ]);
                          return;
                        } else {
                          controller.rewardedAd?.show(
                            onUserEarnedReward: (ad, reward) {
                              debugPrint('$ad earned reward $reward.');
                              controller.updateTask(index);
                              controller.isRewardedAdReady.value = false;
                              controller.loadAd();
                            },
                          );
                        }
                      },
                    ),
                  );
                }),
      ),
    );
  }
}
