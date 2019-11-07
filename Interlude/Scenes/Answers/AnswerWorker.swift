//
//  AnswerWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol AnswerWorkerProtocol {
    func fetchAnswer(with request: Answer.Request) -> Answer.Response
}

final class AnswerWorker: AnswerWorkerProtocol {
    func fetchAnswer(with request: Answer.Request) -> Answer.Response {
        var text = ""
        
        switch request.index {
        case 0:
            text = "I would implement it exactly how I am doing it on this app. Granted, I am using UserDefaults instead of CoreData for the persistance because of the lack of time, but the idea is that the interactor, presenter, and view controllers are completely indifferent about where the data is coming from, so, if CoreData would be implemented, only the Persistance class would change. This means that problems like change in requirements, deprecated APIs, migration to new libraries, etc. are all easy to fix.\n\nOne of the difficulties that wasn't addresssed here is when you need to load several requests that have to succeed. For that I would make an operation queue, and if they are successful, then show the content, otherwise fail. We have done this in the Minun Telia app that I am working on, through the use of a protocol that defines a method that does the requesting, and a state for the view (loading, success, failure, update). If it fails, a generic view is shown with a retry button, which calls the previously mentioned method. It works fine :)\n\nAnother issue comes when the schema of the data needs to change. If you see Revolut's blog, you will see that they recently had an outage caused by this. Actually this app is not resilient to that, and will not react well to changes in the schema, but the issue is solvable by not forcing fields when encoding and decoding (like it was done for pictureURL). I opted for convenience because I know my schema will not change for this app because this is the last version."
        case 1:
            text = "I have seen apps (like Twitter clients, for example), that during their setup process they 'create a database' the first time, so that way the user is not annoyed by constant reloading, although the first launch is a little bit painful. Some probably even do it cleverly and start as soon as you start the tutorial, after getting your auth tokens.\n\nThe other method would be pagination, which is easier to implement and is done extensively in lots of apps. While it was suggested to do it on this app, I just have worked several days on this app and wanted to finish it, and preferred to add unit testing instead :)\n\nSomething that I have done, however, is having a 'last updated time' field in the DB, have that last update time saved in the client, and send it when querying this API. Then the API would return only the objects that have been updated between the client's last update time and now, and update the phone's DB (that has been populated before, of course) and last update time to the current time. This method has its own difficulties, like timezones, but those can be addressed by agreeing to use one timezone for everything, like UTC.\n\nFinally, if it is required to show 100k objects in an app, maybe the app's flow needs to be rethought... Because that doesn't sound as good UX."
        case 2:
            text = "Have less complicated cells :) That is the easiest. If you have lots of elements in a cell, the design is probably cluttered and looks bad. Other than that, there are several ways. First, I see that Pipedrive's API sends two different image links on their API, maybe for this specific reason. If the imageView is small, there is no need for 512x512 profile pictures. In our app we cache the heights of the rows in some situations to avoid calculating it all the time. Actually just calculating a lot of stuff in the cellForRow method is bad. Ideally you just set values there and avoid calculating stuff there. Setting the contentView (and the cell) to opaque also works. On very old devices, like iPhones 3GS and 4, having solid colors instead of transparent ones was a huge benefit, but not anymore on current ones.\n\nLess ideal but effective is writing the interface inside the cell class instead of using a XIB, but then you lose a lot of convenience. However, if it is requirement, AND the slowness comes at the beginning (when the cells are being initialized instead of when all required cells have been allocated and can be reused), then this works.\n\nAs a very last resort, drawing directly on the cell increases cell's performance considerably. It is very messy and prone to errors, but it works"
        case 3:
            text = "a) It would be very hard to have every single language fitting on the design, so trying to use constraints as they are intended should do the trick most of the time. For example, not making interfaces in which the space is limited to either side and instead give a whole line to labels. For example, in my app, instead of displaying the person details side by side, they can be displayed on two different lines instead.\n\nb) There are services for that. Once I helped a guy translating his app into Spanish and we used a platform called Crowdin. Worst case scenario, Google Sheets and some script that generates the files based on that Excel. This is something that we have just started in Telia, so I haven't dealt with these situations yet. It is unfortunate, in some months I would have given an answer that is a lot better than this.\n\nc) If the app is supported in 20 languages, then probably it is the responsibility of some translation agency to get them right. I really don't know what can be done by me to ensure the correctness of the translation of 20 languages because I don't know them, other than have an agency for it. Don't use Google Translate, I have seen apps translated to Spanish by Google Translate and they suck.\n\nd)The biggest difficulty is getting all languages in sync. While you are developing new stuff you already need new translations, while the team responsible for it is doing the previous ones. Unit testing with translations is also tricky. iOS Localizable.strings file is so much worse than the strings file in Android. A wrong key and your app doesn't display what is supposed to."
        case 4:
            text = "Ideally one has some continuous integration process going on, with very high test coverage, for both app and backend. One click rollbacks. Staging environments agains which the app is tested automatically and by QA. The reality is that this does not happens everywhere.\n\nHowever, server side changes and staged rollouts could be a good alternative to avoid releasing an app that has flaws to thousands of customers at the same time. Maybe Apple should have done that with iOS 13. If an issue is detected, then all users go back to the last working version, the issue gets fixed, and only a small subset of users get affected hopefully. As a last alternative, something that we use currently is an under construction flag, which we set to true when the app is basically unusable, because it is less bad to display an under maintenance screen than to show errors all over the place."
        default: break
        }
        
        return Answer.Response(text: text)
    }
}
