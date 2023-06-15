import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService{

  final _dynamicLinks = FirebaseDynamicLinks.instance;

  Future<Uri> createDynamicLink(String id) async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: 'https://splittrflutter.page.link',
        link: Uri.parse('https://splittrflutter.page.link.com/?id=$id'),
        androidParameters: const AndroidParameters(
          packageName: 'com.example.splitter',
          minimumVersion: 1,
        ),
        iosParameters: const IOSParameters(bundleId: 'com.example.splitter'));
    final dynamicLink =
    await _dynamicLinks.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl;
  }

  // Future<void> retrieveDynamicLink(BuildContext context) async {
  //   String? gid;
  //   Group? group;
  //   try {
  //     final PendingDynamicLinkData? data =
  //         await _dynamicLinks.getInitialLink();
  //     final Uri? deepLink = data?.link;
  //
  //     if (deepLink != null && deepLink.queryParameters.containsKey("id")) {
  //         gid = deepLink.queryParameters['id'];
  //         group = await getGroup(gid!);
  //         await wantToJoin(context, person, group!);
  //     }
  //
  //     _dynamicLinks.onLink.listen((dynamicLinkData) async {
  //       if (dynamicLinkData.link.queryParameters.containsKey("id")) {
  //         gid = dynamicLinkData.link.queryParameters['id'];
  //         group = await getGroup(gid!);
  //         if (group == null) {
  //           return;
  //         }
  //         await wantToJoin(context, person, group!);
  //       } else {
  //         return;
  //       }
  //     }).onError((error) {
  //       debugPrint(error)
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}