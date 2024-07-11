import { http } from '@kit.NetworkKit'
import { RequestTool } from '../commons/utils/RequestTool'
import { LongFormData, LongFormResponse } from './LongFormResponse'

export interface LongFormModel{
  videoUrl : string
  imageUrl : string // 封面
  title : string
  description : string
  author : string
  
}
export class LongForm implements LongFormModel {
  videoUrl: string
  imageUrl: string
  title: string
  description: string
  author: string
  constructor(videoUrl: string, imageUrl: string, title: string, description: string, author: string) {
    this.videoUrl = videoUrl
    this.imageUrl = imageUrl
    this.title = title
    this.description = description
    this.author = author
  }

  async getLongFormList(){
    let longFromResults : LongFormModel[] = []
    await RequestTool.request("http://192.168.31.46:8800/admin/sysUser/getVideoList",http.RequestMethod.GET)
      .then((res)=>{
        let resResponse:LongFormResponse = res as LongFormResponse
        
        if (resResponse.data!==undefined) {
          for (let index = 0; index < resResponse.data.length; index++) {
            const element = resResponse.data[index];
            let longFromResult : LongFormModel = new LongForm(element.url as string,element.imageUrl as string,element.title as string,element.description as string,element.author as string)
            longFromResults.push(longFromResult)
          }
        }
        console.log(`longFromResults : LongFormModel[] = ${JSON.stringify(longFromResults)}`)
        return longFromResults
      })
      .catch((err:Error)=>{
        console.log(`err:${err.message}`)
      })
    console.log(`longFromResults : LongFormModel[] = ${JSON.stringify(longFromResults)}`)
    return longFromResults
  }
}
export const LongFormModelList : LongFormModel[] = [
  {
    videoUrl : "c.mp4",
    imageUrl: "app.media.test",
    title : "海洋生物",
    description : "讲述了海洋的生物",
    author : "张三"
  },
  {
    videoUrl : "horse.mp4",
    imageUrl: "app.media.test",
    title : "TED经典演讲",
    description : "讲述了TED的演讲",
    author : "王五"
  },
  {
    videoUrl : "sea.mp4",
    imageUrl: "app.media.test",
    title : "沙漠旅途",
    description : "讲述了一个人的沙漠之旅",
    author : "李四"
  },
  {
    videoUrl : "http://121.199.75.7:8086/WeChat_20240612195719.mp4",
    imageUrl: "app.media.test",
    title : "网络视频测试",
    description : "这是一个网络视频",
    author : "李四"
  },
]

export default new LongForm("","","","","")