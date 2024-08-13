import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/routes/app_route.dart';



class PayScreen extends StatefulWidget {
   const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  // late WebViewController _webViewController; // Declare WebViewController

  @override
  void initState() {
    super.initState();

    // _webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onHttpError: (HttpResponseError error) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  void loadWebView() async {
    // await _webViewController.loadRequest(Uri.parse("https://www.google.com/"));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: BlocProvider.of<CartCubit>(context).payUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            debugPrint('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          debugPrint('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page started Finished: $url');

          if(url.contains("success=true")){
            context.pushNamed(Routes.homeLayout);
            BlocProvider.of<CartCubit>(context).cartList.clear();
            BlocProvider.of<CartCubit>(context).totalPrice = 0;
          }
          },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      )
    );
  }
}
