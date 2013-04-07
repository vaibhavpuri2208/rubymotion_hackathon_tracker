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
    self.view.addSubview @map_view_for_event
    self.view.addSubview addTitleLabel
    self.view.addSubview addInfoText

  end

  def loadData(event_info)
    @event_info = event_info

  end

  def requestUserCurrentLocation

    if (CLLocationManager.locationServicesEnabled)
      @location_manager = CLLocationManager.alloc.init

      @location_manager.desiredAccuracy= KCLLocationAccuracyKilometer

      @location_manager.delegate= self

      @location_manager.purpose = "Locate Hackathons for uoi"
      @location_manager.startUpdatingLocation
    else
      showAlertWithTitle('Location Error', 'Please Enable the Location Services for this app in the Settings section')

    end

  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)


  end

  def locationManager(manager, didFailWithError:error)
    showAlertWithTitle("Error", andMessage:error.description)
  end

  def mapViewForEvent
    map_view_for_event = MKMapView.alloc.initWithFrame([[25,50], [270, 180]])
    map_view_for_event.mapType= MKMapTypeStandard
    map_view_for_event
  end

  def addTitleLabel
    label_title = UILabel.alloc.initWithFrame([[25,-55], [200, 180]])
    label_title.text = "Hack Location" #@event_info[:where]
    label_title.backgroundColor = UIColor.clearColor
    label_title.adjustsFontSizeToFitWidth= true
    label_title.textColor=UIColor.blackColor
    #label_title.font = UIFont.fontWithName('Helvetica', size:24)
    label_title
  end

  def addInfoText

    label_info = UILabel.alloc.initWithFrame([[25,150], [200, 180]])
    label_info.text = @event_info[:info]
    label_info.backgroundColor = UIColor.clearColor
    label_info.adjustsFontSizeToFitWidth= true
    label_info.textColor=UIColor.blackColor
    label_info.font = UIFont.fontWithName('Helvetica', size:48)
    label_info

  end


end