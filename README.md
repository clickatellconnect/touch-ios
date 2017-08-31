Touch SDK iOS is a library that enables customized bot-powered chat capabilities in your app to provide users with a human-like interaction with the services provided in the app.
Compatibility
The SDK deployment target is 9.0
Install React Native
   brew install node
   npm install -g react-native@0.45.1
Add SDK

Go to your Xcode project's "General" settings. Drag TouchSDK.framework to the "Embedded Binaries" section. Make sure “Copy items if needed” is selected and click Finish.



Finally, you'll need to work around an App Store submission bug. To do this, create a new “Run Script Phase” in your app’s target’s “Build Phases” and paste the following snippet in the script text field:
      bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/TouchSDK.framework/strip-frameworks.sh"



Add necessary libraries into podfile
       platform :ios, '9.0'

       use_frameworks!


       react_native_path = "/usr/local/lib/node_modules/react-native"

       target ‘ExampleTouchSDK’ do
        pod 'SDWebImage'
        pod 'Alamofire'
        pod 'Bond'
        pod 'SQLite.swift'
        pod 'Fabric'
        pod 'Answers'
        pod 'Yoga', :path => "#{react_native_path}/ReactCommon/yoga"
        pod 'React', :path => react_native_path, :subspecs => [
          'Core',
          'RCTImage',
          'RCTNetwork',
          'RCTText',
          'RCTWebSocket',
          'BatchedBridge',
          'DevSupport',
          'RCTLinkingIOS'
          ]
        pod 'RNSVG', :git => 'https://github.com/react-native-community/react-native-svg', :tag => ‘5.1.7’
        pod 'XMPPFramework', :git => 'https://github.com/robbiehanson/XMPPFramework.git', :branch => 'master'
       end



Installing pods
Open Terminal
Go to filder with your project
Execute command: ‘pod install’
Execute command: ‘pod update’
Cocoapods should be updated
Usage
Initialize in AppDelegate (not necessary)
Add initialization to AppDelegate’s application:didFinishLaunchingWithOptions method:
ServiceLocator.initialize()
Get list of Tenants:
ServiceLocator.chatManager.getTenants { (tenants:[ Tenant ]) in }
Create and initialize ChatViewController or set ChatViewController class in Storyboard to the particular view controller
let chatViewController = ChatViewController()
chatViewController.join( <Tenant>)
ChatViewController should be presented to join the tenant
Done
If everything went well, you should now be able to open a chat activity with your own bot.
