//
//  Constant.swift
//  JAIBK
//
//  Created by Atta khan on 28/03/2022.
//

import Foundation
class Constant {
    
}

extension Constant {
    static let baseURL = "https://jaibk.gcc-demo.com/"
    class ServiceConstant {
        // MARK: - PROPERTIES
        static let GET_SESSION_ID           =   "gatSessionId"
        static let HOME                     =   "Home"
        static let CATEGORIES               =   "getCategories"
        static let SUB_CATEGORIES           =   "getSubCategories"
        static let PRODUCT_BY_SUB_CATEGORIES           =   "getProductFilterByPrice"
        static let DROPDOWN_OPTIONS         =   "getGarageDropdowns"
        static let CAR_MAINTANCE            =   "getCarMaintanence"
        static let CAR_MAINTANCE_DETAIL     =   "getCarMaintanenceByDetail"
        static let SIGN_UP                  =   "signUp"
        static let LOGIN                    =   "signIn"
        static let LOGOUT                   =   "Logout"
        static let FORGOT_PASSWORD          =   "forgetPassword"
        static let BLOG                     =   "Blogs"
        static let BLOG_DETAIL              =   "BlogDetail"
        static let ORDER_LIST               =   "UserOrders"
        static let ORDER_DETAIL             =   "OrderDetail"
        
        
        static let ADD_ENQUIRE              =   "AddEnquiry"
        static let ENQUIRE                  =   "GetProductEnquiries"
        static let ENQUIRE_DETAIL           =   "GetProductEnquiriesDetial"
        
        
        static let ADD_GARAGE               =   "AddGarage"
        static let GARAGE                   =   "GetGarage"
        static let UPDATE_GARAGE            =   "EditGarage"
        static let DELETE_GARAGE            =   "DeleteGarage"
        
        
        
        static let ADD_PAYMENT               =   "AddPayment"
        static let PAYMENT                   =   "GetPayment"
        static let UPDATE_PAYMENT            =   "EditPayment"
        static let DELETE_PAYMENT            =   "DeletePayment"
        
        static let ADD_ADDRESS               =   "AddAdress"
        static let ADDRESS                   =   "GetAddAdress"
        static let UPDATE_ADDRESS            =   "EditAddress"
        static let DELETE_ADDRESS            =   "DeleteAddress"
        static let GET_ALL_COUNTRY           =   "getAllCountry"
        static let GET_CITY                  =   "getCity"
        
        static let ADD_WISHLIST             =   "addToWishlist"
        static let WISHLIST                 =   "wishlist"
        static let DELETE_WISHLIST          =   "deleteToWishlist"
        
        static let ADD_CART                 =   "addToCart"
        static let CART                     =   "cart"
        static let UPDATE_CART              =   "updateCart"
        static let DELETE_CART              =   "deleteCart"
        
        static let PRODUCT_DETAIL           =   "getProductDetail"
        static let SEARCH_BY_CAR            =   "SearchByCar"
        static let SEARCH_BY_VIN            =   "getProductFilterByVinNumber"
        static let ADD_REVIEW               =   "ProductReview"
        
    }
}
