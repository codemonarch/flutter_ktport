#import "KtflutterPlugin.h"
#import <ktflutter/ktflutter-Swift.h>

@implementation KtflutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKtflutterPlugin registerWithRegistrar:registrar];
}
@end
