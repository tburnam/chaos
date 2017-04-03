## Chaos

## Build steps

---
- Install `nvm` and update to the latest version of Node.
- Type `which node` and copy the output.
-  Go paste the output in chaos/chaos/ViewController.swift line `306`:
```swift
// Set the task parameters
// MARK: Put your NODE v.7.7.4 OR HIGHER path here
task.launchPath = "your path should be something like: /Users/name/.nvm/versions/node/v7.7.4/bin/node"
task.arguments = [scriptPath]
```
- Make sure you have a `/usr/local/` folder on your machine and that `/usr/local/bin` is created and on your $PATH.

- cd to this directory and run `./buildChaos`.
- It should run now if you launch Xcode.


Will support better build process in near future
