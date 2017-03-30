Pod::Spec.new do |s|  
  github_user = 'test_user'
  s.name             = "PrivatePodA"  
  s.version          = "0.0.1"
  s.summary          = "#{s.name} private pod example."

  s.description      = <<-DESC
  #{s.name} private pod example. This is a dependency.
                       DESC

  s.homepage         = "https://github.com/#{github_user}/#{s.name}"
  s.license          = 'MIT'
  s.author           = { "Lobanov Dmitry" => "gaussblurinc@gmail.com" }
  s.source           = { :git => "https://github.com/#{github_user}/#{s.name}.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  core_path_prefix = 'Core'
  framework_supplement = "#{core_path_prefix}/FrameworkSupplement"

  s.module_name = s.name  
  s.module_map  = "#{framework_supplement}/Map.modulemap"
  umbrella_header = "#{framework_supplement}/#{s.module_name}.h"

  s.source_files = "#{core_path_prefix}/**/*"

  s.public_header_files = [umbrella_header] + [
    "Public/*.h"
    ].map{|path| "#{core_path_prefix}/#{path}"}


  s.dependency 'CocoaLumberjack', '~> 3.0'

  s.subspec 'Tests' do |ss|
    ss.source_files = "#{core_path_prefix}/**/*"
    ss.public_header_files = [
      "Public/*.h",
      "Private/*.h"
    ].map{|path| "#{core_path_prefix}/#{path}"}
  end
end
