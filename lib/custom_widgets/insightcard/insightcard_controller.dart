import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_insightcard_list.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/models/model_user_insightcard.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:intl/intl.dart';

class InsightCardController extends GetxController {
  InsightCardController({
    required this.cardId,
    required this.cardInfo,
    this.refreshFunction,
  });

  final VoidCallback? refreshFunction;
  final String cardId;
  final ModelInsightCard cardInfo;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
