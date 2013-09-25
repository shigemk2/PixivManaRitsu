class WebViewController < UIViewController
  attr_accessor :item

  def viewDidLoad
    super
    self.navigationItem.title = self.item[3]
    @webview = UIWebView.new.tap do |v|
      v.frame = self.view.bounds
      v.scalesPageToFit = true
      url = self.item[9].gsub(/\"/, "") # image
      image_src = NSData.dataWithContentsOfURL(NSURL.URLWithString(url))
      image = UIImage.imageWithData(image_src)

      # alert = UIAlertView.new
      # alert.message = "#{image.size.height}"
      # alert.addButtonWithTitle 'OK'
      # alert.show

      image_view = UIImageView.alloc.initWithImage(image)
      image_view.frame = CGRectMake(0, 100, 320, 320)
      v.delegate = self
      view.addSubview(image_view)

      # v.loadHTMLString(self.item["body"], baseURL:nil)
    end
  end
end
