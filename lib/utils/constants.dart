String authToken = "token";
String userPref = "user";
String base_url = "https://luxpay-prod.herokuapp.com/v1";
String bankCode = "codeBank";
String bankName = "nameBank";
String completeSignUp = "complete";
String phoneNumber = "Phone_number";
RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';
