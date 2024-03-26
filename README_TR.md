# GriddyCode
Kodlamak hiç bu kadar eğlenceli olmamıştı!


https://github.com/face-hh/griddycode/assets/69168154/df93830e-6e24-472d-a854-cea026b12890

Not: Editörün hızlı bir sunumu için `CTRL` + `I` yapın :)


# Table of Contents
   - [Gereksinimler](#Gereksinimler)
   - [Lua modlama](#%EF%B8%8F-Lua-Modlama)
	  - [Nerede?](#Nerede)
	  - [Nasıl?](#Nasıl)
	  - [Dökümanlar](#Dökümanlar)
		 - [Diller](#Diller)
			- [Giriş](#Giriş)
			- [Yöntemler](#Yöntemler)
		 - [Temalar](#Temalar)
			- [Giriş](#Giriş-1)
			- [Yöntemler](#Yöntemler-1)
	  - [Yayınlama](#Yayınlama)
   - [Katkıda Bulunma](#Katkıda-Bulunma)
	  - [Mevcut hatalar/gerekli özellikler](#-Mevcut-hatalargerekli-özellikler)
	  	- [HIGH PRIORITY](#high-priority)
		- [MEDIUM PRIORITY](#medium-priority)
		- [LOW PRIORITY](#low-priority)

# Gereksinimler
| Gereksinim | Notlar |
| -------- | -------- |
| [Nerdfont](https://www.nerdfonts.com/) - Dosya seçici için Nerdfont kullanıyoruz. | Simgelerin "□" gibi göründüğünde eksik olduğunu bileceksin |
| [Linux](https://en.wikipedia.org/wiki/List_of_Linux_distributions) - GriddyCode **sadece** Linux'ta test edilmişti | Gaming OS'te çalışsa bile dosya seçici çalışmayabilir. |
# ⌨️ Lua modlama
GriddyCode, **Lua** ile fonksiyonunu genişletmene izin verir.

## Nerede?
Lua betikleriyle klasör açmak için:

- Windows: `%APPDATA%\Godot\app_userdata\Bussin GriddyCode`
- macOS: `~/Library/Application Support/Bussin GriddyCode`
- Linux: `~/.local/share/godot/app_userdata/Bussin GriddyCode`
klasörüne gidin.

*Not: yollar birebir doğru değil, işletim sisteminizdeki AppData'da GriddyCode'u elle bulmanızı öneririz.*

## Nasıl?
**"langs"** ve  **"themes"** adlı klasörler görebilirsiniz.
- **"langs"** GriddyCode'un sözdizimi vurgulamasını ve otomatik tamamlamasını destekleyen bir grup `.lua` dosyasını barındırır.
- **"themes"** GriddyCode'un görünümünü değiştiren bir grup `.lua` dosyasını barındırır.

*Not: Lua komut dosyaları yalnızca farklı bir dosya uzantısından geçiş yaptığınızda (ör. "README.md" -> "main.ts") veya GriddyCode yeniden başlatıldığında yeniden yüklenir.*

## Dökümanlar?
### Diller
#### Giriş
GriddyCode'un belir bir **dosya uzantısı** için fonksiyonelliğini artırmak için, kendi adında bir dosya oluşturun. (örneğin, `toml.lua`)

#### Yöntemler

| Yöntem | Örnek | Açıklama | Notlar |
| -------- | -------- | -------- | -------- |
| `highlight(keyword: String, color: String)` | `highlight("const", "reserved")` | Tells GriddyCode to highlight a certain keyword with a preset of colors. | Available colors: `reserved`, `annotation`, `string`, `binary`, `symbol`, `variable`, `operator`, `comments`, `error`, `function`, `member` |
| `highlight_region(start: String, end: String, color: String, line_only: bool = false)` | `highlight("/*", "*/", "comments", false)` | Tells GriddyCode to highlight a region with a preset of colors. | The `start` must be a symbol. Due to Godot's limited functionality, you can't use RegEx. |
| `add_comment(comment: String)` | `add_comment("What is blud doing 🗣️🗣️🗣️")` | Adds a comment to be randomly chosen in the `CTRL` + `L` menu. | The username, profile picture, date, and likes are chosen by GriddyCode. |
| `detect_functions(content: String, line: int, column: int) -> Array[String]` | `detect_functions("const test = 3; function main() {}; async init() => { main() }")` | Called by GriddyCode upon input. Results are showed in the autocomplete feature. | This must be provided by the Lua script. It must return an array of strings (i.e. ["main", "init"]). "line" and "column" are the position of the cursor when the autocomplete was requested. |
| `detect_variables(content: String, line: int, column: int) -> Array[String]` | `detect_variables("const test = 3;")` | Called by GriddyCode upon input. Results are showed in the autocomplete feature. | This must be provided by the Lua script. It must return an array of strings (i.e. ["test"]). "line" and "column" are the position of the cursor when the autocomplete was requested. |

*Note: to provide reserved variables/functions (i.e. `Math`/`parseInt()` in JS) you can have them already set up in the array you return. GriddyCode will handle the rest!*

### Temalar
#### Giriş
Tema ekleme için, **"themes"** klasörü içinde herhangi bir adla bir dosya oluşturun. (örneğin, "dracula.lua"). GriddyCode ile onu seçebileceksiniz.

#### Yöntemler
| Yöntem | Örnek | Açıklama | Notlar |
| -------- | -------- | -------- | -------- |
| `set_keywords(property: String, new_color: String)` | `set_keywords("reserved", "#ff00ff")` | Sözdizimi önizlemesinin rengini ayarlar. | İkinci argüman bir hex olmalıdır, `#` işareti isteğe bağlıdır. Mevcut renkler/seçenekler yukarıda `langs` ta belirtilmiştir. |
| `set_gui(property: String, new_color: String)` | `set_gui("background_color", "#ff00ff")` | Bu yöntem GriddyCode'un genel GUI yönünde adanmıştır. | Mevcut seçenekler: `background_color`, `current_line_color`, `selection_color`, `font_color`, `word_highlighted_color`, `selection_background_color`. "background_color" dışındaki özellikler, sağlanmadığı takdirde "background_color"un biraz değiştirilmiş bir sürümüne ayarlanacaktır. Mümkün olmasına rağmen bunlara güvenmenizi ve bunun yerine tüm değerleri ayarlamanızı önermiyoruz. |

*Note: Eğer girdiğin HEX hatalıysa, Varsayılan olarak #ff0000 (kırmızı)'ya dönecek.*

## Yayınlama
Eğer eklentinizi/temanızı **kendiniz** için kullanmak istiyorsanız, [AppData](#where)'nızın içine koyabilirsiniz.

Eğer bir tema/eklenti **göndermek** istiyorsanız, saygılı bir biçimde `Lua/Plugins` veya `Lua/Themes` içine eklemek için çekme isteği açın. Eğer birleştirilirse, bir sonraki yapıda dahil edilecektir.

# Katkıda Bulunma
Katkılarınız çok önemlidir, ister Lua eklentileri, temalar, Lua'ya daha fazla özelliği güvenli bir biçimde sunmak, veya doğrudan GriddyCode'a özellik eklemek olsun!

## Hatırlatma
- Yaptığınız değişiklikleri çalıştırmak ve kusursuz çalıştığından emin olmak için [Godot Engine'i](https://godotengine.org/) kurmanız gerek.
- Çalıştırılabilir dosyaları göndermek zorunda değilsiniz.
- Motorun 4.2. sürümünü kullanın (şu an ki en son sürüm)

## 🐛 Mevcut hatalar/gerekli özellikler:
### HIGH PRIORITY
- The `VHS & CRT` shader, on certain themes (One Dark Pro, GitHub Light, etc.), becomes completely white. Works good on GitHub Dark;
- Light modes get affected by *glow*, while dark modes seem fine.

### MEDIUM PRIORITY
- An option in the settings menu (`CTRL` + `,`) to change the font;
- The current limit for lines is ~1600. If the cursor moves past that amount, the `CodeEdit` node will activate its scrolling, making the camera bug & go out of view. A limit should be implemented so that the camera won't go out of screen.

### LOW PRIORITY
- Making the cat jumping video in the settings menu fade in/out along the actual menu. Currently it ignores the transition;
- `CTRL` + `P` to open a **quick file picker**, similar to [VSCode](https://code.visualstudio.com/docs/editor/editingevolved#:~:text=Quick%20file%20navigation,-Tip%3A%20You%20can&text=VS%20Code%20provides%20two%20powerful,release%20Ctrl%20to%20open%20it.).
- Selecting a setting with the property "shader" *should* disable previously-enabled settings with "shader".
- The `CheckButton` node for each `setting` scene doesn't change with the theme. This affects light themes specifically.

Please note that creating a Pull Request to fix these features does *not* guarantee its merge. Please don't open a Pull Request unless you are confident you've done a good job.
