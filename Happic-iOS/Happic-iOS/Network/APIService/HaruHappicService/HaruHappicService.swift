//
//  HaruHappicService.swift
//  Happic-iOS
//
//  Created by devxsby on 2022/07/21.
//

import Foundation
import Alamofire

struct HaruHappicService {
    static let shared = HaruHappicService()
    
    private init() {}
    
    // MARK: - 하루해픽 사진 뷰 전체 조회
    func getHaruHappicPhotoView(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.haruHappicPhotoURL
        let header: HTTPHeaders = ["Content-Type": "application/json", "x-auth-token": "jwt token"]
        let parameters: Parameters = [
            "year": year,
            "month": month
        ]
        
        let dataRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = NetworkHelper.parseJSON(by: statusCode, data: value, type: [HaruHappicPhotoModel].self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
