import Foundation

protocol RequestExecuter {
    func execute(with urlRquest: URLRequest, completion: @escaping (Result<Data, NetworkPlataformError>) -> Void)
}

final class RequestExecuterImp: RequestExecuter {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute(
        with urlRquest: URLRequest,
        completion: @escaping (Result<Data, NetworkPlataformError>) -> Void) {

            urlSession.dataTask(with: urlRquest) { data, urlResponse, error in
                if let error = error {
                    let errorParsed = NetworkPlataformErrorParser()
                        .parse(error: error)
                    
                    completion(.failure(errorParsed))
                     return
                }
                 
                 guard let urlResponse = urlResponse else {
                     completion(.failure(.unkown))
                     return
                 }
                 
                 if let errorFromURLResponse = URLResponseErrorParser()
                     .parseErrorIfExists(on: urlResponse) {
                         
                     completion(.failure(errorFromURLResponse))
                     return
                 }
                 
                guard let data = data else {
                    completion(.failure(.unkown))
                    return
                }
                 
                completion(.success(data))
           }.resume()
    }
}
