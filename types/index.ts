
import { Injectable } from '@angular/core';
import { Cordova, Plugin, IonicNativePlugin } from '@ionic-native/core';


enum DocumentPickerOptions {
  PDF = 'pdf',
  IMAGE = 'image',
  ALL = 'all'
}


/**
 * @name DocumentPicker
 * @description 
 */
@Plugin({
  pluginName: 'DocumentPicker',
  plugin: 'cordova-plugin-documentpicker.DocumentPicker',
  pluginRef: 'DocumentPicker',
  repo: 'https://github.com/iampossible/Cordova-DocPicker',
  platforms: ['iOS']
})
@Injectable()
export class DocumentPicker extends IonicNativePlugin {

  @Cordova()
  getFile(options?: DocumentPickerOptions): Promise<string> { return; }

}