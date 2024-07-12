import { MineItem, MineMainItemInfo, MineMoreItemInfo } from '../model/MineModel';
import  router  from '@ohos.router';

export class MineViewModel{

  MineMoreItemList : MineItem[] = MineMoreItemInfo;

  MineMainItemList : MineItem[] = MineMainItemInfo;

  toLogin(){
    router.pushUrl({
      url: 'pages/LoginPage'
    })
  }

  toInformation(){
    router.pushUrl({
      url: 'pages/UserInformationPage'
    })
  }

}

export default new MineViewModel()