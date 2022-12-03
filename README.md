# APOD
iOS Application Implementing APOD API of NASA

## Features
- Users can search Astronomy picture of the day for a date of their choice
- Users can create/manage a list of Favorites
- Users can see title, date, explanation and the image/video of the day
- Users can see searched APODs & favorited APODs offline 
- Application has 3 Screens APOD screen, Favorites screen & Favorites - details screen
- APOD Screen: Users can search & view Astronomy picture of the day for a date of their choice & mark/remove it as Favorite
- Favorites Screen: Users can view & remove Favorites
- Favorites Details Screen: Users can view details of selected Favorite
- Users can play video for video Media Type, from APOD screen & Favorites - details screen by tapping play button
- Application supports Dark mode
- Application handles different screen sizes, orientations

## Architecture
- Application uses MVVM architecture

## Storage
- CoreData is used in the application to store the response
- Images are stored in the disk

## Unit Tests
- Unit Tests are added for the Modules - APOD, Favorites & Favorites - Details

## Deployment Target
- iOS 15.5

## Development Tools used
- Xcode 13.4.1
- Swift 5

## Screenshots

### iPhone Dark Mode
<p float="left">
<img src="https://user-images.githubusercontent.com/29563042/205435043-dff6ddc4-59ce-404d-8d21-f02fdbb77831.png" width="414" height="896">
<img src="https://user-images.githubusercontent.com/29563042/205435048-2f224e12-f4f1-4a95-8385-a8d8f133b013.png" width="414" height="896">
<img src="https://user-images.githubusercontent.com/29563042/205435051-f7595a8e-8641-4037-b6ab-4eecb0ce1eb3.png" width="414" height="896">
<img src="https://user-images.githubusercontent.com/29563042/205435054-53070876-0932-4be0-822c-1a4762e2294d.png" width="414" height="896">
<img src="https://user-images.githubusercontent.com/29563042/205435056-6316fcc9-ba75-44e4-8274-50ba4d898ca1.png" width="414" height="896">
</p>
<p float="left">
<img src="https://user-images.githubusercontent.com/29563042/205435057-47257d91-dab9-433a-94f4-ab4aba9efe09.png" width="896" height="414">
<img src="https://user-images.githubusercontent.com/29563042/205435059-8f29b001-c923-4b38-b2dd-4948facc8d09.png" width="896" height="414">
<img src="https://user-images.githubusercontent.com/29563042/205435060-00514e3d-cc94-4660-ba09-abba38a2abff.png" width="896" height="414">
</p>
  
### iPad Light Mode
<p float="left">
<img src="https://user-images.githubusercontent.com/29563042/205435315-a99ab575-629e-4246-9cea-8432452b8859.png" width="420" height="560">
<img src="https://user-images.githubusercontent.com/29563042/205435317-458d54a5-65b9-410f-9b89-f4d1a5acc2fd.png" width="420" height="560">
<img src="https://user-images.githubusercontent.com/29563042/205435320-6c69890b-d8bf-4500-8650-0f4a84ec7670.png" width="420" height="560">
<img src="https://user-images.githubusercontent.com/29563042/205435323-4f521032-701d-43a7-a977-f2d51a075271.png" width="420" height="560">
<img src="https://user-images.githubusercontent.com/29563042/205435324-72ee7359-5270-494f-a12e-901185527ee7.png" width="420" height="560">
</p>
<p float="left">
<img src="https://user-images.githubusercontent.com/29563042/205435325-cecf212d-a65d-430e-ac80-066e4c39681f.png" width="560" height="420">
<img src="https://user-images.githubusercontent.com/29563042/205435326-0176cb70-f822-431b-9dcf-6d130abdc4f3.png" width="560" height="420">
<img src="https://user-images.githubusercontent.com/29563042/205435328-ad996b27-c147-4b86-9a17-f525f7b5266b.png" width="560" height="420">
</p>
