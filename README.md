# NetworkLayer

![NetworkManager](https://user-images.githubusercontent.com/29178012/203470867-f3e8a263-a32d-4a9c-9ea6-1cb20036c4c4.svg)

A simple network request class with URL Session & Combine framework to get, post, put, and delete data on the server in swift language.

## How to use NetworkRequest.swift

Create NetworkManager.swift class instance in your ViewControler.swift class. 

```bash
  let networkManager = NetworkManager()
  var subscriptions = Set<AnyCancellable>()
```

Create your URL request and call request method with your URL request.
```bash
   let request = CountryRequest()
   networkManager.request(request)
      .sink { (completion) in
          switch completion {
              case .failure(let error):
                  print("Error: \(error.localizedDescription)")
              case .finished:
                  print("Finished")
              }
        } receiveValue: { (countries) in
           print("Number of countries - \(countries.count) countries")
        }
        .store(in: &subscriptions)
```

