import Flutter
import UIKit
import WebKit

final class HtmlToPdfPlugin: NSObject, WKNavigationDelegate {
  static let channelName = "vbpos/html_to_pdf"

  private var webView: WKWebView?
  private var pendingResult: FlutterResult?
  private var timeoutWork: DispatchWorkItem?
  private var didScheduleRender = false

  static func register(messenger: FlutterBinaryMessenger) -> HtmlToPdfPlugin {
    let plugin = HtmlToPdfPlugin()
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      plugin.handle(call, result: result)
    }
    return plugin
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "convertHtml" else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard let args = call.arguments as? [String: Any],
          let html = args["html"] as? String
    else {
      result(FlutterError(code: "invalid_args", message: "Missing html", details: nil))
      return
    }
    if pendingResult != nil {
      result(FlutterError(code: "busy", message: "Conversion already in progress", details: nil))
      return
    }
    convert(html: html, result: result)
  }

  private func convert(html: String, result: @escaping FlutterResult) {
    pendingResult = result
    didScheduleRender = false
    let pageRect = CGRect(x: 0, y: 0, width: 595.28, height: 841.89)
    let webView = WKWebView(frame: pageRect)
    webView.isHidden = true
    webView.navigationDelegate = self
    self.webView = webView

    if let host = rootView() {
      host.addSubview(webView)
    }

    let timeout = DispatchWorkItem { [weak self] in
      self?.finish(
        error: FlutterError(code: "timeout", message: "HTML to PDF timed out", details: nil)
      )
    }
    timeoutWork = timeout
    DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: timeout)

    webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    guard !didScheduleRender else {
      return
    }
    didScheduleRender = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
      self?.renderPdf(from: webView)
    }
  }

  func webView(
    _ webView: WKWebView,
    didFail navigation: WKNavigation!,
    withError error: Error
  ) {
    finish(
      error: FlutterError(code: "load_failed", message: error.localizedDescription, details: nil)
    )
  }

  func webView(
    _ webView: WKWebView,
    didFailProvisionalNavigation navigation: WKNavigation!,
    withError error: Error
  ) {
    finish(
      error: FlutterError(code: "load_failed", message: error.localizedDescription, details: nil)
    )
  }

  private func renderPdf(from webView: WKWebView) {
    guard pendingResult != nil else {
      return
    }

    let pageRect = CGRect(x: 0, y: 0, width: 595.28, height: 841.89)
    let renderer = UIPrintPageRenderer()
    renderer.addPrintFormatter(webView.viewPrintFormatter(), startingAtPageAt: 0)
    renderer.setValue(pageRect, forKey: "paperRect")
    renderer.setValue(pageRect, forKey: "printableRect")

    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
    for pageIndex in 0 ..< renderer.numberOfPages {
      UIGraphicsBeginPDFPage()
      renderer.drawPage(at: pageIndex, in: UIGraphicsGetPDFContextBounds())
    }
    UIGraphicsEndPDFContext()

    if pdfData.length == 0 {
      finish(
        error: FlutterError(code: "empty_pdf", message: "PDF renderer returned no data", details: nil)
      )
      return
    }
    finish(data: pdfData as Data)
  }

  private func finish(data: Data? = nil, error: FlutterError? = nil) {
    timeoutWork?.cancel()
    timeoutWork = nil
    webView?.navigationDelegate = nil
    webView?.removeFromSuperview()
    webView = nil

    let result = pendingResult
    pendingResult = nil
    if let error {
      result?(error)
    } else if let data {
      result?(FlutterStandardTypedData(bytes: data))
    }
  }

  private func rootView() -> UIView? {
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    for scene in scenes {
      let window = scene.windows.first(where: \.isKeyWindow) ?? scene.windows.first
      if let view = window?.rootViewController?.view {
        return view
      }
    }
    return UIApplication.shared.delegate?.window??.rootViewController?.view
  }
}
