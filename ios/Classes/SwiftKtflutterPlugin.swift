import Flutter
import UIKit

public func nativeRouting(block:(_ r: SwiftKtflutterPlugin.Type) -> Void) {
    block(SwiftKtflutterPlugin.self)
}

public class SwiftKtflutterPlugin: NSObject, FlutterPlugin {
	private static let channelName = "com.rarnu.flutter/routing"
	private static var channelList = [String: (params: [String: Any?]) -> Any?]()

  	public static func register(with registrar: FlutterPluginRegistrar) {
		FlutterMethodChannel.init(name: channelName, binaryMessenger: registrar.messenger()).setMethodCallHandler { (call, result) in
            switch(call.method) {
            case "platform":
                result("iOS");
                break
            case "app_version_code":
                result(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)
                break
            case "app_version_name":
                result(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)
                break
            case "app_bundle":
                result(Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String)
                break
            case "device_version":
                result(UIDevice.current.systemVersion)
                break
            case "device_model":
                result(UIDevice.current.systemName)
                break
            case "device_id":
                result(UIDevice.current.identifierForVendor?.uuidString)
                break
            case "device_document_path":
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)[0]
                if (!FileManager.default.fileExists(atPath: path)) {
                    do {
                        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        
                    }
                }
                result(path)
                break
            case "device_file_path":
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)[0] + "/files"
                if (!FileManager.default.fileExists(atPath: path)) {
                    do {
                        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        
                    }
                }
                result(path)
                break
            case "device_cache_path":
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)[0]
                if (!FileManager.default.fileExists(atPath: path)) {
                    do {
                        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        
                    }
                }
                result(path)
                break
            default:
                let m = channelList[call.method]
                if (m != nil) {
                    result(m!(call.arguments as! [String: Any?]))
                } else {
                    result(nil)
                }
            }
        }
  	}

	public class func route(_ name: String, block: @escaping(_ params: [String: Any?]) -> Any?) {
        channelList[name] = block
    }
    
    public class func routeList(_ name: String, block: @escaping(_ params: [String: Any?]) -> [Any?]?) {
        channelList[name] = block
    }
    
    public class func routeMap(_ name: String, block: @escaping(_ params: [String: Any?]) -> [AnyHashable: Any?]?) {
        channelList[name] = block
    }
    public class func routeObj(_ name: String, block: @escaping(_ params: [String: Any?]) -> [String: Any?]?) {
        channelList[name] = block
    }
    public class func routeObjList(_ name: String, block:@escaping(_ params:[String: Any?]) -> [[String: Any?]]?) {
        channelList[name] = block
    }
    public class func routeObjMap(_ name: String, block:@escaping(_ params: [String: Any?]) -> [AnyHashable: [String: Any?]]?) {
        channelList[name] = block
    }
}
