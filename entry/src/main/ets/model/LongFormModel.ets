import { http } from '@kit.NetworkKit'
import { RequestTool } from '../commons/utils/RequestTool'
import { LongFormData, LongFormResponse } from './LongFormResponse'

export interface LongFormModel{
  videoUrl : string
  imageUrl : string // 封面
  title : string
  description : string
  author : string
  like_num: number
  share_num :number
  id: number
}

export class LongForm implements LongFormModel {
  videoUrl: string
  imageUrl: string
  title: string
  description: string
  author: string
  like_num: number
  share_num :number
  id: number
  
  constructor(videoUrl: string, imageUrl: string, title: string, description: string, author: string, like_num: number,
    share_num: number, id: number) {
    this.videoUrl = videoUrl
    this.imageUrl = imageUrl
    this.title = title
    this.description = description
    this.author = author
    this.like_num = like_num
    this.share_num = share_num
    this.id = id
  }

  
  

  async getLongFormList(){
    let longFromResults : LongFormModel[] = []
    await RequestTool.request("http://10.33.34.177:8800/admin/sysUser/getVideoList",http.RequestMethod.GET)
      .then((res)=>{
        let resResponse:LongFormResponse = res as LongFormResponse
        
        if (resResponse.data!==undefined) {
          for (let index = 0; index < resResponse.data.length; index++) {
            const element = resResponse.data[index];
            let longFromResult : LongFormModel = new LongForm(element.url as string,element.imageUrl as string,element.title as string,element.description as string,element.author as string,element.like_num,element.share_num,element.id)
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
    author : "张三",
    like_num: 666,
    share_num: 888,
    id:1
  },
  {
    videoUrl : "horse.mp4",
    imageUrl: "app.media.test",
    title : "TED经典演讲",
    description : "讲述了TED的演讲",
    author : "王五",
    like_num: 666,
    share_num: 888,
    id:2
  },
  {
    videoUrl : "sea.mp4",
    imageUrl: "app.media.test",
    title : "沙漠旅途",
    description : "讲述了一个人的沙漠之旅",
    author : "李四",
    like_num: 666,
    share_num: 888,
    id:3
  },
  {
    videoUrl : "http://121.199.75.7:8086/WeChat_20240612195719.mp4",
    imageUrl: "app.media.test",
    title : "网络视频测试",
    description : "这是一个网络视频",
    author : "李四",
    like_num: 666,
    share_num: 888,
    id:4
  },
]

export default new LongForm("","","","","",0,0,0)