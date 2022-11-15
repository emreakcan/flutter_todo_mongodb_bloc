# Fluttur TODO app using MongoDB + Dart as backend.


## How to run?
To run this app you will need MongoDB setup on your local as remote api has not been deployed to any server, works only locally, pointing to local mongo setup.

## UI : 
BLoC pattern used for the UI, as it is suitable for most of the apps, makes testing easier and handling states is more managable. App synces local database with remote database so it will be usable offlice aswell.


# Handling users : 
Every install gets a unique id, and that id will be saved with the todo so that multiple users can use the app and can't see other's todo's. It is clear on the video how it is architectured. App supports multiple users without login. 

## Backend : 
Dart and MongoDB used for Backend, Mongo's non-relational document model is easy to use for simple TODO app. There can be many other choices but that was the quickest way I could see. Simple tests written for Backend more to come if I can find some time.

Shelf package used for structing the backend, it handles most of the boilerplate part of writing a web server. Can mix and match synchronous and asynchronous processing, and it is very flexible.




https://user-images.githubusercontent.com/29652273/202029874-ab9150e7-f392-4a97-8dbd-5a4a62748c99.mov

