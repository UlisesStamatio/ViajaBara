import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/providers/client_provider.dart';

class StripePaymentService {
  Dio dio = Dio();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(BuildContext context, double amount, String skApiKey,
      BookTrip bookTrip) async {
    try {
      paymentIntent =
          await createPaymentIntent(amount.toString(), 'MXN', skApiKey);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  customFlow: false,
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Isheunesu',
                  googlePay:
                      const PaymentSheetGooglePay(merchantCountryCode: "MX"),
                  allowsDelayedPaymentMethods: true))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context, bookTrip);
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency, String skApiKey) async {
    try {
      SharedPreferences pref = await _prefs;
      if (pref.containsKey("paymentIntent")) {
        print("Ya realizo paymentIntent");
        return jsonDecode(pref.getString("paymentIntent")!);
      }
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency
      };
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $skApiKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: body,
      );
      pref.setString("paymentIntent", jsonEncode(response.data));
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context, BookTrip bookTrip) async {
    try {
      SharedPreferences pref = await _prefs;
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    SvgPicture.asset(
                      StuffApp.bgSucceess,
                      fit: BoxFit.cover,
                    ),
                    const AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_shield_fill,
                            color: Colors.green,
                            size: 100.0,
                          ),
                          SizedBox(height: 10.0),
                          Text("Pago exitoso!"),
                        ],
                      ),
                    ),
                  ]),
                ));
        paymentIntent = null;
        pref.remove("paymentIntent");
        ClientProvider().saveSeatingSales(bookTrip);
        Navigator.popUntil(context, ModalRoute.withName('/trip'));
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(fit: StackFit.expand, children: <Widget>[
            SvgPicture.asset(
              StuffApp.bgError,
              fit: BoxFit.cover,
            ),
            const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.xmark_shield_fill,
                        color: Colors.red,
                      ),
                      Text("Pago fallido"),
                    ],
                  ),
                ],
              ),
            ),
          ]));
    } catch (e) {
      print('$e');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount) * 100).toInt();
    return calculatedAmout.toString();
  }
}
