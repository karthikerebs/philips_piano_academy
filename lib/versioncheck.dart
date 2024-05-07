// import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'package:pub_semver/pub_semver.dart';

// Future<void> checkAppVersionAndRedirect(BuildContext context) async {
//   final PackageInfo info = await PackageInfo.fromPlatform();
//   final String currentVersion = info.version;

//   // Define your minimum required version here
//   final String minimumRequiredVersion = "3.0.5";

//   if (Version.parse(currentVersion) < Version.parse(minimumRequiredVersion)) {
//     // Show a dialog or prompt the user before redirection (optional)
//     final shouldUpdate = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Update Available'),
//         content: Text(
//             'A new version of the app is available. Please update to continue.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: Text('Update Now'),
//           ),
//         ],
//       ),
//     );

//     if (shouldUpdate ?? false) {
//       // Redirect to the store
//       await StoreRedirect.redirect(
//           androidAppId: "com.philipspianoacademy.music", iOSAppId: "585027354");
//     }
//   }
// }
