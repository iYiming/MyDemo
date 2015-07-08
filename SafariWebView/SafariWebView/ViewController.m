//
//  ViewController.m
//  SafariWebView
//
//  Created by Yiming on 15/7/6.
//  Copyright (c) 2015年 Yiming. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIImageView * imgvcChild1;
@property (nonatomic, strong) UIImageView * imgvcChild2;
@property (weak, nonatomic) IBOutlet UIWebView *webView1;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;

@property (strong,nonatomic) NSMutableArray *URLsArray;
@property (assign,nonatomic) BOOL loadOldPage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _webView1.hidden = YES;
    
    [_webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lanjingyisheng.com/Apiv2/Bing/sharebcase/?pid=98&uid=237&bidlist=2106%2C4466%2C4685%2C2107%2C2105%2C2153%2C4375%2C16468%2C2910&t=559a0d2becfd2&shares=ed3d2c21991e3bef5e069713af9fa6ca"]]];
    
    _URLsArray = [[NSMutableArray alloc] init];
    
    UIScreenEdgePanGestureRecognizer *panLeft =[[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeLeftPanDetected:)];
    panLeft.edges = UIRectEdgeLeft;
    [_webView2 addGestureRecognizer:panLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) edgeLeftPanDetected:(UIScreenEdgePanGestureRecognizer*)gesture {
    CGFloat startX = 0;
    if (gesture.state == UIGestureRecognizerStateBegan) {
       startX = [gesture locationInView:_imgvcChild1.superview ].x;
        
        
        if ( _imgvcChild1 ) [ _imgvcChild1 removeFromSuperview ];
        
        if ([self.webView2 canGoBack]) {
            [self.webView2 goBack];
            
            UIGraphicsBeginImageContextWithOptions(_webView2.bounds.size, NO, 0);
            [_webView2.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *grab = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            _imgvcChild1 = [[ UIImageView alloc ] initWithImage:grab ];
            _imgvcChild1.frame = self.webView2.frame;
            _imgvcChild1.userInteractionEnabled = YES;
            [ self.view addSubview:_imgvcChild1 ];
        }
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        _imgvcChild1.frame = CGRectMake([gesture locationInView:_imgvcChild1.superview ].x, _imgvcChild1.frame.origin.y, _imgvcChild1.frame.size.width, _imgvcChild1.frame.size.height);
        
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        CGFloat endX = [gesture locationInView:_imgvcChild1.superview].x;
        
        CGFloat radio = (endX - startX)/[UIScreen mainScreen].bounds.size.width;
        
        if (radio > 0.3) {
            [UIView animateWithDuration:0.3 animations:^{
                _imgvcChild1.frame = CGRectMake(_imgvcChild1.frame.size.width, _imgvcChild1.frame.origin.y, _imgvcChild1.frame.size.width, _imgvcChild1.frame.size.height);
            } completion:^(BOOL finished) {
                [_imgvcChild1 removeFromSuperview];
            }];
        }else{
            [self.webView2 goForward];
            [UIView animateWithDuration:0.3 animations:^{
                _imgvcChild1.frame = CGRectMake(0, _imgvcChild1.frame.origin.y, _imgvcChild1.frame.size.width, _imgvcChild1.frame.size.height);
            } completion:^(BOOL finished) {
                [_imgvcChild1 removeFromSuperview];
            }];
            
        }
        
        
    }}

/*
 - (void) edgeLeftPanDetected:(UIScreenEdgePanGestureRecognizer*)gesture {
 if (_URLsArray.count <= 1) {
 return;
 }
 
 if (gesture.state == UIGestureRecognizerStateBegan) {
 NSURL *forwardURL = _URLsArray[_URLsArray.count - 2];
 
 NSInteger webView1Index = [self.view.subviews indexOfObject:_webView1];
 NSInteger webView2Index = [self.view.subviews indexOfObject:_webView2];
 
 UIWebView *webView = nil;
 if (webView1Index > webView2Index) {//_webView1 在前
 webView = _webView2;
 }else{//_webView2 在前
 webView = _webView1;
 }
 
 _loadOldPage = true;
 [webView loadRequest:[NSURLRequest requestWithURL:forwardURL]];
 }else if (gesture.state == UIGestureRecognizerStateChanged) {
 NSInteger webView1Index = [self.view.subviews indexOfObject:_webView1];
 NSInteger webView2Index = [self.view.subviews indexOfObject:_webView2];
 
 UIWebView *webView = nil;
 if (webView1Index > webView2Index) {//_webView1 在前
 webView = _webView1;
 }else{//_webView2 在前
 webView = _webView2;
 }
 
 webView.frame = CGRectMake([ gesture locationInView:webView.superview ].x, webView.frame.origin.y, webView.frame.size.width, webView.frame.size.height);
 }else if(gesture.state == UIGestureRecognizerStateEnded){
 NSInteger webView1Index = [self.view.subviews indexOfObject:_webView1];
 NSInteger webView2Index = [self.view.subviews indexOfObject:_webView2];
 
 UIWebView *webView = nil;
 if (webView1Index > webView2Index) {//_webView1 在前
 webView = _webView1;
 }else{//_webView2 在前
 webView = _webView2;
 }
 
 webView.frame = CGRectMake(0, 0, webView.frame.size.width, webView.frame.size.height);
 
 [self.view sendSubviewToBack:webView];
 
 [_URLsArray removeLastObject];
 }
 }
 */

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (!webView.loading) {
        if (_loadOldPage) {
            _loadOldPage = false;
        }else{
            [_URLsArray addObject:webView.request.URL];
            NSLog(@"URL:%@",webView.request.URL);
        }
    }
}

@end
