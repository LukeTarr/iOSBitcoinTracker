# iOSBitcoinTracker
A Bitcoin price checker for iOS made in Swift 5

Uses the https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC API and parses returned JSON to find current asking price of Bitcoin.

Built with Swift 5, Cocoapods, Alamofire, and SwiftyJSON.

# What I Learned
This project solidified my knowledge of designing user interfaces for the iOS platform, as well as using third-party Cocoapods to enhance my applications with libraries. I also learned how to request data from an API, and handle JSON responses in order to display that response to the end user.

# Current Build Errors
With iOS 13 and Xcode 11 released, This project seems to fail to build. The solution is this: within Xcode remove the 'BitcoinTracker copy' files that Xcode 11 is automatically generating for the build to succeed. I don't know why the new Xcode version creates this file but it does not exist in Finder. When I find out what is generating this I'll remove it and delete this part of the README, but for now, this is neccesary.
