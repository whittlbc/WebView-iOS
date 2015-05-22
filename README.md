WebView-iOS
==============

This is an iOS template for hosting a webapp inside of a webview that works for any ios version. For ios8, it will use a WKWebView. For ios7 and below, it will automatically fall back to using a UIWebView. Communication systems for both are also already set up (for sending messages from JS to Obj-C).

Setup:

  - git clone https://github.com/whittlbc/WebView-iOS.git
  - open ViewController.m and change the WEB_URL constant at the top to whatever URL you're hosting your webapp at
  - GOOD TO GO
