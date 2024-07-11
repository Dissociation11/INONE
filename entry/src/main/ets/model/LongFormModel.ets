export interface LongFormModel{
  videoUrl : string
  imageUrl : string
  title : string
  description : string
  author : string
  
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
]