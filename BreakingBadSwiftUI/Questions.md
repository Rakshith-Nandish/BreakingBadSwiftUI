
The app has been designed to have a modular structure
1) The UI
2) Domain
3) Data

The data layer consists of the blue print for all data obtained from the server.
No business logic is present here.
Services are defined to obatain the required data.
The domain layer in this project has not been defined due to lack of time.
All services are accessed only through interfaces, no concrete implementation is used directly. This lets us plug and play the concrete services and allows for easy testing, which can be observed in the 'CharacterDetailViewInteractorTests' test file.
The Interactor is responsible for obtainig the data through services and applying any business logic to it.
The interactor has its required dependencies injected, again it is only aware of the interface and not concrete implementation.

1) What (if any) further additions would you like to make to your submission if you had
more time?
Answer: 
    1) I was unable to add a local repository due to time constraints, but the idea would be to have a layer that is responsible for providing the data. This layer would interact with a local repository and the api server to fetch any data which is not available locally and store it. It would also update the local repository to reflect user liking or disliking a character. As we have interfaces between these layers, each would not communicate through a concrete implementation, but only through interfaces. By doing this we can test both these layers easily. 
    2) The view can be further divided into individual components which can be build using @ViewBuilder, this way we can reuse the components.
    
    
2) Is there anything you would change about your current implementation?
Answer: Yes, I feel the following can be improvements
    1) As of now the view and interactor are tightly coupled, SwiftUI makes it challenging to use a protocol oriented style between these two elements. UIKit allowed for this and both these elements were loosely coupled. I would want to explore further how we can decouple these two elements further.
    2) In terms of navigation, I have always used the coordinator pattern to encapsulate the logic for coordination and using configrators to setup viewmodel and view controller. This is challending to achieve in SwiftUI given how we now treat the UI and its business logic. In this assignment, I have encapsulated the navigation in the Route, however I would like to further explore how this can be used to align more closely with the coordinator pattern. 
    3) The Network manager, I feel can be further broken down to accept a Request.
    4) I was unable to handle errors in this assignment, although the setup has been done in the interactor to handle the error, it has to be communicated to the view.
    5) The domain and data layers can be further implemented as seperate modules
