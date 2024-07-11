/*
 * 请求体实体
 * code : 响应码
 * status : 响应信息
 * data : 响应数据
 * count : 返回的数量
 * */

export class LongFormResponse{
  private _code: number|undefined
  
  public set code(value: number|undefined) {
    this._code = value
  }

  public get code(): number|undefined {
    return this._code
  }

  private _data: LongFormData[]|undefined

  public set data(value: LongFormData[]|undefined) {
    this._data = value
  }

  public get data(): LongFormData[]|undefined {
    return this._data
  }

  private _message: string|undefined

  public set message(value: string|undefined) {
    this._message = value
  }

  public get message(): string|undefined {
    return this._message
  }

  constructor(code: number|undefined, data: LongFormData[]|undefined, message: string|undefined) {
    this._code = code
    this._data = data
    this._message = message
  }
  
}
export class LongFormData{
  private _author: string|undefined
  private _title: string | undefined

  public set title(value: string | undefined) {
    this._title = value
  }

  public get title(): string | undefined {
    return this._title
  }
  
  public set author(value: string|undefined) {
    this._author = value
  }

  public get author(): string|undefined {
    return this._author
  }

  private _description: string|undefined

  public set description(value: string|undefined) {
    this._description = value
  }

  public get description(): string|undefined {
    return this._description
  }

  private _imageUrl: string|undefined

  public set imageUrl(value: string|undefined) {
    this._imageUrl = value
  }

  public get imageUrl(): string|undefined {
    return this._imageUrl
  }

  private _url: string|undefined

  public set url(value: string|undefined) {
    this._url = value
  }

  public get url(): string|undefined {
    return this._url
  }

  constructor(author: string | undefined, title: string | undefined, description: string | undefined,
    imageUrl: string | undefined, url: string | undefined) {
    this._author = author
    this._title = title
    this._description = description
    this._imageUrl = imageUrl
    this._url = url
  }

}

