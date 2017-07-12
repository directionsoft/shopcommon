//
//  DSWebView.h
//  testApp
//
//  Created by Sanghong Han on 2016. 10. 23..
//  Copyright © 2016년 directionsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DSWebViewDelegate <NSObject>

@optional

- (void)webViewStart:(NSString *)aUrl;
- (void)webViewError:(NSString *)aUrl error:(NSError *)error;
- (void)webViewLoadCompleted:(NSString *)aUrl;
- (void)shouldStartLoadWithRequest:(NSURLRequest *)request;
- (void)doAppSchemeProcess:(NSURL *)aUrl;

@end

@interface DSWebView : UIWebView

@property (nonatomic, assign) id<DSWebViewDelegate> DSWebViewDelegate;

- (void)callJavaScript:(NSString *)aScript;
- (void)callRequest:(NSURLRequest *)request;
- (BOOL)canGoBack;
- (void)goBack;
- (BOOL)canGoForward;
- (void)goForward;

@end
