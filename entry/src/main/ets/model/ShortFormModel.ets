
// 短视频实体
export interface ShortFormModel{
  videoUrl : string
  title : string
  description : string
  author : string
  like_num: number
  share_num :number
}

// export const ShortFormModelList : ShortFormModel[] = [
//   {
//     videoUrl : "http://vjs.zencdn.net/v/oceans.mp4",
//     title : "海洋生物",
//     description : "讲述了海洋的生物",
//     author : "张三"
//   },
//   {
//     videoUrl : "http://mirror.aarnet.edu.au/pub/TED-talks/911Mothers_2010W-480p.mp4",
//     title : "TED经典演讲",
//     description : "讲述了TED的演讲",
//     author : "王五"
//   },
//   {
//     videoUrl : "https://media.w3.org/2010/05/sintel/trailer.mp4",
//     title : "沙漠旅途",
//     description : "讲述了一个人的沙漠之旅",
//     author : "李四"
//   },
// ]

export const ShortFormModelList : ShortFormModel[] = [
  {
    videoUrl : "c.mp4",
    title : "海洋生物",
    description : "讲述了海洋的生物",
    author : "张三",
    like_num: 666,
    share_num: 888
  },
  {
    videoUrl : "horse.mp4",
    title : "TED经典演讲",
    description : "讲述了TED的演讲",
    author : "王五",
    like_num: 666,
    share_num: 888
  },
  {
    videoUrl : "sea.mp4",
    title : "沙漠旅途",
    description : "讲述了一个人的沙漠之旅",
    author : "李四",
    like_num: 666,
    share_num: 888
  },
]