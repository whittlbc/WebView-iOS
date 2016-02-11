WebView-iOS
==============

This is an iOS template for hosting a webapp inside of a webview that works for any iOS version. For iOS8 and above, it will use a WKWebView. For iOS7 and below, it will automatically fall back to using a UIWebView. Communication systems for both are also already set up (for sending messages from WebView to native ObjC code and vice versa).


Setup:

  - `git clone https://github.com/whittlbc/WebView-iOS.git`<br>
  - Open `ViewController.m` and change `WEB_URL` at the top to the URL of your webapp<br>
  - Good to go
