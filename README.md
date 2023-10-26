

## BlueConic SDK for iOS
The BlueConic SDK for iOS makes it easy for developers to collect profile data from their apps. This section explains how to integrate BlueConic into your iOS apps.

You can use the iOS SDK to do the following:

- Set and retrieve profile property values.
- Gather statistics from mobile devices for users of the app.
- Register clicks, views and conversions.
- Use interactions from BlueConic.
- Use connections from BlueConic
- BlueConicClient Framework

### BlueConicClient Framework

The BlueConicClient Framework provides the basis for communication with BlueConic. It provides possibilities to develop your own interactions by creating mobile plugins. Developers can create their own mobile plugins and implement them in their iOS app. If you want your app to communicate with BlueConic, you have to use the BlueConicClient Framework. Besides creating your own plugins, BlueConicClient Framework allows you to make use of the standard BlueConic plugins. It contains several plugins that are mobile variants of the standard BlueConic plugins, such as Listeners and Interactions. Which allows BlueConic to pick up general visitor information, behaviour and interests and interact with it by showing useful interactions within your app.

- [Installation](#installation)
- [Before You begin](#before-you-begin)
- [Getting Started](#getting-started)
- [Using the BlueConic SDK](#using-the-blueconic-sdk)
- [Configuring BlueConic](#configuring-blueconic)
- [BlueConicClient Methods](#blueconicclient-methods)
- [InteractionContext Methods](#interactioncontext-methods)
- [BlueConicPlugin Methods](#blueconicplugin-methods)
- [Connection Methods](#connection-methods)
- [License](#license)

## Installation

BlueConicClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod "BlueConicClient"
```

## Before you begin

Before you start implementing the SDK, make sure you have the following:

- The latest version of Xcode (v14.3.1 or higher).
- The BlueConic SDK for iOS
- An iOS app that you can use to implement the BlueConicClient SDK for iOS.

The binary distribution files of the SDK have been built for iOS 12.0. If your mobile app supports a lower iOS version, please embed the Source distribution in your source code.

To test your mobile app you will want to have access to a BlueConic environment. There are two options:

- Are you working on behalf of a BlueConic Customer that has a BlueConic environment set up? Then ask a representative of the BlueConic Customer to request a Sandbox environment in which you can test your mobile app.
- Alternatively, request a free Pyxis environment yourself, and test your mobile app with that.

## Getting Started

Before you start implementing the SDK, use the following steps to set up your environment:

**Add the BlueConicClient framework to your app:** There are three ways to do this:
- **Install with CocoaPods** Add pod `BlueConicClient` to your Podfile.
- **Add the BlueConicClient framework** In Xcode add the BlueConicClient.framework for iOS by dragging the BlueConicClient.framework folder into the "Embedded Binaries" section on the General tab.
- **Add the BlueConicClient as Source (Support for iOS 7)** In Xcode add the BlueConicClient source into your Project

**Add the configuration key for BlueConic:** Locate your app's Information Property List file under "Supporting Files". Select project-Info.plist and add a new row by right clicking the top row and selecting "Add row". Set the following key name:
```bash
bc_server_url
```
Double-click the value field and enter the URL for the hostname of your BlueConic server. For example:
```bash
http://example.blueconic.net
```

**Add an URL Scheme key for BlueConic simulator:** Locate your app's Information Property List file under "Supporting Files". Select project-Info.plist and add a new row by right clicking the top row and selecting "Add row". Set the following key name:
```bash
URL types
```

This creates an array which contains more property rows. Open "URL types" by clicking the triangle icon in front of the name to display the rows. Right click "Item 0" and select "Add row". You can also add a new item, and add the new row within that item. Set the following key name:
```bash
URL Schemes
```

This creates another array. Add a new row to this array's "Item 0" and enter your apps "Bundle Identifier", for example:
```bash
com.blueconic.testApp
```

**Optionally, add a debug key for BlueConic:**
Locate your app's Information Property List file under "Supporting Files".
Select project-Info.plist and add a new row by right clicking the top row and selecting "Add row". Set the following key name:
```bash
bc_debug
```
Click the type and select 'Boolean'. Set the value to "YES" if you want to receive debug logs from the BlueConic SDK. Adding a debug key is optional; if you do not want to receive debug logs from the SDK, you do not need to add it.

**Import BlueConic:**
The BlueConic SDK for iOS enables you to set and retrieve profile property values for a BlueConic profile and enables interactions specific to this BlueConic profile. These methods can be used anywhere in the app. Make sure that you import the framework and get the instance before using the BlueConicClient methods:
```Swift
import BlueConicClient

let client = BlueConic.getInstance(self)
```

```Objective-C
#import <BlueConicClient/BlueConic-swift.h>

BlueConic *client = [BlueConic getInstance:self];
```
Make sure that you provide the current ViewController as argument when invoking getInstance. If no ViewController is available, pass an empty ViewController.

After you have added the URL Scheme value, select the AppDelegate class and add the following method to enable simulator functionality:
```Swift
// in the AppDelegate.swift file
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    BlueConic.getInstance(nil).setURL(url)
    return true
}
```

```Objective-C
// in the AppDelegate.m file
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[BlueConic getInstance:nil] setURL:url];
    return YES;
}
```

## Using the BlueConic SDK

**Retrieve an instance of BlueConic in the `viewDidAppear(animated: Bool)` of every ViewController and create a PAGEVIEW event:**
On the instance call `createEvent` with a properties map that holds the screenName. The screen name is shown in the Journey Simulator and it can be used in listener rules or to restrict interactions to specific screens. Make sure that you provide the current ViewController as argument when invoking "getInstance" on the BlueConicClient. If no ViewController is available, pass an empty ViewController.

```Swift
// in the ExampleViewController.swift file
import UIKit
import BlueConicClient

class ExampleViewController: UIViewController {
  private var _blueConic: BlueConic?

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    // Get the BlueConic instance.
    self._blueConic = BlueConic.getInstance(self)

    // Set screen name to identify the ViewController
    self._blueConic?.createEvent("PAGEVIEW", properties: ["screenName": "Main/ExampleViewController"])
  }
}
```
```Objective-C
in the ExampleViewController.h file
#import <UIKit/UIKit.h>
#import <BlueConicClient/BlueConic-Swift.h>

@interface ExampleViewController : UIViewController
@end

// Objective-C: in the ExampleViewController.m file
#import "ExampleViewController.h"

@interface ExampleViewController ()

@property BlueConic* client;

@end

@implementation ExampleViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  // Get the BlueConic instance
  self.client = [BlueConic getInstance:self];

  // Set screen name to identify the ViewController
  [self.client createEvent:@"PAGEVIEW" properties:@{@"screenName": @"MAIN/ExampleViewController"}];
}

@end

```

**Retrieving and storing profile properties:**
The BlueConic SDK for iOS enables you to set and retrieve profile property values for a BlueConic profile. These methods can be used anywhere in the app. The following example counts the number of times a specific activity is opened and stores this number in the BlueConic profile:
```Swift
// Get the BlueConic instance.
self._blueConic = BlueConic.getInstance(self)

// Get the current value from the profile, this value is returned as a String.
let profileValue: String? = self._blueConic?.getProfileValue(self.PROPERTY_ID)

var newValue = 1
if (profileValue != nil && Int(profileValue!) != nil) {
  newValue = Int(profileValue!)! + 1
}

// Set the new value in the profile
self._blueConic?.setProfileValue(self.PROPERTY_ID, value:String(newValue))
```

```Objective-C
// Get the BlueConic instance
self.client = [BlueConic getInstance:self];

// Get the current value from the profile, this value is returned as a String.
NSString* profileValue = [self.client getProfileValue:PROPERTY_ID];

int newValue = [profileValue intValue] + 1;

// Set the new value in the profile
[self.client setProfileValue:PROPERTY_ID value:[NSString stringWithFormat:@"%d", newValue]];
```

**Register events:**
Calls to register an event can be done in the onLoad of a Plugin. The code fragment shows how to trigger a click event. Possible events are: "CLICK", "VIEW" and "CONVERSION"
```Swift
self._client?.createEvent("CLICK", properties: ["interactionId": self._context?.getInteractionId()])
```

```Objective-C
[self.client createEvent:@"CLICK" properties:@{@"interactionId": [self.context getInteractionId]}];
```


## Configuring BlueConic
This section describes how to add the channel for your mobile application to your BlueConic universe as well as how to define your custom profile properties so that you can use them in BlueConic segments.

### Add the mobile channel to your universe
Before you can start measuring activity in your mobile applications and maintain values in visitor profile properties, the channel for your mobile application must be added to a domain in your BlueConic universe. The very first time that you start your application, BlueConic will detect it. It must then be added as a channel of the type "Mobile App" in a domain. See Managing channels for complete information.

### Custom profile properties
If you want your mobile application to be able to add custom properties to visitor profiles and use them in BlueConic segments, those custom profile properties must be added to your plugin. For complete information on writing a custom plugin, see Plugin Types. For information about adding custom profile properties

### Create a position for the Universe
Connect your UIView element to your ViewController, so your ViewController has a connection/ property of your UI element.
This can be done in a storyboard. Open your storyboard and click on the 'Assistant Editor'-button in the top-toolbar of Xcode, this allows you to have a splitscreen. On the left side you will see the actual storyboard and on the right-side the ViewController bound to the selected view. Hold the 'Control'-key and drag one of the View-elements inside your storyboard to the ViewController. After releasing the mouse button it should show a configuration pop-up, the Connection should be an 'Outlet' and the Name needs to be set (note that the name should equal your position id). Press the connect button, it should look like:
```Swift
@IBOutlet weak var viewName: UIView!
```
```Objective-C
@property (strong, nonatomic) IBOutlet UIView* viewName;
```

The position id of this element is 'viewName' and can be used in the Universe as '#viewName'. The BlueConic SDK currently only supports selecting elements using their ids.

## BlueConic Methods

Implementation of the BlueConic client, handling the profile retrieval and storage. This may be from cache, persistent storage on the client or direct requests to the BlueConic server.

```Swift
import BlueConicClient
```
```Objective-C
#import <BlueConicClient/BlueConic-Swift.h>
```

### getInstance(context: UIViewController?) -> BlueConic
Get an instance of the BlueConic client.

```Swift
let client: BlueConic = BlueConic.getInstance(self)
```
```Objecitive-C
BlueConic *client = [BlueConic getInstance:self];
```

### getProfileValue(property: String) -> String
Returns the first value for a given profile property.

```Swift
let hobby: String = client.getProfileValue("hobby")
```
```Objecitive-C
NSString *hobby = [client getProfileValue:@"hobby"];
```

### getProfileValues(property: String) -> [String]?
Return the values for a given profile property.

```Swift
let hobbies: [String] = client.getProfileValues("hobbies")
```
```Objecitive-C
NSArray *hobbies = [client getProfileValues:@"hobbies"];
```

### getViewController() -> UIViewController?
Returns the current ViewController.

```Swift
let viewController = client.getViewController()
```
```Objecitive-C
UIViewController *viewController = [client getViewController];
```

### getView(selector: String) -> UIView?
Returns a view component based on the given identifier or `nil` is no match is found.

```Swift
@IBOutlet weak var view: UIView!
let view: UIView? = client.getView("#view")
```
```Objecitive-C
@property (weak, nonatomic) IBOutlet UIView* view;
UIView *view = [client getView:@"#view"];
```

### getScreenName() -> String
Returns the screenName either set in createEvent or the ViewControllers title.

```Swift
client.createEvent("PAGEVIEW", properties: ["screenName": "Main/HOMETAB"])
var screenName: String = client.getScreenName()
```
```Objecitive-C
[client createEvent:@"PAGEVIEW" properties:@{@"screenName": @"MAIN/HOMETAB"}];
NSString *screenName = [client getScreenName];
```

### addProfileValue(property: String, value: String)
Adds a single property value to the profile. If there are already values for a property the new value will be added. Values for a property need to be unique; passing the same value multiple times will have no effect.

```Swift
client.addProfileValue("hobbies", value:"tennis")
```
```Objecitive-C
[client addProfileValue:@"hobbies" value:@"tennis"];
```

### addProfileValues(property: String, values: [String])
Adds property values to the profile. The values from the collection are added to the profile. If there are already values for a property the new values will be added. Values for a property need to be unique; passing the same values multiple times will have no effect.

```Swift
let hobbyArray = ["tennis", "soccer"]
client.addProfileValues("hobbies", values:hobbyArray)
```
```Objecitive-C
NSArray *hobbyArray = [NSArray arrayWithObjects:@"tennis", @"soccer", nil];
[client addProfileValues:@"hobbies" values:hobbyArray];
```

### setProfileValue(name: String, value: String)
Sets values on the profile. Passing a property that was already set with values will cause for the old values to be removed.

```Swift
client.setProfileValue("hobbies", value:"tennis")
```
```Objecitive-C
[client setProfileValue:@"hobbies" value:@"tennis"];
```

### setProfileValues(name: String, values: [String])
Sets values on the profile. Passing a property that was already set with values will cause for the old values to be removed.

```Swift
let hobbyArray = ["tennis", "soccer"]
client.setProfileValues("hobbies", values:hobbyArray)
```
```Objecitive-C
NSArray *hobbyArray = [NSArray arrayWithObjects:@"tennis", @"soccer", nil];
[client setProfileValues:@"hobbies" values:hobbyArray];
```

### incrementProfileValue(property: String, value: String)
Increments a value on the profile.

```Swift
client.incrementProfileValue("hobbiesCount", value: "1")
```
```Objecitive-C
[client incrementProfileValue:@"hobbiesCount" value:@"1"];
```

### setLocale(locale: String)
Setter for the locale to get the parameters for. By default, the default locale configured in BlueConic is used. Note: the only valid locales currently are 'en_US' and 'nl_NL'.

```Swift
client.setLocale("en_US")
```
```Objecitive-C
[client setLocale:@"en_US"];
```

### setURL(url: NSURL)
Checks whether the app was started with simulator data. If so we try to get the username and the the mobile session id to connect to the simulator. The intent should look like: `<appID>://<hostname>/<username>/<mobilesSessionId>`.

```Swift
// Implement in AppDelegate.swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    BlueConic.getInstance(nil).setURL(url)
    return true
}
```
```Objecitive-C
// Implement in AppDelegate.m
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[BlueConic getInstance:nil] setURL:url];
    return YES;
}
```

### createEvent(eventType: String, properties: Dictionary?)
Registers an event of the specified type with the given properties. For a “PAGEVIEW” event a screen name can be passed, so interactions can be restricted on the where tab in BlueConic. For a “VIEW”, “CLICK” or “CONVERSION” event an interactionId should be passed to register the event for.
```Swift
client.createEvent("PAGEVIEW", properties: ["screenName": "Main/HOMETAB"])
client.createEvent("CLICK", properties: ["interactionId": self._context.getInteractionId()])
```
```Objecitive-C
[client createEvent:@"PAGEVIEW" properties:@{@"screenName": @"MAIN/HOMETAB"}];
[client createEvent:@"CLICK" properties:@{@"interactionId": [self._context getInteractionId]}];
```

## InteractionContext Methods
Interface InteractionContext

### getInteractionId() -> String?
Returns the interaction id.
```Swift
let interactionId: String? = context.getInteractionId()
```
```Objecitive-C
NSString *interactionId = [context getInteractionId];
```

## InteractionContext Methods
Interface InteractionContext

### getInteractionId() -> String?
Returns the interaction id.
```Swift
let interactionId: String? = context.getInteractionId()
```
```Objecitive-C
NSString *interactionId = [context getInteractionId];
```

### getParameters() -> Dictionary
Returns the interaction parameters in a map.
```Swift
let parameters: Dictionary<String, [String]> = context.getParameters()
```
```Objecitive-C
NSDictinoary *parameters = [context getParameters];
```

### getConnection(id: String) -> Connection?
Returns the connection by id.
```Swift
let context: InteractionContext!
let connection: Connection? = context.getConnection(connectionId)
```
```Objecitive-C
InteractionContext *context;
Connection *connection = [context getConnection:connectionId];
```

### getView() -> UIView?
Returns a view for the interaction.
```Swift
let view: UIView? = context.getView()
```
```Objecitive-C
UIView *view = [context getView];
```

### getPositionIdentifier() -> String?
Returns the ‘selector’ of the position.
```Swift
let position: String? = context.getPositionIdentifier()
```
```Objecitive-C
NSString *position = [context getPositionIdentifier];
```

## BlueConicPlugin Methods
Interface BlueConicPlugin

### init(client: BlueConic, context: InteractionContext)
Creates a new Plugin instance with Client and an InteractionContext. Function should be overwritten by the Client-plugins.
```Swift
public required convenience init(client: BlueConic, context: InteractionContext) {
    self.init()
}
```
```Objecitive-C
- (instancetype) initWithClient: (BlueConic *)client context:(InteractionContext *)context {
    self = [super init];
    return self;
}
```

### onLoad()
Function onLoad will be triggerd when Plugin is registered and active on the server. Function should be overwritten by the Client-plugins.
```Swift
public func onLoad() {
    // Implementation of the plugin
}
```
```Objecitive-C
- (void) onLoad {
    // Implementation of the plugin
}
```

### onDestroy()
Function onLoad will be triggerd when Plugin is registered and active on the server. Function should be overwritten by the Client-plugins.
```Swift
public override func onDestroy() {
    // Implementation of the plugin
}
```
```Objecitive-C
- (void) onDestroy {
    // Implementation of the plugin
}
```

## Connection Methods
Interface Connection

### getId() -> String
Returns the id of the connection.
```Swift
let context: InteractionContext!
let connection: Connection? = context.getConnection(connectionId)
let connectionId = connection.getId()
```
```Objecitive-C
InteractionContext *context;
Connection *connection = [context getConnection:connectionId];
NSString *connectionId = [connection getId];
```

### getParameters() -> Dictionary
Returns the parameters of the connection.
```Swift
let context: InteractionContext!
let connection: Connection? = context.getConnection(connectionId)
let connectionParameters: Dictionary<String, [String]> = connection.getParameters()
```
```Objecitive-C
InteractionContext *context;
Connection *connection = [context getConnection:connectionId];
NSDictionary *connectionParameters = [connection getParameters];
```

## License

BlueConicClient is available under the commercial license. See the LICENSE file for more info.
