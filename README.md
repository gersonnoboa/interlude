#  Interlude
Attention: Note that the answers for the theory part are inside the app too.

## To run
To run the app, open the root project folder and execute:

1. `sudo gem install cocoapods` 
2. `pod install`
3. Open `Interlude.xcworkspace`
4. Go to `Constants.swift` and paste your API token on the `apiToken` constant.

## Some thoughts
- I got the requirement to use Gravatar for images, however the API returned a Pipedrive-owned link (apparently you use AWS). So I used that instead. I don't know if that was wrong but the app shows the image regardless.
- I wanted avoid using third-party libraries, but Quick and Nimble are so nice.
- I used Clean Swift as the architecture for the app. Maybe for a small app like this, it is slightly overkill, with lots of files and sometimes having components do very little, but my idea was to show my behavior when working on a big app, not on a small one.
- I used UserDefaults for persistance... It was just easier to implement than try to go with CoreData. I already spent lots of time in the app already and I didn't want to stretch it any longer. This kind of conflicts with the previous point, but also the idea is that with this architecture, as long as a boundary object is generated and returned by the worker, how the data is stored and retrieved makes no difference to the rest of the app, since everything is decoupled.
- I wrote unit tests for the PersonList scene only for the same reason (I didn't want to drag it more). But the same concept applies for the rest of the scenes.

