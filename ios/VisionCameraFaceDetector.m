#import <Foundation/Foundation.h>
#import "VisionCameraFaceDetector.h"

#if defined __has_include && __has_include("VisionCameraFaceDetector-Swift.h")
#import "VisionCameraFaceDetector-Swift.h"
#else
#import <VisionCameraCodeScanner/VisionCameraFaceDetector-Swift.h>
#endif

@implementation VisionCameraFaceDetector

+ (void)load {
    // Registration for JS/iOS plugin name
    [FrameProcessorPluginRegistry addFrameProcessorPlugin:@"scanFaces"
                                          withInitializer:^FrameProcessorPlugin*(NSDictionary* options) {
        return [[VisionCameraFaceDetector alloc] init];
    }];
}

@end
