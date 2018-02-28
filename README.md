## Easy App

An app that lets you search for taxis (fake api) based on user location, search for an address and know the nearest taxi.

This app was created as an test.

![overview](./Design/astronomer-overview.png)

### Architectural overview

This app is most based on MVVM-C pattern. But, there are elements from many different patterns.

#### Coordinator

The coordinator handles all presentation of controllers and navigation.

#### Controllers

Controllers are responsible for set and configure its views and implementing protocols (delegates, datasources, others).

#### View Models

View models wrap the models and expose useful information that can be used by views and view controllers to present the model's information on screen. They are also responsible for implementing diffing between models.

#### Models

The models are structs that parse data and return it as list of models.

#### EasyAPI

The EasyAPI client handle requests and return an dictionary containing the data and an optional  `Error` object.

#### TaxiServices

TaxiServices is responsable for making a request to the fake api `http://quasinada-ryu.easytaxi.net.br/api/gettaxis/` and return a list of objects (`Taxis`)

#### Unit tests

For this project, are beign tested View Models, Requests (using Mock) and data parser.

#### Dependencies (cocoapods)

This project use only GoogleMaps SDK and GooglePlaces SDK.


## How to build

Tested on Xcode 9.2, macOS 10.13.3.

### Clone the repository

```
$ git clone https://github.com/lucasanovaes/Easy.git
$ cd ./Easy/Easy
$ pod install

```
