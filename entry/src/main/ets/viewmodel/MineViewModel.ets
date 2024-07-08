import { MineItem, MineMainItemInfo, MineMoreItemInfo } from '../model/MineModel';

export class MineViewModel{

  MineMoreItemList : MineItem[] = MineMoreItemInfo;

  MineMainItemList : MineItem[] = MineMainItemInfo;

  //用户是否登录
  isLogin : boolean = false

}

export default new MineViewModel()