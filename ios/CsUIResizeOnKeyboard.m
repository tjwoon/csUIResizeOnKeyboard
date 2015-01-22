/***
Copyright 2015 Woon Tien Jing

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
***/

#import "CsUIResizeOnKeyboard.h"

#import <UIKit/UIKit.h>


@implementation CsUIResizeOnKeyboard


#pragma mark -
#pragma mark Public API: On/off UI pan prevention

- (void)preventPan: (CDVInvokedUrlCommand*)command
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(keyboardDidShow:)
                   name:UIKeyboardDidShowNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(keyboardDidHide:)
                   name:UIKeyboardDidHideNotification
                 object:nil];

    [self returnOk:command];
}

- (void)unpreventPan: (CDVInvokedUrlCommand*)command
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self resetViewSize];

    [self returnOk:command];
}


#pragma mark -
#pragma mark Pan prevention event handlers

- (void)keyboardDidShow: (NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *sizeInfo = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [sizeInfo CGRectValue].size.height;

    CGRect bounds = [[UIScreen mainScreen] bounds];
    bounds.size.height -= keyboardHeight;
    self.webView.frame = bounds;
}

- (void)keyboardDidHide: (NSNotification*)notification
{
    [self resetViewSize];
}


#pragma mark -
#pragma mark Helpers

- (void)returnOk: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:[command callbackId]];
}

- (void)resetViewSize
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.webView.frame = screenBounds;
}


@end // CsIOSKeyboardResize
