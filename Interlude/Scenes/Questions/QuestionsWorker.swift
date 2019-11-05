//
//  QuestionsWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol QuestionsWorkerProtocol {
    func fetchQuestions() -> Questions.Response
}

final class QuestionsWorker: QuestionsWorkerProtocol {
    func fetchQuestions() -> Questions.Response {
        let questions = [
            "1. How would you implement asynchronous data downloading, saving and presenting to UI? What are the main difficulties?",
            "2. How would you deal with 10s or 100s of thousands of different objects to synchronise with offline storage? What are the main difficulties?",
            "3. How would you optimise a UICollectionView (for iOS) or RecyclerView (for Android) which hosts lots of different items with complicated UI and clearly stutters when scrolling? Elaborate on your decisions.",
            """
            4. Imagine that you are developing multi-language app that supports 40 languages. Describe how you will:

            a) Design UI to be responsive to language change.
            b) Organise translation file managing and coordination between app and translators.
            c) Test localisation quality.
            d) What other possible difficulties you can imagine to be present in this situation?
            """,
            "5. How could you prevent features in release builds breaking live releases and how could you react to this, when it happens?"
        ]
        return Questions.Response(questions: questions)
    }
}
