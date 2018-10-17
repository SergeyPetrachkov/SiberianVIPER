# SiberianVIPER

![](https://i.imgur.com/6FBClKx.png)

[![Version](https://img.shields.io/cocoapods/v/SiberianVIPER.svg?style=flat)](http://cocoapods.org/pods/SiberianVIPER)
[![License](https://img.shields.io/cocoapods/l/SiberianVIPER.svg?style=flat)](http://cocoapods.org/pods/SiberianVIPER)
[![Platform](https://img.shields.io/cocoapods/p/SiberianVIPER.svg?style=flat)](http://cocoapods.org/pods/SiberianVIPER)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/SergeyPetrachkov/SiberianVIPER)

Swift protocols for VIPER from Siberia with love!

Try also [VIPERTemplates](https://github.com/SergeyPetrachkov/VIPERTemplates) and [SiberianSwift](https://github.com/SergeyPetrachkov/SiberianSwift) !

## Requirements

Swift >4.0, iOS version >= 9.0

## Installation

SiberianVIPER is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SiberianVIPER"
```

2.0.2 and 3.0.* versions are not fully compatible. You'll need to specify pod version.

To install SiberianVIPER you can also use Carthage. Just add the following to your Cartfile:

```ruby
github "SergeyPetrachkov/SiberianVIPER"
```

## Example

You can find an example usecase of SiberianVIPER. See kindly attached Example project. Modules have been generated by VIPERTemplates (see the link above). VIPERTemplates also go with a couple of snippets for fast cell-cellModel pairs creation.

## Author

Sergey Petrachkov, petrachkovsergey@gmail.com

## Contributing
### Some easy steps
1. Create a fork.
2. Checkout develop.
3. Use gitflow to create a feature branch.
4. Implement your thing.
5. Clean code if needed.
6. Submit pull request.

### How to write commits messages?
Not only a commit message must contain a short description of changes done in this commit but a short description of why any work had been done.
Every developer can see the difference between two commits but it's very important to know why it has been done.

Bad commit message example:
```
changed DummyViewController
```

Good commit message example:
```
updated DummyViewController with dummy things to match another dummy thing
```
or even better:
```
refs #999 - fixed bug where app would crash when entering DummyViewController

the reason of crash was incorrect handling of setup values"
```
Another idea is to add references to tickets one's working on. Popular management systems like unfuddle or redmine can monitor repositories and link commits to tickets, so a customer or a project manager/ teamleader or a person who performs code review can just open a ticket and see all the work done for that ticket.
