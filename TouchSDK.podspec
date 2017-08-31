Pod::Spec.new do |s|
  s.name             = 'TouchSDK'
  s.version          = '1.27.0'
  s.summary          = 'Introducing the new digital front office solution for your business'

  s.description      = 'We live in a ‘mobile always’ world, where consumers press a button to get what they want – yet businesses are stuck in an era of slow call centres.Clickatell Touch is a one-touch on-demand mobile platform that enables your business to resolve customer queries, anywhere, in real-time. Touch connects consumers and businesses through chat, so you can deliver what your audience wants when they want it, at the touch of a button.'

  s.homepage         = 'https://www.clickatell.com'
  s.screenshots     = 'https://www.clickatell.com/content/uploads/2016/11/Clickatell-Touch-GIF-Chat-Interface-1.gif'
  s.license          = { :type => 'Copyright', :file => 'LICENSE' }
  s.author           = { 'clickatel' => 'https://www.clickatell.com' }
  s.source           = { 
    :http => 'https://touchcdn.clickatell.com/TouchSDK_IOS_1.27.0.tar.gz'
  }

  s.ios.deployment_target = '9.0'

  s.vendored_frameworks = 'TouchSDK.framework'

end
