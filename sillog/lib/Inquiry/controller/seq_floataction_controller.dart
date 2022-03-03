import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';

class FloatActionController extends GetxController {
  FloatActionController(this.index, this.sillogData);

  int index;
  bool _isLoading = false;
  Map<int, DetailModel> detailsSillogMap = {};
  List<SillogModel> sillogData = [];

  get isLoading => _isLoading;

  startLoading() {
    _isLoading = true;
    update();
  }

  // setSillog(DetailModel _sillog) {
  //   this.detailsSillogMap[index] = _sillog;
  //   _isLoading = false;
  // }

  getSillogList() async {
    if (detailsSillogMap.length == sillogData.length) return;
    for (var i = 0; i < sillogData.length; i++) {
      detailsSillogMap[i] = await DetailModel.getDetail(sillogData[i]);
    }
    _isLoading = false;
    update();
  }
}
