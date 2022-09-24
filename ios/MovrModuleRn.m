// MovrModuleRn.m
@import Flutter;
@import UIKit;
#import "MovrModuleRn.h"

static FlutterEngine *_flutterEngine = nil;

@implementation MovrModuleRn

RCT_EXPORT_MODULE()

+ (void)initWithFlutterEngine:(FlutterEngine * _Nonnull)flutterEngine {
    _flutterEngine = flutterEngine;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

// Remove this `init` function if you want to provide `flutterEngine` from host app's AppDelegate
- (instancetype)init {
    self = [super init];
    if (self) {
        // Init Flutter Engine
        self.flutterEngine = [[FlutterEngine alloc] initWithName:@"flutter_engine" project:nil];
        [self.flutterEngine runWithEntrypoint:nil];
        [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    }
    return self;
}

RCT_EXPORT_METHOD(startFlutterActivity:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        FlutterViewController *flutterViewController;
        if (self.flutterEngine == nil && _flutterEngine == nil) {
            // It is not recommended, but we can create a FlutterViewController with an implicit FlutterEngine
            // https://flutter.dev/docs/development/add-to-app/ios/add-flutter-screen?tab=engine-objective-c-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine
            flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
        } else {
            FlutterEngine *fe = self.flutterEngine == nil ? _flutterEngine : self.flutterEngine;
            // init FlutterViewController with engine provided by host app
            flutterViewController = [[FlutterViewController alloc] initWithEngine:fe nibName:nil bundle:nil];
        }
        FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                        methodChannelWithName:@"com.movr.test_movr_module/result"
                                        binaryMessenger:flutterViewController];
        [methodChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            if ([@"receiveResult" isEqualToString:call.method]) {
                
            } else {
                result(FlutterMethodNotImplemented);
            }
        }];
        NSDictionary *dict = @{
            @"apiKey" : @"10f3d7a14c6c5ca062a4d38deb79f7f3e1ad529b",
            @"userId" : @"gengis-user",
            @"primaryColor" : @"#3E66B9",
            @"fontFamily" : @"Montserrat",
            @"apiBaseUrl" : @"https://movr-assess-staging.herokuapp.com",
            @"startingPage" : @"movrModuleMenu",
        };
        NSError * err;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dict options:0 error:&err];
        NSString * convertedString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
        NSLog(@"%@",convertedString);
        // fix ui
        [flutterViewController setModalPresentationStyle:UIModalPresentationFullScreen];

        [methodChannel invokeMethod: @"getResult" arguments: convertedString];
        UIViewController *rootController = UIApplication.sharedApplication.delegate.window.rootViewController;
        [rootController presentViewController:flutterViewController animated:YES completion:nil];
        callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
    });
}
@end
