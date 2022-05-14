import '../../views/rechargeAndBills/airtime.dart';

class AirtimeVM{
  List<Plans> list = [new Plans("50", "Pay N 50"),
    new Plans("50", "Pay N 50"),
    new Plans("50", "Pay N 50"),
    new Plans("50", "Pay N 50"),
    new Plans("50", "Pay N 50"),
    new Plans("50", "Pay N 50")];

  List<Plans> getAllPlans(){
    return list;
  }
}