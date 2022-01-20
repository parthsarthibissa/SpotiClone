//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

#if __has_include(<spotify_sdk/SpotifySdkPlugin.h>)
#import <spotify_sdk/SpotifySdkPlugin.h>
#else
@import spotify_sdk;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SpotifySdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"SpotifySdkPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
