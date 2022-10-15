import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/views/finances/withdrawalPin.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import '../../models/about_wallet.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/payment/wallet.dart';

class WithdrawalConfirmation extends StatefulWidget {
  final String? accountName,
      bankName,
      beneficiaryAccountNumber,
      amount,
      save,
      reasons,
      bankCode;

  WithdrawalConfirmation(
      {Key? key,
      required this.accountName,
      required this.bankName,
      required this.amount,
      required this.beneficiaryAccountNumber,
      this.reasons,
      required this.bankCode,
      this.save})
      : super(key: key);
  @override
  State<WithdrawalConfirmation> createState() => _WithdrawalConfirmationState();
}

class _WithdrawalConfirmationState extends State<WithdrawalConfirmation> {
  String? accountName,
      bankName,
      beneficiaryAccountNumber,
      amount,
      reasons,
      bankCode;
  String? save;
  var errors;
  bool checkdata = false;
  DioCacheManager? _dioCacheManager;
  String? walletBalance;

  @override
  void initState() {
    super.initState();

    accountName = widget.accountName;
    bankName = widget.bankName;
    beneficiaryAccountNumber = widget.beneficiaryAccountNumber;
    amount = widget.amount;
    reasons = widget.reasons;
    bankCode = widget.bankCode;
    save = widget.save;

    // transferData(beneficiaryAccountNumber, amount, reasons, save, bankCode);
    getWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 700,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: 6,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: grey2,
                  ),
                  margin: const EdgeInsets.only(top: 10)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text("Confirmation",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      // Container(
                      //     child: IconButton(
                      //   icon: Icon(Icons.cancel),
                      //   onPressed: () => Navigator.pop(context),
                      // )),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.only(top: 40, left: 15, right: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.3,
                            ),
                            WalletLuxpay(
                              balance: walletBalance,
                            ),
                            //  SizedBox(height:5),
                            earningStatus("ACCOUNT NAME",
                                "${accountName ?? "Not found"}"),
                            earningStatus(
                                "BANK NAME", "${bankName ?? "Not found"}"),
                            earningStatus("BENEFICIARY ACCOUNT NUMBER ",
                                "${beneficiaryAccountNumber ?? "Not found"}"),
                            earningStatus("AMOUNT", "${amount?.replaceAllMapped(reg, mathFunc) ?? "Not found"}"),
                            earningStatus("REASON FOR WITHDRAWAL",
                                "${reasons ?? "Not found"}"),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 4.3,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => WithdrawalPin(
                                                      beneficiaryAccountNumber:
                                                          beneficiaryAccountNumber,
                                                      amount: amount,
                                                      reasons: reasons,
                                                      save: save,
                                                      bankCode: bankCode)));
                                        },
                                        child: luxButton(
                                            HexColor("#D70A0A"),
                                            Colors.white,
                                            "Pay",
                                            double.infinity,
                                            fontSize: 16,
                                            height: 50,
                                            radius: 8)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Container(
                                  //     child: Image.asset(
                                  //   "assets/fprint.png",
                                  //   height: 50,
                                  //   width: 50,
                                  //   fit: BoxFit.cover,
                                  // )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget earningStatus(status, value) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7),
          Text(value)
        ],
      ),
    );
  }

  Future<bool> getWallets() async {
    final storage = new FlutterSecureStorage();
    // aboutUser();
    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 7),
        forceRefresh: true,
        options: Options(headers: {
          'Authorization': 'Bearer ${await storage.read(key: authToken) ?? ""}'
        }));
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager!.interceptor);
    var response = await _dio.get(
      base_url + "/v1/wallets/details/",
      options: _cacheOptions,
    );
    debugPrint('${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await AboutWallet.fromJson(data);
        setState(() {
          checkdata = true;
          // walletInfo = walletData.data.wallet.balance;
          walletBalance = walletData.data.balance;
        });

        debugPrint("wallet balance $walletBalance}");

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Wallet");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
