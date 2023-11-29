import 'package:coinbase_wallet_sdk/account.dart';
import 'package:coinbase_wallet_sdk/coinbase_wallet_sdk.dart';
import 'package:coinbase_wallet_sdk/configuration.dart';
import 'package:coinbase_wallet_sdk/eth_web3_rpc.dart';
import 'package:web3modal_flutter/utils/w3m_logger.dart';
// import 'package:coinbase_wallet_sdk/request.dart';

import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'package:flutter/foundation.dart';

final coinbaseService = CoinbaseServiceSingleton();

class CoinbaseServiceSingleton {
  late ICoinbaseService instance;
}

abstract class ICoinbaseService {
  Future<void> init();
  Future<Account?> getAccount();
  Future<String> personalSign();
  Future<bool> resetSession();
}

class CoinbaseService implements ICoinbaseService {
  late final PairingMetadata _metadata;
  CoinbaseService({required PairingMetadata metadata}) : _metadata = metadata;

  @override
  Future<void> init() async {
    // Reset previous session
    // await CoinbaseWalletSDK.shared.resetSession();
    // Configure SDK for each platform
    final universal = _metadata.redirect?.universal ?? _metadata.url;
    final nativeLink = _metadata.redirect?.native ?? '';
    if (universal.isNotEmpty && nativeLink.isNotEmpty) {
      final config = Configuration(
        ios: IOSConfiguration(
          host: Uri.parse('cbwallet://wsegue'),
          callback: Uri.parse(nativeLink),
        ),
        android: AndroidConfiguration(
          domain: Uri.parse(universal),
        ),
      );
      await CoinbaseWalletSDK.shared.configure(config).catchError((e, s) {
        W3MLoggerUtil.logger.e('[$runtimeType] init(): $e, $s');
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  @override
  Future<Account?> getAccount() async {
    try {
      final results = await CoinbaseWalletSDK.shared.initiateHandshake([
        const RequestAccounts(),
      ]);
      return results[0].account;
    } catch (e, s) {
      W3MLoggerUtil.logger.e('[$runtimeType] getAccount(): $e, $s');
      return null;
    }
  }

  @override
  Future<String> personalSign() async {
    return '';
    // String message = 'Hello, world!';
    // String signed = '';
    // try {
    //   final request = Request(
    //     actions: [
    //       PersonalSign(
    //         address: addy,
    //         message: message,
    //       ),
    //     ],
    //   );
    //   final results = await CoinbaseWalletSDK.shared.makeRequest(request);
    //   signed = results[0].value ?? '<no signature>';
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }

    // return signed;
  }

  @override
  Future<bool> resetSession() async {
    try {
      await CoinbaseWalletSDK.shared.resetSession();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<bool> checkInstalled() async {
    return await CoinbaseWalletSDK.shared.isAppInstalled();
  }
}
