/// 頂點類
/// @author vae

class Vertex1 {

  String label;
  bool wasVisited = false;
  Vertex1(this.label);

}

/*
①、頂點：
在大多數情況下，頂點表示某個真實世界的物件，這個物件必須用資料項來描述。比如在一個飛機航線模擬程式中，頂點表示城市，
那麼它需要儲存城市的名字、海拔高度、地理位置和其它相關資訊，因此通常用一個頂點類的物件來表示一個頂點，這裡我們僅僅在頂點中儲存了一個字母來標識頂點，
同時還有一個標誌位，用來判斷該頂點有沒有被存取過（用於後面的搜尋）。
頂點物件能放在陣列中，然後用下標指示，也可以放在連結串列或其它資料結構中，不論使用什麼結構，儲存只是為了使用方便，這與邊如何連線點是沒有關係的。
 */