// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>

@import MLKitVision;

@interface FLTGoogleMlVisionPlugin : NSObject <FlutterPlugin>
+ (void)handleError:(NSError *)error result:(FlutterResult)result;
@end

@protocol Detector
@required
- (instancetype)initWithOptions:(NSDictionary *)options;
- (void)handleDetection:(MLKVisionImage *)image result:(FlutterResult)result;
@optional
@end



@interface TextRecognizer : NSObject <Detector>
@end
