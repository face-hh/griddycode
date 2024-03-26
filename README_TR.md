# GriddyCode
Kodlamak hiç bu kadar eğlenceli olmamıştı!


https://github.com/face-hh/griddycode/assets/69168154/df93830e-6e24-472d-a854-cea026b12890

Not: Editörün hızlı bir sunumu için `CTRL` + `I` yapın :)


# Tablo İçeriği
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
	  	- [YÜKSEK ÖNCELİKLİ](#YÜKSEK-ÖNCELİKLİ)
		- [ORTA ÖNCELİKLİ](#ORTA-ÖNCELİKLİ)
		- [DÜŞÜK ÖNCELİKLİ](#DÜŞÜK-ÖNCELİKLİ)

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
| `highlight(keyword: String, color: String)` | `highlight("const", "reserved")` | GriddyCode'a bir anahtar kelimeyi öntanımlı renklerle öne çıkarmasını söyler. | Mevcut renkler: `reserved`, `annotation`, `string`, `binary`, `symbol`, `variable`, `operator`, `comments`, `error`, `function`, `member` |
| `highlight_region(start: String, end: String, color: String, line_only: bool = false)` | `highlight("/*", "*/", "comments", false)` | GriddyCode'a bir ülkeyi öntanımlı renklerle öne çıkarmasını söyler. | `start` bir sembol olmalıdır. Godot'un sınırlı işlevselliği nedeniyle, RegEX kullanamazsınız. |
| `add_comment(comment: String)` | `add_comment("What is blud doing 🗣️🗣️🗣️")` |`CTRL` + `L` menüsünde rastgele seçilebilmesi için bir yorum ekler. | Kullanıcı adı, profil resmi, tarih ve beğeniler GriddyCode tarafından seçilir. |
| `detect_functions(content: String, line: int, column: int) -> Array[String]` | `detect_functions("const test = 3; function main() {}; async init() => { main() }")` | Giriş üzerine GriddyCode tarafından çağrılır. Sonuçlar otomatik tamamlama özelliğinde gösterilir. | Bu, Lua betiği tarafından sağlanmalıdır. Bir dizi string döndürmelidir (yani ["main", "init"]). "satır" ve "sütun", otomatik tamamlama istendiğinde imlecin konumudur. |
| `detect_variables(content: String, line: int, column: int) -> Array[String]` | `detect_variables("const test = 3;")` | Giriş üzerine GriddyCode tarafından çağrılır. Sonuçlar otomatik tamamlama özelliğinde gösterilir. | Bu, Lua betiği tarafından sağlanmalıdır. Bir dizi string döndürmelidir (yani ["test"]). "satır" ve "sütun", otomatik tamamlama istendiğinde imlecin konumudur. |

*Not: ayrılmış değişkenler/fonksiyonlar sağlamak için (örn. `Math`/`parseInt()` JS'de) döndürdüğünüz dizide bunları zaten ayarlamış olabilirsiniz. Gerisini GriddyCode halledecektir!*
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
### YÜKSEK ÖNCELİKLİ
- `VHS & CRT` gölgelendirici, belirli temalarda (One Dark Pro, GitHub Light, vb.) tamamen beyaz olur. GitHub Dark üzerinde iyi çalışıyor;
- Açık modlar *glow*'dan etkilenirken, karanlık modlar iyi görünüyor.

### ORTA ÖNCELİKLİ
- Ayarlar menüsündeki bir seçenek (`CTRL` + `,`) yazı tipini değiştirmek için;
- Satırlar için geçerli sınır ~1600'dür. İmleç bu miktarı geçerse, `CodeEdit` düğümü kaydırmayı etkinleştirecek ve kamera bug & görünümden çıkacaktır. Kameranın ekranın dışına çıkmaması için bir sınır uygulanmalıdır.
  
### DÜŞÜK ÖNCELİKLİ
- Ayarlar menüsündeki kedi zıplama videosunun gerçek menü boyunca soluklaşmasını / kapanmasını sağlamak. Şu anda geçişi yok sayıyor;
- `CTRL` + `P` açmak için bir **hızlı dosya seçici**, [VSCode](https://code.visualstudio.com/docs/editor/editingevolved#:~:text=Quick%20file%20navigation,-Tip%3A%20You%20can&text=VS%20Code%20provides%20two%20powerful,release%20Ctrl%20to%20open%20it.).
- "shader" *özelliğine sahip bir ayarın seçilmesi* "shader" ile önceden etkinleştirilmiş ayarları devre dışı bırakmalıdır.
- Her bir `CheckButton` düğümü için `setting` sahnesi tema ile değişmez. Bu özellikle hafif temaları etkiler.

Lütfen bu özellikleri düzeltmek için bir Çekme İsteği oluşturmanın birleştirilmesini garanti **etmediğini** unutmayın. Lütfen iyi bir iş çıkardığınızdan emin olmadıkça bir Çekme İsteği açmayın.
