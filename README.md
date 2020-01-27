# Cordova-DocPicker
iOS plugin for Cordova written in Swift.

Opens the file picker on iOS for the user to select a file, returns a file URI.
Allows the user to upload files from icloud.

# Installation
Navigate to your project directory and install the plugin with `cordova plugin add https://github.com/iampossible/Cordova-DocPicker.git` or `npm i cordova-documentpicker`.

# Methods
There is only one method available all return promises, or accept success and error callbacks.

- `DocumentPicker.getFile`


# Usage

## DocumentPicker.getFile

### Typescript

```typescript
import { DocumentPicker, DocumentPickerOptions } from '@ionic-native/document-picker';

constructor(private docPicker: DocumentPicker) { }

...

this.docPicker.getFile(DocumentPickerOptions.ALL) // DocumentPickerOptions.IMAGE and DocumentPickerOptions.PDF are also available
.then(uri => console.log(uri))
.catch(e => console.log(e));

```

### Javascript

```javascript 

/// Fetchs for all types of documents
DocumentPicker.getFile('all', (url) => { console.log(url) }, (error) => { console.log(error) }

/// Fetchs only for image and pdf file types
DocumentPicker.getFile(['image', 'pdf'], (url) => { console.log(url) }, (error) => { console.log(error) }

/// Fetchs only for images
DocumentPicker.getFile('image', (url) => { console.log(url) }, (error) => { console.log(error) }

```

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iampossible/Cordova-DocPicker.