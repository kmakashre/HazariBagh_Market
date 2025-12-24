import 'package:flutter/material.dart';

class JobsServicesProvider extends ChangeNotifier {
  /// 🔘 TAB STATE
  bool isJobsSelected = true;

  /// 🎯 CATEGORY FILTER (KEY)
  String selectedCategoryKey = "all";

  /// 💼 JOBS DATA (USING KEYS)
  final List<Map<String, String>> jobsList = [
    {
      "titleKey": "flutterDeveloper",
      "companyKey": "techSolutions",
      "salary": "₹4-6 LPA",
      "typeKey": "fullTime",
      "categoryKey": "itSoftware",
    },
    {
      "titleKey": "salesExecutive",
      "companyKey": "abcPvtLtd",
      "salary": "₹2-4 LPA",
      "typeKey": "fullTime",
      "categoryKey": "salesMarketing",
    },
    {
      "titleKey": "hospitalNurse",
      "companyKey": "cityHospital",
      "salary": "₹3-5 LPA",
      "typeKey": "shift",
      "categoryKey": "healthcare",
    },
    {
      "titleKey": "teacher",
      "companyKey": "davSchool",
      "salary": "₹4-5 LPA",
      "typeKey": "fullTime",
      "categoryKey": "education",
    },
  ];

  /// 🛠 SERVICES DATA (USING KEYS)
  final List<Map<String, String>> servicesList = [
    {
      "titleKey": "electrician",
      "companyKey": "homeServices",
      "salary": "₹500/day",
      "typeKey": "onCall",
      "categoryKey": "logistics",
    },
    {
      "titleKey": "plumber",
      "companyKey": "quickFix",
      "salary": "₹700/day",
      "typeKey": "onCall",
      "categoryKey": "logistics",
    },
    {
      "titleKey": "computerRepair",
      "companyKey": "itCare",
      "salary": "₹1000/service",
      "typeKey": "service",
      "categoryKey": "itSoftware",
    },
  ];

  /// 🔁 TAB SWITCH
  void selectJobs() {
    isJobsSelected = true;
    selectedCategoryKey = "all";
    notifyListeners();
  }

  void selectServices() {
    isJobsSelected = false;
    selectedCategoryKey = "all";
    notifyListeners();
  }

  /// 🎯 CATEGORY SELECTION
  void selectCategory(String categoryKey) {
    selectedCategoryKey = categoryKey;
    notifyListeners();
  }

  /// 📋 FILTERED LIST
  List<Map<String, String>> get filteredList {
    final list = isJobsSelected ? jobsList : servicesList;

    if (selectedCategoryKey == "all") {
      return list;
    }

    return list
        .where((item) => item["categoryKey"] == selectedCategoryKey)
        .toList();
  }
}
