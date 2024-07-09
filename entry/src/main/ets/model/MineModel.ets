
//我的页面功能栏
export interface MineItem{

  mode : MineItemMode;

  icon : Resource;

  name : Resource;

}

export enum MineItemMode{

  //听视频
  Radio,

  //客服
  Help,

  //设置
  Setting,

  //卡通
  Cartoon,

  //公益
  Commonweal,

  //社区
  community,

  //游戏
  Game,

  //直播
  Live,

  //青少年守护
  Teenage
}

//主要服务推荐
export const MineMainItemInfo : MineItem[] = [
  {
    mode : MineItemMode.Cartoon,
    icon : $r("app.media.cartoon"),
    name : $r("app.string.Cartoon")
  },
  {
    mode : MineItemMode.Commonweal,
    icon : $r("app.media.commonweal"),
    name : $r("app.string.Commonweal")
  },
  {
    mode : MineItemMode.community,
    icon : $r("app.media.community"),
    name : $r("app.string.Community")
  },
  {
    mode : MineItemMode.Game,
    icon : $r("app.media.game"),
    name : $r("app.string.Game")
  },
  {
    mode : MineItemMode.Live,
    icon : $r("app.media.live"),
    name : $r("app.string.Live")
  },
  {
    mode : MineItemMode.Teenage,
    icon : $r("app.media.teenage"),
    name : $r("app.string.Teenage")
  }
]

//更多服务推荐
export const MineMoreItemInfo : MineItem[] = [
  {
    mode : MineItemMode.Radio,
    icon : $r("app.media.radio"),
    name : $r("app.string.Radio")
  },
  {
    mode : MineItemMode.Help,
    icon : $r("app.media.help"),
    name : $r("app.string.Help")
  },
  {
    mode : MineItemMode.Setting,
    icon : $r("app.media.setting"),
    name : $r("app.string.Setting")
  }
]

