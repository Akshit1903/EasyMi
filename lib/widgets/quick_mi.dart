import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import '../provider/products.dart';

class QuickMi extends StatefulWidget {
  BuildContext ctxPrev;
  QuickMi(this.ctxPrev);
  @override
  State<QuickMi> createState() => _QuickMiState();
}

Widget StatusBox(String text, MaterialColor color, Size size) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(horizontal: 10),
    width: size.width,
    child: Text(
      text,
      textAlign: TextAlign.center,
    ),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
  );
}

class _QuickMiState extends State<QuickMi> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    _tagRead();
  }

  @override
  void dispose() {
    super.dispose();
    result.dispose();
  }

  Future<void> _tagRead() async {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<bool>(
      future: NfcManager.instance.isAvailable(),
      builder: (context, ss) => ss.data != true
          ? InkWell(
              onTap: () async {
                await AppSettings.openNFCSettings();
                setState(() {});
              },
              child: StatusBox(
                "Turn on NFC to use QuickMi Features",
                Colors.grey,
                size,
              ),
            )
          : ValueListenableBuilder(
              valueListenable: result,
              builder: (context, val, child) {
                return (val == null)
                    ? GestureDetector(
                        onTap: () async {
                          await _tagRead();
                        },
                        child: StatusBox(
                          "QuickMi is turned on, touch sensor!",
                          Colors.yellow,
                          size,
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          bool isProduct =
                              result.value["nfca"]["identifier"][0] == 4;
                          print(result.value["nfca"]["identifier"]);

                          result.value = null;

                          await Navigator.of(context).pushNamed(
                              ProductDetailScreen.routeName,
                              arguments:
                                  productsData.items[isProduct ? 0 : 5].id);
                          await _tagRead();
                        },
                        child: StatusBox(
                          "A product is detected, touch to open!",
                          Colors.green,
                          size,
                        ),
                      );
              }),
    );
  }
}
