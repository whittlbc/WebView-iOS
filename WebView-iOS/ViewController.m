

#import "ViewController.h"

#define WEB_URL @"https://www.google.com"   // change this url to whatever you want

@interface ViewController ()
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIWebView *uiWebView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) NSString *version;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // First create a WKWebViewConfiguration object so we can add a controller
    // pointing back to this ViewController.
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]
                                             init];
    WKUserContentController *controller = [[WKUserContentController alloc]
                                           init];
    
    // add ios8 messaging listeners from your JS if you want.
    // [controller addScriptMessageHandler:self name:@"uniqueName"];
    
    configuration.userContentController = controller;
    
    NSURL *web_url = [NSURL URLWithString:WEB_URL];
    
    if (NSClassFromString(@"WKWebView")) {

        self.version = @"8";
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame
                                  configuration:configuration];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:web_url]];

        [self.view addSubview:_webView];
        
    }
    
    else {
        
        self.version = @"7";

        self.uiWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
        
        [self.uiWebView loadRequest:[NSURLRequest requestWithURL:web_url]];
        
        [self.view addSubview:self.uiWebView];
        
        self.uiWebView.delegate = self;

    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil];
        self.mainView = [subviewArray objectAtIndex:0];
        
        self.mainView.frame = self.view.frame;
        
        // add splash screen for 2 extra seconds, then remove it
        [self.view addSubview:self.mainView];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(removeSplash)
                                       userInfo:nil
                                        repeats:NO];
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// iOS 7 or below messaging from JS
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
    //where you'll override any nav requests in order to pass messages to ios7 or below
    
    return YES;
}


// iOS 8 messaging from JS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"uniqueName"]) {

        // do something with message object
    }
    
}


// hacky way to show splash screen and then remove it after a certain amount of time (in order to allow webview url to load)
-(void) removeSplash {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.view sendSubviewToBack:self.mainView];
        [self.mainView removeFromSuperview];
    });
}


@end
