
# Badgeable

[![CI Status](http://img.shields.io/travis/gwangpa/Badgeable.svg?style=flat)](https://travis-ci.org/gwangpa/Badgeable)
[![Version](https://img.shields.io/cocoapods/v/Badgeable.svg?style=flat)](http://cocoapods.org/pods/Badgeable)
[![License](https://img.shields.io/cocoapods/l/Badgeable.svg?style=flat)](http://cocoapods.org/pods/Badgeable)
[![Platform](https://img.shields.io/cocoapods/p/Badgeable.svg?style=flat)](http://cocoapods.org/pods/Badgeable)

## Badgeable

Bedgeable is a protocol can display badge into your any custom UI components or even apply all UIView.

## Requirements
- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Badgeable into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target '<Your Target Name>' do
    pod 'Badgeable'
end
```

Then, run the following command:

```bash
$ pod install
```
### Carthage

Will support [Carthage](https://github.com/Carthage/Carthage) soon.

### Manually

If you prefer to install manually.

- Clone Badgeable
- Copy `Badgeable.swift` file into your Xcode project.
- That's it!

## Usage

Add `import` syntax where you would conform `Badgeable` protocol.

```swift
import Badgeable
```

Conform `Badgeable` protocol where you want to display badge.

```swift
// Conform Badgeable protocol in your class.
class YourButton: UIButton, Badgeable {
    // ...
}
```

Then you can display badge by setting `badgeCount` property.

```swift
class YourViewController: UIViewController {
    @IBOutlet weak var button: YourButton!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.badgeCount = 6
    }
}
```

You can change the appearance.
```swift
button.maxValue = 5 //shows: (5+)
button.badgeColor = .orange
button.badgePosition = .bottomRight
```

You can conform `Badgeable` protocol even UIView by extension.

```swift
// Conformance Badgeable into UIView
extension UIView: Badgeable {}
```

Then all UI components can display badge by setting `badgeCount` property.

## TODO

- Configurable badge appearance. 
	- [X] Badge Color
- [X] Adjustable badge position. For example: TopLeft, TopRight, BottomLeft and BottomRight.
- [ ] Animatable.

## Author

Daniel (Dae Hyun) KIM, gwangpa@gmail.com

## License

Badgeable is available under the MIT license. See the LICENSE file for more info.
