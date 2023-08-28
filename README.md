# NetworkLayer

![NetworkManager](https://github.com/InderJagdeo/NetworkManager-With-Combine/assets/29178012/16dee0f1-c521-4ff4-8743-4db18c3a030a)


A simple network manager class with URL Session & Combine framework to get, post, put, and delete data on the server in swift language.

## How to use NetworkManager.swift

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

