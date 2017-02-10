//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088221565252725"
//收款支付宝账号
#define SellerID  @"yunyingbu@intelet.net"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"zgot1kbk8tt5r3lzq4h2wlwrldng8swh"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANE0PFGU6Nyo3T0BGB0DP3nNGMk6B+wU/O/0lS1ZKhE/DhZrLhE/R5QbONrzAiUIzs6NB4j5EAl923kwFEPSBW+bY8fzlXUNZfpbFNmld7AtboFbFIdpM12Xe654eptDpd+tPgYIieaHltBwX2RgxIh9oH9pL3AUdsNpK+MjZM1jAgMBAAECgYA70VbJ8O0gYvxXfB+b9BjLR/SlXP106I9mQSYCgHNB2Si7CkxyzAg4dgwstr1PP5R6hOK5rJWEUUNXBINW3Q+GVBS6sN92DPiVDMz1LqphJrMz8Jrwb70bD9BZ2WbaTnZbS/SxvpC9yJrTyG4ktrrEJBsXiCHWv6e4PgioGd4dcQJBAP5yRzUnRUym4LIOjFzk/tyld4LqgUS6IKP5aEBlxwO7jtREdpnttyvAWoF7M/2CRtZ7EO9p2YmW5NrB0hdO3EkCQQDSez1fHPULUKzepTJ/rNtLucwcg3baXfWH4Q+zM5W0JpDOQ7Ra6t6djdvl4DmqX4xT3QuGAeCRCwNnghhV0CRLAkEA0vlmWYhKSZhEzt6JO60UNVdtlLtkm9vInK1754l8TngBobdyr4cPTdOcN6g0H4sZuVUpYZneqdrXvxreXD0jIQJBAIom6flsAEsVAOKCe8rhom7p3Nc6UuCxm188khmFWlWMmq9IMTEbyFKRsiwIKNFzNaA2DkI/KS8Kk4l1EpQAslECQQDhrsrMYMiJEeVOzOmZ6/ylXQ1lHKw4O6T7fZz988DkKmAEX5pwr1Gz7YU9zUKqSc2bre8Rfo/KdA2cEar0hDAH"


//支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
