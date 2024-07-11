import PreferenceUtil from '../commons/utils/preferenceUtil'
import { PreferenceConstant } from '../commons/constants/PreferenceConstant'


export class UserViewModel{

  //用户是否登录
  isLogin : boolean = false

  initViewModel(){
    PreferenceUtil.hasKey(PreferenceConstant.ISLOGIN).then((isExist) => {
      if(isExist){
        PreferenceUtil.getPreferenceValue(PreferenceConstant.ISLOGIN, false).then((value) => {
          this.isLogin = value as boolean
          console.info(`info: isLogin is ${value.toString()}`)
        })
      }else{
        PreferenceUtil.putPreferenceValue(PreferenceConstant.ISLOGIN,false)
        console.info('info: create isLogin preference')
      }
    })
  }

  Login(){
    this.isLogin = !this.isLogin
    console.debug(`debug: ${this.isLogin}`)
    PreferenceUtil.putPreferenceValue(PreferenceConstant.ISLOGIN,this.isLogin)
  }

}

const userModel : UserViewModel = new UserViewModel()
export default userModel