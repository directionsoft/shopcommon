//
//  DSWebView.m
//  testApp
//
//  Created by Sanghong Han on 2016. 10. 23..
//  Copyright © 2016년 directionsoft. All rights reserved.
//

#import "DSWebView.h"

#import "CommonShop.h"
#import "NSString+Shop.h"
#import "AppInit.h"

@interface DSWebView()  <UIWebViewDelegate>
{

}
@end

@implementation DSWebView


#pragma mark - Public

- (void)callJavaScript:(NSString *)aScript
{
    [self stringByEvaluatingJavaScriptFromString:aScript];
}

- (void)callRequest:(NSURLRequest *)request
{
    [self loadRequest:request];
}

#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (self.DSWebViewDelegate && [self.DSWebViewDelegate respondsToSelector:@selector(webViewStart:)]) {
        [self.DSWebViewDelegate webViewStart:self.request.URL.absoluteString];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *scheme = request.URL.scheme;
    
    NSLog(@"scheme is %@", scheme);
    
    // 프레임워크 스킴
    if ([scheme isEqualToString:@"dsapp"]) {
        if ([request.URL.host isEqualToString:@"appinterface"]) {
            if ([self.DSWebViewDelegate respondsToSelector:@selector(doAppSchemeProcess:)]) {
                [self.DSWebViewDelegate doAppSchemeProcess:request.URL];
            }
        }
        return NO;
    }
    // 서비스로 이동 전화/메일/메시지
    else if ([scheme isEqualToString:@"tel"] ||
             [scheme isEqualToString:@"mailto"] ||
             [scheme isEqualToString:@"sms"] ) {
        [[UIApplication sharedApplication] openURL:request.URL];
        
        return NO;
    }
    // Store로 이동
    else if ([request.URL.absoluteString hasPrefix:@"https://itunes.apple.com"] ||
             [request.URL.absoluteString hasPrefix:@"https://itunes.com"] ||
             [scheme isEqualToString:@"itms"] ||
             [scheme isEqualToString:@"itms-apps"] ||
             [scheme isEqualToString:@"itms-appss"] ) {
        [[UIApplication sharedApplication] openURL:request.URL];
        
        return NO;
    }
    else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"] || [request.URL.absoluteString isEqualToString:@"about:blank"]) {
    
        if (self.DSWebViewDelegate && [self.DSWebViewDelegate respondsToSelector:@selector(shouldStartLoadWithRequest:)]) {
            NSLog(@"shouldStartLoadWithRequest is %@", request.URL.absoluteString);
            [self.DSWebViewDelegate shouldStartLoadWithRequest:request];
            
            return YES;
        }
    }
    else { // 결제관련
        if ([scheme isEqualToString:@"ispmobile"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id369125087?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //현대앱카드
        else if([scheme isEqualToString:@"hdcardappcardansimclick"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id702653088?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //삼성앱카드
        else if ([scheme isEqualToString:@"mpocket.online.ansimclick"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id535125356?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //신한앱카드
        else if([scheme isEqualToString:@"shinhan-sr-ansimclick"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id572462317?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //롯데앱카드
        else if([scheme isEqualToString:@"lotteappcard"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-appss://itunes.apple.com/app/id688047200?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //롯데모바일결제
        else if ([scheme isEqualToString:@"lottesmartpay"]) {
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/kr/app/id668497947?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        //국민앱카드
        else if([scheme isEqualToString:@"kb-acp"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id695436326?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        else if ([scheme isEqualToString:@"tswansimclick"]) {
            if ([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-appss://itunes.apple.com/kr/app/id430282710?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // 하나카드
        else if ([scheme isEqualToString:@"cloudpay"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id847268987?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // kpay
        else if ([scheme isEqualToString:@"kpay"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id911636268?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // payco
        else if ([scheme isEqualToString:@"payco"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id924292102?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // payco 앱 로그인
        else if ([scheme isEqualToString:@"paycoapplogin"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id924292102?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // kftc-bankpay
        else if ([scheme isEqualToString:@"kftc-bankpay"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id398456030?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // citispay
        else if ([scheme isEqualToString:@"citispay"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-appss://itunes.apple.com/kr/app/id373559493?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
        // 농협카드
        else if ([scheme isEqualToString:@"nhappcardansimclick"]){
            if([[UIApplication sharedApplication] canOpenURL:request.URL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
            else {
                NSURL *downloadUrl = [NSURL URLWithString:@"itms-appss://itunes.apple.com/kr/app/id698023004?mt=8"];
                [[UIApplication sharedApplication] openURL:downloadUrl];
            }
            return NO;
        }
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.DSWebViewDelegate && [self.DSWebViewDelegate respondsToSelector:@selector(webViewLoadCompleted:)]) {
        [self.DSWebViewDelegate webViewLoadCompleted:self.request.URL.absoluteString];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (self.DSWebViewDelegate && [self.DSWebViewDelegate respondsToSelector:@selector(webViewError:error:)]) {
        [self.DSWebViewDelegate webViewError:self.request.URL.absoluteString error:error];
    }
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - method

- (BOOL)canGoBack
{
    return [super canGoBack];
}

- (void)goBack
{
    [super goBack];
}

- (BOOL)canGoForward
{
    return [super canGoForward];
}

- (void)goForward
{
    [super goForward];
}

@end
