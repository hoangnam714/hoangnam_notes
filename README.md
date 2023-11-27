# hoangnam_notes
- The application is written on the MVVM model, writing on this model is easy to maintain and redesign.
  
## Available functions:
```
[x] Create Account
[x] Login
[x] Create notes
[x] See note detail
[x] See your own notes
[x] See other people's notes
[x] logout
```
## Flow application
```
* Login screen:
     - User opens the application and sees the login screen.
     - They enter their login information or can register a new account
    - After successfully logging in, the user goes to the main screen displaying a list of notes.
     - You can see the title and short description of the note.
* Choose A Note:
     - Displays the content of the note, including name and description
* Create notes:
     - User enters name and description of note.
     - After entering the note name and content, press the create note button to create a new note.
* Return to Main Screen:
     - Users will see their newly created article here.
* Settings screen:
     - Users can view their basic information.
     - If desired, users can log out of their account

```

## XCTest: Available UI tester case

## Time line: 
- 1 hour to come up with UI design ideas
- 5 hours to code UI/UX and fix bugs
- 2 hours to write XCTest

## Improve
* Add advanced functions such as
  - forgot password, change password
  - edit notes
  - edit user profile
* Edit UI/UX to be more user-friendly and eye-catching
  
## Hard:
I still lack experience writing unit tests, in the future I will improve this skill
