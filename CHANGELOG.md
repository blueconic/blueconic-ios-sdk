# Changelog
All notable changes to this project will be documented in this file.
`BlueConicClient` adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [4.0.0] 2024-12-15

### Changed
- Removed the requirement to add your hostname to the app plist files. The SDK requires now to be initialized with a `BlueConicConfiguration` object in code via an 'initialize' function.
- Reworked the SDK to require an initialization step before any other SDK functions can be called.
- The SDK BlueConicEventFactory class is not available anymore. Instead, the BlueConicEventManager class can be retrieved from the SDK instance via the `BlueConic.getInstance().getEventManager()` method.

### Added
- Added dedicated functions for creating events that are sent to the BlueConic server for the following events: 'PageView', 'Click', 'View', 'Conversion'. These functions can be called from the SDK instance.
- Added dedicated functions for publishing events for the following events: 'ClickEvent', 'AdvancedEvent', 'FormSubmitEvent', 'UpdateContentEvent', 'UpdateValuesEvent'. These functions can be called from the BlueConicEventManager class.
- Added Visit Listener plugin support.
- Added Properties Based Dialogue plugin support.
- Added ability to subscribe and unsubscribe to events via the BlueConicEventManager class. Currently the supported events are related to the Properties Based Dialogue plugin.
- Added ability to clear profile id locally from cache.
- Added optional callback information for a majority of the SDK functions.
- Added additional ability to connect to the BlueConic simulator for testing purposes via the BlueConicConfiguration object when initializing the SDK.
- Added ability to set a custom app scheme instead of the default application bundle id. This can be set via the BlueConicConfiguration object when initializing the SDK.

## [3.3.0] 2024-06-14

### Changed
- Migrated SDK local file save location for enhanced security and added obfuscation to the file contents.

### Added
- Added support for timeline events in the SDK.

### Fixed
- Fixed minor issues with processing UI elements for Form Listeners.

## [3.2.0] 2024-03-12

### Added
- Privacy Manifest as required by Apple Privacy Guidelines.
- SDK Code signing.

## [3.1.0] 2024-02-23

### Added
- Internal tracking for React Native usage

## [3.0.0] 2023-10-26

### Added
- Support for Binary Framework
- Support for Swift Package Manager

### Changed
- Updated minimum iOS version requirement to 12
- The main api class renamed from 'BlueConicClient' to 'BlueConic'

## [2.9.0] 2023-9-4

### Added
- Support for Swift 5.8.1

### Fixed
- BC-30211 - Set (if empty) not setting values in Rule Based form listener
- BC-23244 - Error on lightbox without content
- BC-30869 - Order of plugin disposal/recreation after a page switch is incorrect

## [2.8.10] 2022-3-1

### Added
- Support for Swift 5.7.2

## [2.8.9] 2022-6-7

### Added
- Support for Swift 5.6.1
- BC-24942 - Add increment method to ios sdk

### Fixed
- BC-25105 - Sending information on deleted properties for RPC hash getProperties is not supported

## [2.8.8] 2021-11-24

### Fixed
- BC-22917 - Set (if empty) not setting in Behavior listener for Mobile SDK

## [2.8.7] 2021-9-27

### Added
- Support for Swift 5.5

### Fixed
- BC-22652 - iOS SDK has a cache file that does not get cleared; slows the app down
- BC-23082 - Clean-up outdated files

## [2.8.6] - 2021-5-3

### Added
- Support for Swift 5.4

### Changed
- BC-21543 iOS SDK creating a new profile for each pageview event. By setting bc_shared=false in the Info.plist a dedicated BlueConic cookie store is used.

## [2.8.5] - 2020-11-3

### Changed
- the logic in `setUrl` to only call `setHostname` when `debug` mode is `true` to avoid invalid URL as overrule hostname.

### Fixed
-  Security issue in the simulator mechanism to not overrule the hostname when `debug` mode is `false`

## [2.8.4] - 2020-9-20

### Added
- Support for iOS14
- New method `setMobileAdId(mobileAdId)` which can be used to programmatically set the IDFA/ Mobile Advertising UID, to apply for the new rules regarding Privacy, Data tracking, and IDFA

### Removed
- the `GlobalListener` will no longer auto-detect and set the IDFA/ Mobile Advertising UID. The profile properties "Mobile Ad Id (Most Recent)" `mobile_ad_id` & "Mobile Ad Id (all)" `mobile_ad_ids` are removed from this listener, and can be set/stored via the new method `setMobileAdId`

## [2.8.3] - 2020-7-16

### Fixed
- A small issue in  `EngagementService` where multiple items were stored with pipes (`|`) instead of seperate values 

## [2.8.2] - 2020-6-16

### Added
- Debug statements around connecting with the Simulator
- New method `setURL(url) -> Bool` to connect with the Simulator and retrieve a status `true` or `false` when the connection succeeded.

### Changed
- `BlueConicEventManager` uses the BlueConic `DispatchQueue`
- Changed the `GlobalListener` to collect data without any `Context` to also support non-`ViewController` pages.

### Fixed
- Multithreading issues when registering Events via the `BlueConicEventManager` 

## [2.8.1] - 2020-4-27

### Fixed
- Process of `Segments` during a register of a `PAGEVIEW` event
- Support for callback methods, design for `ReactNative`-module

## [2.8.0] - 2020-4-17

### Added
-  Support for Swift 5.2
- New method `registerPluginClass :className` to register custom `BlueConicPlugin` classes, registering plugins and specify on class name
- New method `getSegments` retrieve all semgents where the profile belongs to. BlueConic Segments are retrieved when there is a `PAGEVIEW` event created.
- New method `hasSegment` validate if a profile is in a certain segment, based on Segment ID.
- New method `createEvent :properties :completion` - Create event method with a callback/ completion mechanism to do follow up actions at the time BlueConic retrieved new data from the servers 
- New method `createEvent :data :completion` - Create event method with a callback/ completion mechanism to do follow up actions at the time BlueConic retrieved new data from the servers
- New method `updateProfile` - Update the profile instantly push/ sync all profile property data with the profile on the BlueConic tenant.
- New method `updateProfile :completion` - Update the profile method with callback/ completion mechanism to do follow up actions at the time BlueConic retrieve new profile data from te servers.
- New method `getInstance` - Retrieve an instance without sending a ViewController along, improvement on the method calls `getInstance(nil)`
- New methods for `InteractionContext` to call within your `BlueConicPlugin`:
-- `getInteractionTypeId` The ID of the interaction type
-- `getPluginType` The type of the plugin
- Extra accessiblity for other (UI) Frameworks - not using `ViewController`s

### Changed
- The internal property of the ViewController `context` to a `weak` variable, to avoid keeping a refers to this
- The `context` statment to be optional `PAGEVIEW` and/or custom events, can now trigger an event without the need of a `ViewController`. 

### Fixed
- The issue for `addRefusedObjective` not pushing refushed objectives 
- Running background tasks on the main thread.

## [2.7.0] - 2020-2-17

### Added
- New privacy legislation methods `getPrivacyLegislation` and `setPrivacyLegislation`
- New Objectives getter methods `getConsentedObjectives`, `getRefusedObjectives`
- New Objectives setters methods `setConsentedObjectives`, `setRefusedObjectives`
- New Objectives adders methods `addConsentedObjective`, `addRefusedObjective`
- New method `isEnabled` and `setEnabled` to enable or disable the BlueConicClient SDK programmatically 
- New method `registerPluginClass` to register custom `BlueConicPlugin` classes, registering plugins
- New method `createEvent: withData` that supports a map `[String: Any]`
- New methods for `InteractionContext` to call within your `BlueConicPlugin`:
-- `getName` The name of the interaction
-- `getPluginType` The type of the plugin
-- `getPositionName` The name of the (channels) position
-- `getDialogueId` The ID of the dialogue ( Only used for `Action`s )
-- `getDialogueName` The Name of the dialogue ( Only used for `Action`s )

### Changed
- The deprecated `UIWebView` to `WKWebView`.
- Support for custom/ timeline events with context `createEvent`- custom events are now sent to BlueConic servers and could be used to store these events on the timeline
- Clear the events on `BlueConicClient` level when a `PAGEVIEW` event is called.
- Execute all published `Events` after the  `onLoad` of all plugins is called, so none of the published `Event`s are missing for these calls.
- Moved `BlueConicEventFactory` and `BlueConicEventManager` from `Plugin`-directory to `BlueConicClient`, this is now part of the `main`

### Fixed
- Handle all events between `PAGEVIEW` event and the plugins `onLoad` method correctly
- Don't store the invalid value (`00000000-0000-0000-0000-000000000000`) to profile property `Mobile Ad ID`
- Crashes around registering plugin classes. Issue `objc_getClassList` when the parameter is not a `MutablePointer`

### Removed
- All `cleanup`-event calls in `Listeners` this is no longer required this is no managed by `BlueConicClient` instead by the `BlueConicPlugin`s individually

## [2.6.1] - 2019-11-3

### Added
- Support for Swift 5.1

### Changed
- Improved the build mechansim
- The build signing set the correct developerment group

### Fixed
- Resolved warnings happened during the Cocoapod spec

## [2.6.0] - 2019-7-22

### Added
- Support to retrieve interactions based on creating custom events
- Support for Swift 5.0

### Changed
- The implementation of the `createEvent` function. Allowing to retrieve interactions based on custom events.

### Fixed
- Resolved issues around the date and date/time options in the Behavior Listener

### Removed
- Unused files


## [2.5.4] - 2019-7-3

### Changed
- The implementation to connect with the simulator, it will directly make a connection when `setUrl` has been called. Previously this was after the next pageview.
- The data stores of simulator data will now be added to the device as long as the simulator session is alive.

### Fixed
- Resolved issues around losing the connection with the simulator

## [2.5.3] - 2019-6-26

### Added
- Support to the Global Listener to be able to keep track of adding multiple values to the following properties: `Mobile Ad Id (most recent) & Mobile Ad Id (all)`

## [2.5.2] - 2019-5-16

### Fixed
- Resolved crashes in BlueConicQueue
- Reverted changes made to the BlueConicQueue

## [2.5.1] - 2019-5-1

### Added
- Support to the Global Listener to be able to keep track of adding multiple values to the following properties: `App ID (all)`, `App name (all)`, `App name and version (all)`, `Device hardware vendor (all)`, `Device model (all)`, `Device DPI (all)`

### Changed
- Renaming the existing app related properties to include (Most recent), e.g. `App name` =>`App name (Most recent)`

### Fixed
- Resolved issues around debug logs

## [2.5.0] - 2019-4-2

### Added
- A `context` property to the `ClickEvent`
- A `context` property to the `FormSubmitEvent`
- Possibility to use context values of event in our services
- Register the available plugin classes when initializing the `BlueConicClient`-instance


### Changed
- The `EngagementService` in order to support context values as content area for the following listeners
- Support event context for `BehaviorListener`-rules
- Support event context for `EngagementRankingListener`-rules
- Support event context for `EngagementScoreListener`-rules
- Fallback mechanism for `FormListenerService` if there is no value available we use the event context instead.

### Fixed
- Resolved issues around multiple threading in combination with profile split.
- Resolved issues around not reloading the profile properties when a profile switch took place.
- Resolved issues around debug logs
- Resolved issues around handling the wrong `ClickEvent`s when an event with a specific selector was published

### Removed
- Unwanted error logging is not removed


## [2.4.5] - 2019-3-8

### Added
- A base class for `EventServiceBase`, all other event services are extending from this base class and provides the default function that they need

### Changed
- The way we sent along the parameters to the Event Services
- some `nilable` properties/ unnecessary checks around whether values were `nil`

### Fixed
- Resolved issues around the form listening service, so that `handleTouchEvent` should check the selector that is passed in the event against the selector of rules it is iterating over.
- Resolved issues around the form listening service, so that `Click`-rules now are able to be handled properly, especially around click rules that were defined as a Form Submit event
- Resolved issues around the form listening services, so that we are able to handle events that are based of Field changed events
- Resolved issues around subscribing events in general, all events will be subscribed/ enabled for publishing after all the listener rules have been applied and initialised.

## [2.4.4] - 2019-1-16

### Added
- A new method to the BlueConicClient `getProfileId` which returns the ID of the BlueConic Profile. 

### Changed
- The engagement service has now support for the halftime mechanism used by our engagement listeners
- The implementation on how to retrieve data/text from view-elements

### Fixed
- Resolved issues/ crashes around connecting with the simulator
- Resolved issues the different mechanisms around the Interest ranker Listener and Scoring Listeners

## [2.4.3] - 2018-12-14

### Added
- Add "is empty" options to the Behavior listener
- Enrich Profile Origin properties support added to the Global listener

### Fixed
- Resolved issues around "value"-typed Listener rules not getting handled correctly.


## [2.4.2] - 2018-11-8

### Fixed
- Resolved issues with the EventManager not handling all events correctly

## [2.4.1] - 2018-10-31

### Added
- Migration step for "Rule based form listener" plugin (FormListener)
- UnitTests regarding migration

### Fixed
- Resolved issues with Rule based form listener

## [2.4.0] - 2018-8-10

### Added
- Support for Swift 4.2
- Support for XCode 10

### Fixed
- Resolved build issues with multiple commands produce
- Resolved build issues with duplicated output file

### Removed
- `BlueConicPlugin` class, the old plugin protocol which was deprecated since 2017-12-4

## [2.3.3] - 2018-5-22

### Added
- Support for Swift 4.1

### Changed
- Improvements when sending the request `setProperties` and `addProperties` to BlueConic

## [2.3.2] - 2018-4-12

### Changed
- Improved the BlueConic logging
- Rewrite BlueConic logging by using `print` instead of `NSLog`

## [2.3.1] - 2018-4-5

### Fixed
- Resolved issues with debug logging of the response from the server

## [2.3.0] - 2017-12-4

### Added
- Support for Swift 4.0
- New protocol for the `Plugin`, named `BlueConicPlugin`

### Changed
- Major improvements in the code
- Rewrite file manager components by using `Codable` instead of `NSCoding` and `JSONDecoder/JSONEncoder` instead of `NSKeyedUnarchiver/NSKeyedArchiver`

### Deprecated
- Old `Plugin` class with be removed in the upcomming release, please use `BlueConicPlugin` instead.

### Security
- Removed all unnecessary Objective-C implementations
- Improved Security concerns

## [2.2.4] - 2017-4-19

### Changed
- Improved the logic of retrieving the domain group
- Improved redirecting requests

### Fixed
- Resolved issues with channels in custom domain groups


## [2.2.3] - 2017-4-12

### Changed
- Improved the logic of archiveing the cache data

### Fixed
- Resolved issues with upgrading apps from Swift 2.3 to Swift 3.0

### Security
- Improved the logic of archiveing the data

## [2.2.2] - 2017-2-16

### Added
- Support for ALB

### Fixed
- Minor bug issues with sending the request to BlueConic

## [2.2.1] - 2017-2-15

### Added
- Logic to make `BlueConic` isolated from app threads for Swift 3.0
- Logic implemented to run all code within `Blueconic` synchronized and thread-safe for Swift 3.0
- Implemented a Facade to the framework for Swift 3.0

### Changes
- Improved all code to be thread-safe for Swift 3.0

## [2.2.0] - 2017-2-14

### Added
- Support for Swift 3.0

## [2.1.11] - 2016-11-21

### Added
- Logic to make `BlueConic` isolated from app threads for Swift 2.3
- Logic implemented to run all code within `Blueconic` synchronized and thread-safe for Swift 2.3
- Implemented a Facade to the framework for Swift 2.3

### Changes
- Improved all code to be thread-safe for Swift 2.3

## [2.1.10] - 2016-10-17

### Changed
- Removed duplicated code
- Improved code by SonarQube rules

### Fixed
- Minor bug fixing for Swift 2.3


### Security
- Security issues solved

## [2.1.9] - 2016-10-14

### Fixed
- Minor bug fixing for Swift 2.3

## [2.1.8] - 2016-10-13

### Added
- Support for Swift 2.3

### Changed
- Improvements in loading the plugins

### Fixed
- Resolved issues with the commiglog
- Resolve issues with non-accessible memory blocks

## [2.1.7] - 2016-5-19

### Changed
- Improvements to debug-loggin

### Fixed
- Resolved issues with force downcasts

## [2.1.6] - 2016-5-11

### Fixed
- Changed Swift Optimizatino level
- Resolved issues with non-accessible memory blocks


## [2.1.5] - 2016-3-23

### Added
- Support for Swift 2.2

### Changed
- Updated the code to the new Swift 2.2 syntax

## [2.1.4] - 2016-1-20

### Added
- Implementation of `UpdateValueEvent`
- Added extra debug-logging messages

### Changed
- Improvements to `FormListeningService`
- Improvements to `Event`

### Fixed
- Minor bug fixing

## [2.1.3] - 2015-11-16

### Fixed
- Minor improvements in the BlueConic plugins

## [2.1.2] - 2015-11-10

### Added
- Support for CocoaPods
- Support for iOS 7.0

### Changed
- Minor changes to improve the support CocoaPods

### Fixed
- Bug fixing

## [2.1.1] - 2015-11-10

### Added
- Debug and release versions

### Fixed
- Minor bug fixing to support for Swift 2.0


## [2.1.0] - 2015-11-10

### Changed
- Add Support for Swift 2.0
- Convert to new syntax
- Improved directory layout

### Fixed
- Enable bitcode

## [2.0.4] - 2015-10-21

### Changed
- Increased minimum OS version to 8.0
- Improved Building settings

### Fixed
- Support all Architectures
- Resolved Submit to App store errors

## [2.0.3] - 2015-09-15

### Changed
- Added extra logic to the commit log

### Fixed
- Resolved issues with clearing all commit log entries
- Fixed the commit log to be thread-safe

## [2.0.2] - 2015-06-26

### Added
- Logic to redirect the request correctly

### Changed
- Improved the `BlueConicConnector`
- Changes to the Connector to send the requests asynchronous

### Fixed
- Resolved several issues with network connection losts
- Resolved issues with redirecting

## [2.0.1] - 2015-06-26

### Added
- Added `BehaviorListener` plugin
- Added `EngagementRankingListener` plugin
- Added `EngagementScoreListener` plugin
- Added `FormListener` plugin
- Added `FullscreenLightbox` plugin
- Added `PreferredHourListener` plugin

### Changed
- Changed logic of the PAGEVIEW event
- Improved loading plugins

## [2.0.0] - 2015-02-10

### Added
- Added stop and start mechanism for interactions
- Added `GlobalListener` plugin

### Changed
- BlueConicClient has been updated and rewritten in Swift

## [1.0.0] - 2013-06-26

### Added
- Initial release of BlueConicClient.
- Logic to send and retrieve data from a BlueConic server.
- Logic to get, set and update profile properties.
- Logic to create view, click and conversion events.
