import { preferences } from '@kit.ArkData'
import { PreferenceConstant } from '../constants/PreferenceConstant'

//用户首选项工具类
class PreferenceUtil{

  private pref : preferences.Preferences | null = null


  //初始化用户首选项
  async loadPreference(context: Context){
    try{
      this.pref = await preferences.getPreferences(context, PreferenceConstant.PREFERENCE_NAME)
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 初始化完成`)
    }catch(err){
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 初始化失败`)
      console.error('err: ', JSON.stringify(err))
    }
  }

  //删除用户首选项
  async deletePreference(context: Context){
    try{
      await preferences.deletePreferences(context, PreferenceConstant.PREFERENCE_NAME)
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 销毁成功`)
    }catch(err){
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 销毁失败`)
      console.error('err: ', JSON.stringify(err))
    }
  }

  //获取存储在用户首选项中的key-value
  async getPreferenceValue(key: string, defaultValue: preferences.ValueType): Promise<preferences.ValueType>{
    let value: preferences.ValueType = defaultValue
    if(!this.pref){
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 未初始化`)
      return value
    }
    try{
      value = await this.pref.get(key,defaultValue)
      console.log(`读取 [${key} = ${value}] 成功`)
    }catch(err){
      console.error(`读取preferences[${key}]失败 `, JSON.stringify(err))
    }
    return value
  }

  //向用户首选项中添加key-value
  async putPreferenceValue(key: string, value: preferences.ValueType){
    if(!this.pref){
      console.log(`${PreferenceConstant.PREFERENCE_NAME} 为初始化`)
      return
    }
    try{
      await this.pref.put(key,value)
      await this.pref.flush()
      console.log(`保存preferences[${key} = ${value}]成功`)
    }catch(err){
      console.error(`保存preferences[${key} = ${value}]失败`, JSON.stringify(err))
    }
  }

}

const preferenceUtil : PreferenceUtil = new PreferenceUtil()
export default preferenceUtil as PreferenceUtil