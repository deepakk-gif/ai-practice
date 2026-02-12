import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("HOME"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("https://hbjodhpur.com/liverate"),
        ),

        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          javaScriptCanOpenWindowsAutomatically: true,
  supportZoom: false,
    builtInZoomControls: false,
    displayZoomControls: false,
    enableViewportScale: false,
        ),
        initialUserScripts: UnmodifiableListView([
          UserScript(
            source: """
      const style = document.createElement('style');
      style.innerHTML = `
           html, body {
            touch-action: pan-x pan-y !important;
            overscroll-behavior: none !important;
          }
      /* Professional trading title */
        .spot-title h2 {
 
        }
          
        /* Hide header */
        #root > header {
          display: none !important;
        }
        /* Hide footer */
        #root > footer {
          display: none !important;
        }

        /* Change main-cover background */
        .main-cover {
          background: linear-gradient(90deg, #0f2027, #203a43, #2c5364) !important;
        }
      `;
      document.documentElement.appendChild(style);
    """,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
          ),
        ]),

        onWebViewCreated: (controller) {
          webViewController = controller;

          /// JS -> Flutter Communication
          controller.addJavaScriptHandler(
            handlerName: 'flutterHandler',
            callback: (args) {
              print("Message from Web: $args");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Web says: ${args.toString()}")),
              );

              return "Message received in Flutter";
            },
          );
        },

        onLoadStop: (controller, url) async {
          // Remove Header
          // await controller.evaluateJavascript(source: """
          // (function() {

          //   function removeHeader() {
          //     var root = document.getElementById('root');
          //     if (!root) return;

          //     var headers = root.getElementsByTagName('header');
          //     for (var i = headers.length - 1; i >= 0; i--) {
          //       headers[i].remove();
          //     }
          //   }

          //   // Run repeatedly because React may re-render
          //   setInterval(removeHeader, 500);

          // })();
          // """);

          /// 🔥 Inject CSS
          // await controller.evaluateJavascript(source: """
          //   var style = document.createElement('style');
          //   style.innerHTML = `
          //     body {
          //       background-color: #f5f5f5 !important;
          //     }
          //     h1 {
          //       color: red !important;
          //       font-size: 28px !important;
          //     }
          //   `;
          //   document.head.appendChild(style);
          // """);

          // /// 🔥 Hide Element
          // await controller.evaluateJavascript(source: """
          //   var element = document.querySelector('img');
          //   if (element) {
          //     element.style.display = 'none';
          //   }
          // """);

          // /// 🔥 Change Text
          // await controller.evaluateJavascript(source: """
          //   var heading = document.querySelector('h1');
          //   if (heading) {
          //     heading.innerText = "Modified by Flutter 🚀";
          //   }
          // """);

          // /// 🔥 Add New Button
          // await controller.evaluateJavascript(source: """
          //   var btn = document.createElement("button");
          //   btn.innerText = "Send Message to Flutter";
          //   btn.style.padding = "10px";
          //   btn.style.margin = "20px";
          //   btn.style.backgroundColor = "blue";
          //   btn.style.color = "white";

          //   btn.onclick = function() {
          //     window.flutter_inappwebview.callHandler('flutterHandler', 'Hello from Web');
          //   };

          //   document.body.appendChild(btn);
          // """);
        },
      ),
    );
  }
}
