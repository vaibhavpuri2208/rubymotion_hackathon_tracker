class CityTableViewController < UITableViewController
  def viewDidLoad
    super

    #Dispatch::Queue.concurrent(:high).async {

        BubbleWrap::HTTP.get("http://localhost:3000/hackathons.json") do |response|
          @hack_list = BubbleWrap::JSON.parse response.body.to_str
          self.view.reloadData

        end


=begin

        hack_list = File.read("#{App.resources_path}/hacks.json")
        @hack_list = BW::JSON.parse(hack_list).map do |list|
          l = list.dup
          l[:hacks] = l[:hacks].dup
          l
        end
=end

#    self.view.reloadData
    #}
    navigationItem.title= 'City'
  end

  def viewDidUnload
    super

  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    @hack_list ? 1: 0
  end


  #def tableView(tableView, titleForHeaderInSection:section)
  #  @hack_list[section][:city]
  #end

  def tableView(tableView, numberOfRowsInSection:section)
    @hack_list.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) ||begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
      cell
    end

    hack = @hack_list[indexPath.row]
    hack_city = hack[:city]
    cell.textLabel.text = hack_city
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
    cell
  end


## Table view delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    events_controller = EventsTableViewController.alloc.init
    city_set = @hack_list[indexPath.row]
    events_controller.bind_with_events(city_set)
    self.navigationController.pushViewController(events_controller, animated:true)
  end
end
