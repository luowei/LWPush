# LWPusher

[![CI Status](https://img.shields.io/travis/luowei/LWPusher.svg?style=flat)](https://travis-ci.org/luowei/LWPusher)
[![Version](https://img.shields.io/cocoapods/v/LWPusher.svg?style=flat)](https://cocoapods.org/pods/LWPusher)
[![License](https://img.shields.io/cocoapods/l/LWPusher.svg?style=flat)](https://cocoapods.org/pods/LWPusher)
[![Platform](https://img.shields.io/cocoapods/p/LWPusher.svg?style=flat)](https://cocoapods.org/pods/LWPusher)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LWPusher is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LWPusher'
```

### Usage

```
[[LWPushManager shareManager] configAppID:2288888899 appKey:@"I45XXXXXXXEA"];
[[LWPushManager shareManager] handPushInApplicationDidFinishLaunchingWithOptions:launchOptions];
```

## Author

luowei, luowei@wodedata.com

## License  

LWPusher is available under the MIT license. See the LICENSE file for more info.


## PEM生成  
```
openssl pkcs12 -in aps.p12 -out aps.pem -nodes  
openssl pkcs12 -in aps_development.p12 -out aps_development.pem -nodes  
```
