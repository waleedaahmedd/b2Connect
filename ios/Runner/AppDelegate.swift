import UIKit
import Flutter
import SLDPayByPayment
import GoogleMaps




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private var receivedToken: String = ""
    private var receivedAppID: String = ""
    private var receivedSignature: String = ""
    private var receivedPartnerID: String = ""
    private var receivedDeviceID: String = ""
    private var viewController: UIViewController?
    
    private var methodChannel: FlutterMethodChannel? = nil
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      


      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      self.viewController = controller // -> Only for opening the PayByPayment module
      
      let METHON_CHANNEL_NAME = "PayBy.Method.Channel"
      methodChannel = FlutterMethodChannel(name: METHON_CHANNEL_NAME,
                                           binaryMessenger: controller.binaryMessenger)
      
      
      
      methodChannel!.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
         
          switch call.method {
          case "getBatteryLevel":
              guard let args = call.arguments as? [String: String] else {return}
              let name = args["name"]!
              let surname = args["surname"]!

              result("\(name) \(surname) says battery level in %: \(self.receiveBatteryLevel())")
              
//              let testEnvironment : SDLPaymentEnvironment = SDLPaymentEnvironment.init(rawValue: 1)!
//              SDLPayByPaymentInterface.paymentEnvironment(testEnvironment)
//              SDLPayByPaymentInterface.initInApp("20201022000000221",
//                                                 partnerId: "200000050812")
//
//
//              SDLPayByPaymentInterface.payInApp(withViewContorller: controller, orderCallback: { [self] orderSuccessCallback, orderFailCallback in
//                  //get order token
//                  let token = "a9e6203b-dbcd-4e6d-9cc4-7c412c93bc21" //getTokenMock()
//                  let deviceID = "59ffc049-bfb5-4382-8dc8-8677b6effc0c"
//                  let signin = "Yz4FMyFCvC0lxjuYxEA48srX8qnOEdrcnq53tc//aveqjZ1Qtqh4BPzGx9nCJyc0Y668wDrEj3M4tRTJKS7kUUfHotsOTbFMEpHVt20UHRROP55qYHsGs3m4hjNcozr/wI2f7ClzUajJKD8NekOdtPyLukmYjZUJAMky9uEpPW5fuE1yK5qxa7M/Y7qGniwRhuRCgueXJGUa/bBJxpn0iYCEzAzBHls0yVru8sj6uLhyjNr8gWY1aw3rXS+Z+HfDh1AO87rIBrCPf+V2G30Vhzj8SkvZHp1CLmp9RKogK7p+OpvgZzU3CnJrSYqnEDQSqoH3gXNQcVm4ba2YySh2Ug=="
//                  if token != nil && token.count > 0 {
//                      orderSuccessCallback(token, deviceID,signin)
//                  } else {
//                      orderFailCallback()
//                  }
//              }, success: { [self] result in
//                  print(result)
//              }, fail: { err_ in
//                  print(err_)
//              })
              
          case "getDeviceId":
              let deviceId = self.getDeviceId()
              result(deviceId)
              
          case "startPay":
              guard let args = call.arguments as? [String:String] else {
                  print("------No arguemnts received-----")
                  return
              }
              self.receivedToken = args["mToken"] ?? ""
              self.receivedDeviceID = args["mIapDeviceId"] ?? ""
              self.receivedPartnerID = args["mPartnerId"] ?? ""
              self.receivedSignature = args["sign"] ?? ""
              self.receivedAppID = args["mAppId"] ?? ""
              self.startPay()
              
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }

    GMSServices.provideAPIKey("AIzaSyByJNTQihz4Nori7L3KFxk9ttI-a7NAPX8")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  
}
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if let components = NSURLComponents.init(string: url.absoluteString),
//            let queryItems = components.queryItems,
//            queryItems.count > 0 {
//            for info in queryItems {
//                if info.name == "result" {
//                    print(info.value)
//                    break;
//                }
//            }
//        }
        return true
    }
    
    private func receiveBatteryLevel() -> Int{
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    if device.batteryState == UIDevice.BatteryState.unknown{
        return -1

    }
    else {
        return Int(device.batteryLevel * 100)
        
    }
    }
    
    private func getDeviceId() -> String? {
        // -> return authentic device id
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    private func startPay() {
        //let testEnvironment : SDLPaymentEnvironment = .test
        let releaseEnvironment : SDLPaymentEnvironment = .release

        SDLPayByPaymentInterface.paymentEnvironment(releaseEnvironment)
        SDLPayByPaymentInterface.initInApp(self.receivedAppID,
                                           partnerId: self.receivedPartnerID)
        
        SDLPayByPaymentInterface.payInApp(withViewContorller: self.viewController ?? UIViewController(),
                                          orderCallback: { [self] orderSuccessCallback, orderFailCallback in
            
            let token = self.receivedToken
            let deviceID = self.receivedDeviceID
            let signin = self.receivedSignature
            
            if token != nil && token.count > 0 {
                orderSuccessCallback(token, deviceID,signin)
            } else {
                orderFailCallback()
            }
        }, success: { [weak self] result in
            guard let self = self,
            let channel = self.methodChannel else {return}
            channel.invokeMethod("onCallFinish", arguments: result)
        }, fail: { err_ in
            print(err_)
        })
    }
}

