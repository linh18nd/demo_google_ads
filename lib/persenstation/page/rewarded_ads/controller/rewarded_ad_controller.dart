import 'dart:developer';

import 'package:demo_google_ads/common/constaint.dart';
import 'package:demo_google_ads/domain/model/todo.dart';
import 'package:demo_google_ads/persenstation/app_controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdController extends GetxController with AppController {
  RewardedAd? rewardedAd;

  RxInt numRewardedLoadAttempts = 0.obs;
  RxBool isRewardedAdReady = false.obs;
  RxBool isLoad = false.obs;
  RxList<Task> tasks = <Task>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
    loadAd();
  }

  void loadAd() {
    isRewardedAdReady.value = false;
    RewardedAd.load(
      adUnitId: Constaints.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
    isRewardedAdReady = true.obs;
  }

  void onAdLoaded(RewardedAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdImpression: (ad) {},
      onAdFailedToShowFullScreenContent: onAdFailedToShowFullScreenContent,
      onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
    );
    rewardedAd = ad;
    isRewardedAdReady = true.obs;
    debugPrint('$ad loaded.');
  }

  void onAdFailedToLoad(LoadAdError error) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error.message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  void onAdFailedToShowFullScreenContent(RewardedAd ad, AdError err) {
    ad.dispose();
  }

  void onAdDismissedFullScreenContent(RewardedAd ad) {
    ad.dispose();
  }

  void loadData() {
    tasks.addAll(
      [
        Task(title: 'Task 1', description: 'Description 1'),
        Task(title: 'Task 2', description: 'Description 2'),
        Task(title: 'Task 3', description: 'Description 3'),
        Task(title: 'Task 4', description: 'Description 4', isDone: true),
        Task(title: 'Task 5', description: 'Description 5'),
        Task(title: 'Task 6', description: 'Description 6'),
        Task(title: 'Task 7', description: 'Description 7'),
        Task(title: 'Task 8', description: 'Description 8'),
        Task(title: 'Task 9', description: 'Description 9'),
        Task(title: 'Task 10', description: 'Description 10'),
        Task(title: 'Task 11', description: 'Description 11'),
        Task(title: 'Task 12', description: 'Description 12'),
        Task(title: 'Task 13', description: 'Description 13'),
        Task(title: 'Task 14', description: 'Description 14'),
        Task(title: 'Task 15', description: 'Description 15'),
        Task(title: 'Task 16', description: 'Description 16'),
        Task(title: 'Task 17', description: 'Description 17'),
        Task(title: 'Task 18', description: 'Description 18'),
        Task(title: 'Task 19', description: 'Description 19'),
        Task(title: 'Task 20', description: 'Description 20'),
        Task(title: 'Task 21', description: 'Description 21'),
        Task(title: 'Task 22', description: 'Description 22'),
        Task(title: 'Task 23', description: 'Description 23'),
        Task(title: 'Task 24', description: 'Description 24'),
        Task(title: 'Task 25', description: 'Description 25'),
        Task(title: 'Task 26', description: 'Description 26'),
        Task(title: 'Task 27', description: 'Description 27'),
        Task(title: 'Task 28', description: 'Description 28'),
        Task(title: 'Task 29', description: 'Description 29'),
        Task(title: 'Task 30', description: 'Description 30'),
        Task(title: 'Task 31', description: 'Description 31'),
        Task(title: 'Task 32', description: 'Description 32')
      ],
    );
    log("data loaded");
  }

  void updateTask(int index) {
    tasks[index] = tasks[index].copyWith(isDone: true);
  }
}
