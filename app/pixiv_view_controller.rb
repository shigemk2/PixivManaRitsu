# -*- coding: utf-8 -*-
class PixivViewController < UITableViewController
  def viewDidLoad
    super

    @feed = nil
    @items = []
    self.navigationItem.title = "Pixiv ManaRitsu Reader"
    self.view.backgroundColor = UIColor.whiteColor

    url = "http://spapi.pixiv.net/iphone/search.php?s_mode=s_tag&word=%E3%83%9E%E3%83%8A%E3%82%8A%E3%81%A4&PHPSESSID=0"

    BW::HTTP.get(url) do |response|
      if response.ok?
        @feed = response.body.to_str
        lines = @feed.split("\n")
        for row in lines
          @items << row.split(",")
        end
        view.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    if @items.nil?
      return 0
    else
      @items.size
    end
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    40
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('cell') || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'cell')
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    label = UILabel.alloc.init
    label.frame = CGRectMake(40, 20, 200, 30)
    label.font = UIFont.fontWithName("AppleGothic",size:14)
    # user
    label.text = @items[indexPath.row][5]
    label.textAlignment = UITextAlignmentLeft
    cell.addSubview(label)

    # thumbnail
    image_path = @items[indexPath.row][6].gsub(/\"/, "")
    image_src = NSData.dataWithContentsOfURL(NSURL.URLWithString(image_path))
    image = UIImage.imageWithData(image_src)

    image_view = UIImageView.alloc.initWithImage(image)
    image_view.frame = CGRectMake(5, 5, 30, 30)
    cell.addSubview(image_view)
    return cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    WebViewController.new.tap do |c|
      c.item = @items[indexPath.row]
      self.navigationController.pushViewController(c, animated:true)
    end
  end
end
