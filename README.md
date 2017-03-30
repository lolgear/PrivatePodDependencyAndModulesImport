# PrivatePodDependencyAndModulesImport
CocoaPods sample app that shows modules imports inconsistency case.

Description: 
Private Pod A is a dependency.
Private Pod B is a a pod that depends on Private Pod A.

CocoaLumberjack was chosen as external pod to show correct module import.

Scenario:

I have two frameworks, both private.
One of the framework has another framework as dependency.
Consider framework PrivatePodA and framework PrivatePodB ( PrivatePodA ).

I would like to use modules imports ( `@import PrivatePodA;` ) in framework PrivatePodB.
Everything fine before I starting to refactor tests.

Consider PrivatePodATests and PrivatePodBTests as Tests projects for these frameworks.
These projects have test targets that have dependencies on private frameworks.
More precisely, ATests depends on A and BTests depends on B and A accordingly.

PrivatePodA and PrivatePodB are private frameworks and live locally on machine.
PrivatePodATests use PrivatePodA as normal angled import.

Sample from PrivatePodATests:
`#import <PrivatePodA/PrivatePodA_One.h>`

Everything is normal here.

BTests use B as normal angled import and A as normal module import.
`#import <PrivatePodB/PrivatePodB_One.h>`
`@import PrivatePodA;`

However, module PrivatePodA doesn't exists for PrivatePodBTests target.
Moreover, every import of public PrivatePodB header that contains import of PrivatePodA fails.
`#import <PrivatePodB/PrivatePodB_One.h> // Fail! PrivatePodB_One.h has import @import PrivatePodA;`

In a nutshell,
Dependent private framework could not be a module in test target.
How to solve this issue?

Scenario in files:

`// PrivatePodA framework folder`
```yaml
PrivatePodA
- Core
-- FrameworkSupplement
--- Map.modulemap
--- A_UmbrellaHeader.h
- Framework
- Tests
-- Tests
-- ATests.xcworkspace
-- ATests.xcodeproj
-- Podfile
-- Podfile.lock
- PrivatePodA.podspec
```

`// PrivatePodB framework folder`
```yaml
PrivatePodB
- Core
- Framework
- Tests
-- Tests
-- BTests.xcworkspace
-- BTests.xcodeproj
-- Podfile
-- Podfile.lock
- PrivatePodB.podspec
```