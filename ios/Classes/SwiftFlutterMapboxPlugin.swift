import Flutter
import UIKit
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

public class SwiftFlutterMapboxPlugin: NavigationFactory, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_mapbox", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "flutter_mapbox/events", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMapboxPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    eventChannel.setStreamHandler(instance)
    
    let viewFactory = FlutterMapboxViewFactory(messenger: registrar.messenger())
    registrar.register(viewFactory, withId: "FlutterMapboxView")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let arguments = call.arguments as? NSDictionary
              
      if(call.method == "getPlatformVersion")
      {
          result("iOS " + UIDevice.current.systemVersion)
      }
      else if(call.method == "getDistanceRemaining")
      {
          result(_distanceRemaining)
      }
      else if(call.method == "getDurationRemaining")
      {
          result(_durationRemaining)
      }
      else if(call.method == "startNavigation")
      {
          startNavigation(arguments: arguments, result: result)
      }
      else if(call.method == "finishNavigation")
      {
          endNavigation(result: result)
      }
      else if(call.method == "enableOfflineRouting")
      {
          downloadOfflineRoute(arguments: arguments, flutterResult: result)
      }
      else
      {
          result("Method is Not Implemented");
      }
  }
}
