Pod::Spec.new do |spec|
  spec.name         = 'SwiftUI-PullToRefresh'
  spec.ios.deployment_target  = '14.0'
  spec.version      = '1.0'
  spec.swift_versions = '5.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/YuantongL/SwiftUI-PullToRefresh'
  spec.authors      = { 'Yuantong Lu' => 'lytgopro@gmail.com' }
  spec.summary      = 'A custom ScrollView like component that supports pull to refresh.'
  spec.source       = { :git => 'https://github.com/YuantongL/SwiftUI-PullToRefresh.git', :tag => spec.version }
  spec.source_files = 'Source/**/*.swift'
end
