import 'package:get/get.dart';
import 'package:hicarcom/data/service.dart';
import 'package:hicarcom/model/getcompanyinfo.dart';


class CompanyInfoController extends GetxController {
  var isLoading = false.obs;
  var companyInfo = <InfoDatum>[].obs;
  var companyInfoSearch = <InfoDatum>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanyData();
  }

  Future<void> fetchCompanyData() async {
    try {
      isLoading(true);
      var products1 = await GetCompanyInfoService.fetchGetCompanyInfo();
      companyInfo.assignAll(products1);
      companyInfoSearch.assignAll(products1); // 초기 검색 리스트도 설정
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void searchCompanyInfo(String query) {
    if (query.isEmpty) {
      companyInfoSearch.assignAll(companyInfo); // 검색어가 없을 경우 전체 리스트를 다시 할당
    } else {
      final lowerCaseQuery = query.toLowerCase();
      companyInfoSearch.assignAll(
        companyInfo.where((item) {
          final itemString = '${item.companyName} ${item.companyType} ${item.branchName} ${item.userName} ${item.phoneNumber}'.toLowerCase();
          return itemString.contains(lowerCaseQuery);
        }).toList(),
      );
    }
  }
}