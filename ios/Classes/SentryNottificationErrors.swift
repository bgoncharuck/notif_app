import Flutter
import UIKit
import UserNotifications


public class SentryNotificationErrors: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "notifError", binaryMessenger: registrar.messenger())
    let instance: SentryNotificationErrors = SentryNotificationErrors()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "sentryNotificationErrors" {
      self.requestNotificationPermissions { granted in
        if granted {
          self.sendNotification()
        }
        exit(0)
      }
    }
  }

  private func requestNotificationPermissions(completion: @escaping (Bool) -> Void) {
    let current = UNUserNotificationCenter.current()
    current.requestAuthorization(options: [.alert]) { granted, error in
      if let error = error {
        print("Error requesting notification permissions: \(error)")
        completion(false)
      } else {
        completion(granted)
      }
    }
  }

  private func sendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Tap to open the app!"
    content.sound = nil
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "SentryError", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
}
