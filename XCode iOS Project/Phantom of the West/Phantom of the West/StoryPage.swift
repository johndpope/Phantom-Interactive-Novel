//
//  StoryPage.swift
//  Phantom of the West
//
//  Created by Christopher Raleigh on 2015/08/18.
//  Copyright (c) 2015 Christopher Raleigh. All rights reserved.
//

import UIKit

/*
A concrete implementation of PStoryPage
*/
class StoryPage: PStoryPage {
    
    private static let storyImagesBundle = NSBundle(path: "StoryImages")
    
    private static let storyTextTable = "StoryText"
    
    /*
    Creates a language-localized page from "StoryText.strings".
    */
    /*static func createLocalizedPage(list: StoryPageList, image: UIImage, stringKeys: [String]) -> StoryPage {
        let localizedText = getLocalizedText(stringKeys)
        let newPage = StoryPage(list: list, image: image, text: localizedText)
        return newPage
    }*/
    
    /*
    Creates a language-localized string from "StoryImages.xcassets".
    */
    static func getLocalizedImage(name: String) -> UIImage {
        let localizedImage = UIImage(named: name, inBundle: storyImagesBundle, compatibleWithTraitCollection: nil)
        return localizedImage!
    }
    
    /*
    Creates a language-localized string from "StoryText.strings".
    */
    static func getLocalizedText(stringKeys: [String]) -> String {
        var localizedText = ""
        var firstString = true
        for k in stringKeys {
            if !firstString {
                localizedText += "\n\n"
            }
            let kValue = NSLocalizedString(k, tableName: storyTextTable, comment: "")
            localizedText += kValue
            firstString = false
        }
        return localizedText
    }
    
    /*
    The page image.
    */
    private(set) var image: UIImage
    
    /*
    The page text.
    */
    private(set) var text: String
    
    /*
    The pages to load after selecting OK.
    */
    private var nextPages: [PStoryPage]
    
    /*
    Flags used to control story branching.
    */
    private var eventFlags: EventFlagsCollection
    
    /*
    The observer.
    */
    private var observer: PStoryObserver
    
    init(image: String, text: [String], nextPages: [PStoryPage], observer: PStoryObserver, eventFlags: EventFlagsCollection) {
        self.image = StoryPage.getLocalizedImage(image)
        self.text = StoryPage.getLocalizedText(text)
        self.nextPages = nextPages
        self.observer = observer
        self.eventFlags = eventFlags
    }
    
    /*
    Continues the story from this page.
    */
    func continueStory() {
        observer.update(nextPages)
    }
}