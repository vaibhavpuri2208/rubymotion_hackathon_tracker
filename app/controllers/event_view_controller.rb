class EventViewController < UIViewController


  def init
    super
    self
  end


  def viewDidLoad
    super
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.backgroundColor= UIColor.whiteColor
    @map_view_for_event = mapViewForEvent
    regionForEventLocation
    self.view.addSubview @map_view_for_event
    self.view.addSubview addTitleLabel
    self.view.addSubview addInfoText

  end

  def loadData(event_info)
    @event_info = event_info

  end


  def mapViewForEvent
    map_view_for_event = MKMapView.alloc.initWithFrame([[25,50], [270, 180]])
    map_view_for_event.mapType= MKMapTypeStandard
    map_view_for_event
  end

  def addTitleLabel
    label_title = UILabel.alloc.initWithFrame([[25,10], [270, 50]])
    label_title.text = "Location" #@event_info[:where]
    label_title.backgroundColor = UIColor.clearColor
    label_title.adjustsFontSizeToFitWidth= true
    label_title.textColor=UIColor.redColor
    label_title.font = UIFont.fontWithName('Helvetica', size:18)
    label_title
  end

  def addInfoText

    label_info = UILabel.alloc.initWithFrame([[25,200], [270, 120]])
    label_info.text = @event_info[:info]
    label_info.backgroundColor = UIColor.clearColor
    label_info.font = UIFont.fontWithName('Arial', size:14)

    label_info.adjustsFontSizeToFitWidth= true
    label_info.textColor=UIColor.blackColor
    label_info.textAlignment= UITextAlignmentLeft
    label_info

  end


  def regionForEventLocation
    completion_block =  lambda do |placemark, error|
      latitude = placemark[0].location.coordinate.latitude
      longitude= placemark[0].location.coordinate.longitude
      coordinates = CLLocationCoordinate2DMake(latitude,longitude)
      region = MKCoordinateRegionMake(coordinates, MKCoordinateSpanMake(0.7, 0.7))
      @map_view_for_event.setRegion region

    end

    CLGeocoder.alloc.init.geocodeAddressString(@event_info[:where], completionHandler: completion_block)

    end



end