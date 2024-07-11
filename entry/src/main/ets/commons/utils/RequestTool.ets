import { http } from '@kit.NetworkKit';
import { ValueType } from '@kit.ArkData';
import { LongFormResponse} from '../../model/LongFormResponse';

export class RequestTool{
  static request(url: string, method: http.RequestMethod, requestData?: object): Promise<LongFormResponse>{
    let httpRequest = http.createHttp()
    console.log(`start to request `)
    
    let responseResult = httpRequest.request(
      url,
      {
        method: method,
        header: {
          'Content-Type': 'application/json'
        },
        //携带额外参数
        extraData: requestData,
        //可选，默认为60000ms
        connectTimeout: 60000,
        readTimeout: 60000,
      }
    )
    let response = new LongFormResponse(undefined,undefined,undefined);
    //处理数据，并返回
    return responseResult.then((value: http.HttpResponse) => {
      let responseData : LongFormResponse = value.result as LongFormResponse
      console.log(`request value : ${responseData}`)
      if (value.responseCode === 200) {
        //获取返回数据,将返回的json数据解析成事先预定好的响应格式
        //这里建议和后端的保持一致
        console.log(`result::${value.result}`)
        let res: LongFormResponse = JSON.parse(`${value.result}`);
        console.log("res:",JSON.stringify(value.result))
        response.data = res.data;
        response.code = res.code;
        response.message = res.message
      }else {
        response.message = '请求错误';
        response.code = 400;
      }
      console.log("response",JSON.stringify(response))
      return response;
    }).catch((err:Error) => {
      console.log(`request error : ${err.message}`)
      response.message = '请求错误';
      response.code = 400;
      return response;
    })
  }
}