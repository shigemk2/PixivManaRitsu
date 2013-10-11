class WebViewController < UIViewController
  attr_accessor :item

  def viewDidLoad
    super
    self.navigationItem.title = self.item[3]
    @webview = UIWebView.new.tap do |v|
      scrollwindow = UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      scrollwindow.scrollEnabled = true
      scrollwindow.delegate = self

      v.frame = self.view.bounds
      v.scalesPageToFit = true
      url = self.item[9].gsub(/\"/, "") # image
      image_src = NSData.dataWithContentsOfURL(NSURL.URLWithString(url))
      image = UIImage.imageWithData(image_src)

      image_view = UIImageView.alloc.initWithImage(image)
      image_view.frame = CGRectMake(0, 100, 320, 320)
      scrollwindow.addSubview(image_view)
      scrollwindow.contentSize = image_view.size
      v.delegate = self
      view.addSubview(scrollwindow)

      # v.loadHTMLString(self.item["body"], baseURL:nil)
    end
  end
end
