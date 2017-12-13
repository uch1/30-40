//
//  psuedocode.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 11/23/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

//import Foundation
/*
 Psuedocode:
 HomeScreenVC:
 - if play button is pressed, segue to the gameLoadVC
 - if learn button is pressed, segue to the learnAboutVC
 GameScreenVC:
 - WHILE the cards (person face and name) are loaded (not nil):
     SET the timer to 30 seconds then substract 1 second from the timer
     IF the card changes (person/user swipes to the right):
         ADD 5 sec (extra time) to the timer
         STOP adding 5 sec once it's the last card
             SET extra time to 0 seconds
     IFEnd
  WHILEEnd
 
 - IF the user presses the READY button:
     *Segue to the next view controller.
     *Use a delegate to send the person card(names and pictures) to GamePlayVC
     *Images should populate a imageview of the collectionview cell
     *names should be in box field
 SET the timer to 40 seconds
 Once the use selects a name, check IF the name matches the image:
 IF the name is in the {name: image}:
 
 GameScreenVC:
 - Make a get request to retrieve the photos and names CHECK
 - Populate the UI Cell elements with the parsed json CHECK
 - Reduced the size of the populated collection view cell to 5 cells at a time
 - Create a timer that countdown from 30 seconds
 - Delegate the data to another viewcontroller *USING A PROTOCOL
    - or use an array to store the data (Person Card) and access it in another view controller
 
     LearnAboutVC:
 
 GamePlayVC:
 - Implement a Tinder like swipe to guess the face and name.
  - Check if the guess what right
    - Show Right!!!!
  - Else
    - Show Not Right!!
 - Use Timer that countdowns from 40 seconds
    - Once the timer goes to zero. Game should stop.
 - Pass the data of right and wrong guesses the result VC
 
 -- Get a random picture of a person by index path
 -- Get a random Name based on index
 -- Match the actual name with random name
 ResultVC:
 - show the results
    (1) need a label to display wrong guesses
    (2) need a label for displaying right guesses
 
 - use the play again button to start over
    (1) once tapped, the play again button
        will send a user to gamescreenVC
 - use the quit button to end the game
    (1) once tapped, the quit button will
        send the user to the homescreenVC
 
 
 
 
 
 
 
 
 
*/
