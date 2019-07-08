import UIKit
import Flutter
import ktflutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    nativeRouting {
        $0.route("hello") { params in
            return "hello \(params["name"] as! String)"
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
