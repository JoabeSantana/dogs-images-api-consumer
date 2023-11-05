# UIKit App to consume The Dog Api - MVC

A UIKit iOS project using MVC design pattern to show images of dog breeds and their information.

Project format: Xcode 14.0

To run this App you need to get a valid x-api-key key from https://www.thedogapi.com/signup and replace the content in the DogService class:

request.allHTTPHeaderFields = [
    "x-api-key": "your-valid-x-api-key"
]

For information about the API you can follow these links:

https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=8FfZAkNzs
https://documenter.getpostman.com/view/5578104/2s935hRnak
