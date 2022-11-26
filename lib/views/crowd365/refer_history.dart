import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';

import '../../models/crowd36model.dart';
import '../../utils/reused_widgets.dart';

class HistoryofReferral extends StatefulWidget {
  final List<History> direct = [];
  HistoryofReferral({Key? key, direct}) : super(key: key);

  @override
  State<HistoryofReferral> createState() => _HistoryofReferralState();
}

class _HistoryofReferralState extends State<HistoryofReferral> {
  List<History> refCount = [];

  @override
  void initState() {
    refCount = widget.direct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Refer History",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35,
          ),
          onTap: Navigator.of(context).pop,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: refCount.isNotEmpty
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                  separatorBuilder: (context, index) => buildDivider,
                  itemCount: refCount.length,
                  itemBuilder: (context, index) {
                    var ref = refCount[index];
                    return ListTile(
                      title: Text('${ref.username}'),
                    );
                  }))
          : Center(
              child: Text(
                "No history",
                style: TextStyle(
                  fontSize: 14,
                  color: HexColor("#CCCCCC"),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }
}
