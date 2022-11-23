# NetworkLayer

![NetworkManager](https://user-images.githubusercontent.com/29178012/194690933-33ca0c70-e670-4051-8815-4a55e36854d5.svg)

A simple network request class with URL Session & Combine framework to get, post, put, and delete data on the server in swift language.

## How to use NetworkRequest.swift

Create NetworkRequest.swift class instance in your ViewControler.swift class. 

```bash
  let networkRequest = NetworkRequest()
  var subscriptions = Set<AnyCancellable>()
```

Create your URL request and call request method with your URL request.
```bash
  let request = CountryRequest()
        networkRequest.dataRequest(request)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    print("Do your stuff here.")
                }
            } receiveValue: { (countries) in
                print("Number of countries - \(countries.count) countries")
            }
            .store(in: &subscriptions)
```

