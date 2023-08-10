import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:splitter/components/dialogs/dialogs.dart';
import 'package:splitter/services/dynamic_link_service.dart';
import 'package:splitter/utils/get_provider.dart';

class DynamicLinksProvider {
  final FirebaseDynamicLinks _dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  late final JoinGroupProvider _joinGroupProvider;

  DynamicLinksProvider(BuildContext context){
    _joinGroupProvider = getProvider<JoinGroupProvider>(context);
    retrieveDynamicLink(context);
  }

  Future<Uri> createDynamicLink(String id) async {
    return await _dynamicLinkService.createDynamicLink(id);
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    String? gid;
    try {
      final PendingDynamicLinkData? data = await _dynamicLinks.getInitialLink();
      final Uri? deepLink = data?.link;
      if (deepLink != null && deepLink.queryParameters.containsKey("id")) {
        gid = deepLink.queryParameters['id'];
        _joinGroupProvider.show(context, gid);
      }

      _dynamicLinks.onLink.listen((dynamicLinkData) async {
        if (dynamicLinkData.link.queryParameters.containsKey("id")) {
          gid = dynamicLinkData.link.queryParameters['id'];
          _joinGroupProvider.show(context, gid);
        }
      }).onError((error) {
        debugPrint(error);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}