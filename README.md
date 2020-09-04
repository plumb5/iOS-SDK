# iOS-SDK
App Analytics SDK for iOS Applications




# **Plumb5 SDK for iOS Devices**

The document details steps required to integrate Plumb5 SDK into your application for iOS devices. For any questions or queries please email us at developer@plumb5.com


#### **Getting Started**

Before you can begin working with Plumb5SDK on iOS, you need to download the Plumb5 SDK for iOS and ensure that you have an APP key and Service URl.

Please login to Plumb5 and Download the SDK.


## **Step1 : Get the latest version of Xcode**

To build a project using Plumb5 SDK for iOS, you need Xcode 8 or above version


## **Step2: Obtain the APP Key and Service URL**

Register with [www.plumb5.com](http://www.plumb5.com/) to obtain your APP Key and Service URL. If you have been provided with an APP key and Service URL, you can use that instead. Please write to developer@plumb5.com for any help.


## **Step3: Provide your application details.**

Provide your application’s APNs Certificate, Passphrase and application Bundle Identifier/Package Name from your account (Service Gateway Configuration -> Push Settings).


## **Step 4: Integrate SDK into Project**


### **Follow below given points**



1. Download “Plumb5SDK.framework”
2. Unpack the source files.
3. Launch Xcode and either open an existing project, or create a new project. If you're new to iOS, create a Single View Application, and disable Use Storyboards and enable Use Automatic Reference Counting.
4. Drag and drop the “Plumb5SDK.framework” into your xcode project, When prompted, ensure Copy items into the destination group's folder is selected.
5. Now Select the project file.
6. Add Plumb5SDK.framework under Embedded Binaries.
7. Select your project from the Project Navigator, and choose your Deployment target
8. Open the Build Phases tab, and within Link Binary with Libraries, add the following frameworks: Plumb5SDK.framework
9. Select Target, go to general and add Plumb5SDK.framework into embedded binaries


## **Step 5: Your project shall have podfile, if you don’t have go to the following url to setup the pod project**

If you don't already have the CocoaPods tool, install it on macOS by running the following command from the terminal. For details, see the : [www.guides.cocoapods.org/using/getting-started.html](http://www.guides.cocoapods.org/using/getting-started.html)


#### **Execute the following command on the terminal in project directory**



1. cd &lt;Space> Project Directory and hit enter.
2. Pod &lt;Space> init
3. Now go to the project folder.
4. Find the pod file under the created project
5. Add the following lines into your podfile above of target ‘Your project Name’ do
    *   pod 'Alamofire', '~> 4.2.7'
    *   pod 'ReachabilitySwift'
    *   pod 'SugarRecord/CoreData'
    *   pod 'SugarRecord/CoreData+iCloud'
6. Save the pod file.

Open a terminal and go to the directory containing the pod file cd &lt; Project Path >

Execute the “Pod install” command. This will install the APIs specified in the podfile, along with any dependencies they may have  $ pod install


## **Step 6: Add the following lines in your info.plist file**
```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>

<string>Description</string>

<key>NSLocationAlwaysUsageDescription</key>

<string>App needs Location</string>

<key>NSLocationWhenInUseUsageDescription</key>

<string>App needs Location</string>

<key>NSAppTransportSecurity</key>

<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
It will prompt the user requesting permission to access current location.


## **Step 7: AppDelegate Configuration**


#### **Do the following steps in to your appdelegate file**


##### **1. Import those libraries top of your appdelegate file**


```smalltalk
1. import Plumb5SDK
2. import UserNotifications
3. import CoreLocation
```

##### **2. Add below code above your AppDelegate class (or above @UIApplicationMain )**
```smalltalk
@available(iOS 10.0, *)
```

##### **3. Declare location manager inside your AppDelegate class.**
```smalltalk
let locationManager = CLLocationManager()
```

##### **4. Write below code snippet in Application didFinishLaunchingWithOptions method and provide your app key above return true statement**

```smalltalk
let appKey = “ provide your app key ”
let serviceUrl = “(your service url)”
locationManager.delegate = self
locationManager.requestAlwaysAuthorization()
registerForPushNotifications()
P5SDKManager.initP5SDK(key: appKey, serviceUrl : serviceUrl ,completion:nil);
P5SDKManager.sharedInstance.delegate = self;
P5SDKManager.applicationLaunchedWithOption(launchOptions: launchOptions)
```

##### **5. Add the below methods in AppDelagate class.**
```smalltalk
func registerForPushNotifications() {

if #available(iOS 10, *) {
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
(granted, error) in
print("Permission granted: \(granted)")
guard granted else { return }
self.getNotificationSettings()
}

}else if #available(iOS 9, *) {

UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
UIApplication.shared.registerForRemoteNotifications()

}

}

func application(_ application: UIApplication,

didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
let tokenParts = deviceToken.map { data -> String in
return String(format: "%02.2hhx", data)

}

let token = tokenParts.joined()
print("Device Token: \(token)")
P5SDKManager.sharedInstance.p5DeviceToken = token;

//FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)

}

func application(_ application: UIApplication,

didFailToRegisterForRemoteNotificationsWithError error: Error) {
print("Failed to register: \(error)")

}

func application(

_ application: UIApplication,

didReceiveRemoteNotification userInfo: [AnyHashable : Any],
fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
print(userInfo);
P5SDKManager.handlePushNotification(userInfo: userInfo)

}

// func application(_ application: UIApplication, didReceive notification: UILocalNotification) {

// P5SDKManager.handleLocalNotification(notification: notification)

// }

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

P5SDKManager.handlePushNotification(userInfo: userInfo)

}

}

@available(iOS 10.0, *)

extension AppDelegate: CLLocationManagerDelegate, P5ActionsDelegate {
func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
P5SDKManager.handleGeofenceEvent(region: region, onEntry: "1")

}

func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

P5SDKManager.handleGeofenceEvent(region: region, onEntry: "2")

}

func handleActionWithType(type : Actions, userInfo : Dictionary){

}

}

extension UIApplication {

private static let runOnce: Void = {

UIViewController.swizzleViewWillAppear()

}()

override open var next: UIResponder? {

// Called before applicationDidFinishLaunching

UIApplication.runOnce

return super.next

}
```

##### **6. Add Extension in Appdelegate.swift**
```smalltalk
@available(iOS 10.0, *)

extension AppDelegate: CLLocationManagerDelegate, P5ActionsDelegate {

func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)

{

P5SDKManager.handleGeofenceEvent(region: region, onEntry: "1")

}

func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

P5SDKManager.handleGeofenceEvent(region: region, onEntry: "2")

}

func handleActionWithType(type : Actions, userInfo : Dictionary&lt;String, Any>){

// Here you can write your redirect screen function for In-App dialog,Banner and Push

Notification button action or any others functions you want with the userInfo response.

}

}
```

## **Step 8: Register Users**

It is required to pass the following user information to uniquely identify the user. The user information is tagged against the device id, enabling real time analytics and engagement.

```smalltalk
P5SDKManager.registerUser(name: "name", email: "userid@gmail.com", phoneNumber:"987654321", extraParam: "extra")
```

## **Step 9: Show In-App Banner**

To show In-App Banner get a uiview on your viewcontroller in Main.storyboard in which viewcontroller you want to show.

Banner view is an instance of UIView. You can manage its position wherever you want and show with whatever size you want.

Then call the below method with your parameter including your UIView in your viewcontroller class.

P5SDKManager.loadBanner(screenName : String, bannerView: UIView, delegate : P5BannerDelegate)

Then set or extend “ P5BannerDelegate ” to get the following callback methods.
```smalltalk
func bannerLoaded() // Called when banner is loaded

func bannerRemoved() //called when the banner is removed or close button is clicked. Please implement both.
```

## **Step 10: Get Event Data**

To get your event data call this below method with your parameter value inside your button action or event.
```smalltalk
P5SDKManager.trackEvents(name: "Show banner", type: P5SDKManager.BUTTON_CLICK,value: "100")
```

## **Step 11: Implement Push Notification**



1. Go to “Capabilities” option in your project setting then set ON to Push Notification and Background Modes and check Remote notifications inside Background Modes.
2. **Set up extension:**
3. The process of adding a notification service extension to an iOS app is identical to that of other extensions. In the Xcode menu bar, go to File > New > Target... and select the Notification Service Extension template from the menu that appears.Copy and paste content of NotificationService.swift from the sample app in your extensions NotificationService.swift file.
4. Set Allow Arbitrary Loads to Yes in Info.plist of your extension. It is based on your requirement.
```smalltalk
import UIKit

import UserNotifications

public enum MediaType: String {

case image = "image"
case gif = "gif"
case video = "video"
case audio = "audio"

}

fileprivate struct Media {

private var data: Data
private var ext: String
private var type: MediaType
init(forMediaType mediaType: MediaType, withData data: Data, fileExtension ext: String) {
self.type = mediaType
self.data = data
self.ext = ext

}

var attachmentOptions: [String: Any?] {

switch(self.type) {

case .image: return [UNNotificationAttachmentOptionsThumbnailClippingRectKey: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.50).dictionaryRepresentation]

case .gif:

return [UNNotificationAttachmentOptionsThumbnailTimeKey: 0]

case .video:

return [UNNotificationAttachmentOptionsThumbnailTimeKey: 0]

case .audio:

return [UNNotificationAttachmentOptionsThumbnailHiddenKey: 1]

}

}

var fileIdentifier: String {

return self.type.rawValue

}

var fileExt: String {

if self.ext.count > 0 {

return self.ext

} else {

switch(self.type) {

case .image:

return "jpg"

case .gif:

return "gif"

case .video:

return "mp4"

case .audio:

return "mp3"

}

}

}

var mediaData: Data? {

return self.data

}

}

//@available(iOSApplicationExtension 10.0, *)

fileprivate extension UNNotificationAttachment {

static func create(fromMedia media: Media) -> UNNotificationAttachment? {

let fileManager = FileManager.default
let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)

do {

try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
let fileIdentifier = "\(media.fileIdentifier).\(media.fileExt)"
let fileURL = tmpSubFolderURL.appendingPathComponent(fileIdentifier)
guard let data = media.mediaData else {

return nil

}

try data.write(to: fileURL)

return self.create(fileIdentifier: fileIdentifier, fileUrl: fileURL, options: media.attachmentOptions)

} catch {

print("error " + error.localizedDescription)

}

return nil

}

static func create(fileIdentifier: String, fileUrl: URL, options: [String : Any]? = nil) -> UNNotificationAttachment? {

var n: UNNotificationAttachment?

do {

n = try UNNotificationAttachment(identifier: fileIdentifier, url: fileUrl, options: options)

} catch {

print("error " + error.localizedDescription)

}

return n

}

}

private func resourceURL(forUrlString urlString: String) -> URL? {

return URL(string: urlString)

}

fileprivate func loadAttachment(forMediaType mediaType: MediaType, withUrlString urlString: String, completionHandler: (

(UNNotificationAttachment?) -> Void)) {

guard let url = resourceURL(forUrlString: urlString) else {
completionHandler(nil)
return

}

do {

let data = try Data(contentsOf: url)

let media = Media(forMediaType: mediaType, withData: data, fileExtension: url.pathExtension)
if let attachment = UNNotificationAttachment.create(fromMedia: media) {
completionHandler(attachment)
return

}

completionHandler(nil)

} catch {

print("error " + error.localizedDescription)

completionHandler(nil)

} } class NotificationService: UNNotificationServiceExtension {

var contentHandler: ((UNNotificationContent) -> Void)?
var bestAttemptContent: UNMutableNotificationContent?
override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void)

{ self.contentHandler = contentHandler

bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
if let bestAttemptContent = bestAttemptContent {

// Modify the notification content here...

bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
let userInfo = bestAttemptContent.userInfo

// check for a media attachment

guard

let url = userInfo["attachment-url"] as? String,
let _mediaType = userInfo["media-type"] as? String,
let mediaType = MediaType(rawValue:_mediaType)

else {

contentHandler(bestAttemptContent)

return

}

loadAttachment(forMediaType: mediaType, withUrlString: url, completionHandler: { attachment in

if let attachment = attachment {

bestAttemptContent.attachments = [attachment]

}

contentHandler(bestAttemptContent)

})

}

}

override func serviceExtensionTimeWillExpire() {

// Called just before the extension will be terminated by the system.

// Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.

if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {

contentHandler(bestAttemptContent)

}

}

}
```

## **Step 12: To get Device Details**
```smalltalk
P5SDKManager.getDeviceInfoAsJson()
```
