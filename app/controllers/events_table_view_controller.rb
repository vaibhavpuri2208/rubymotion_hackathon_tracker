class EventsTableViewController < UITableViewController
  def viewDidLoad
    super
    self
  end

  def viewDidUnload
    super

  end

  def bind_with_events(city_set)
    @hack_data = city_set
    self.navigationItem.title= @hack_data[:city]
    parse_display_data
    view.reloadData
  end


  def parse_display_data   #return a hash with value array for each event
    @month = Hash.new
    @hack_data[:hacks].each do |line_item|
     active_month=return_month line_item[:date]
      if !@month.has_key?(active_month)
       @month[active_month] = Array.new
      end
     @month[active_month] << line_item[:name]

    end
    @month
  end


  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
     @month.keys.length

  end

  def tableView(tableView, numberOfRowsInSection:section)
    key = @month.keys[section]
    @month[key].length

  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    return add_cell if indexPath.row == @hack_data[:hacks].length
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) ||begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
      cell
    end

    key = @month.keys[indexPath.section]
    hack_event = @month[key][indexPath.row]
    cell.textLabel.text = hack_event
    cell
  end

  def add_cell
    cellIdentifier = "new_event"
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cellIdentifier)
      left_padding = 40
      padding = 10

      @input = UITextField.alloc.initWithFrame([[left_padding, padding],[cell.size.width - left_padding - padding, cell.size.height - (padding * 2)]])
      @input.borderStyle = UITextBorderStyleRoundedRect
      cell.addSubview(@input)

      cell
    end

    @input.text = ''
    @input.placeholder = "new book"

    cell
  end

  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    if indexPath.row == @hack_data[:hacks].length
      UITableViewCellEditingStyleInsert
    else
      UITableViewCellEditingStyleNone
    end

  end

  def setEditing(isEditing, animated:animated)
    super(isEditing, animated:animated)

    last_index_path = [NSIndexPath.indexPathForRow(@hack_data[:hacks].length, inSection:0)]

    if isEditing

      tableView.insertRowsAtIndexPaths(last_index_path, withRowAnimation:UITableViewRowAnimationBottom)
    else
      tableView.deleteRowsAtIndexPaths(last_index_path, withRowAnimation:UITableViewRowAnimationBottom)
      if (@input && @input.text != '')
        @hack_data[:hacks] << @input.text
        view.reloadData
      end
    end
  end


## Table view delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    selected_event = EventViewController.alloc.init
    event_info = @hack_data["hacks"][indexPath.row]
    selected_event.loadData(event_info)
    self.navigationController.pushViewController(selected_event, animated:true)

  end



  def tableView(tableView, titleForHeaderInSection:section)
    @month.keys[section]
  end

  def return_month(date)
    month = date.slice(5,2)
    month = case month
      when "01"
        "Jan"
      when "02"
        "Feb"
      when "03"
        "March"
      when "04"
        "April"
      when "05"
        "May"
      when "06"
        "June"
      when "07"
        "July"
      when "08"
        "Aug"
      when "09"
        "Sept"
      when "10"
        "Oct"
      when "11"
         "Nov"
      when "12"
          "Dec"
    end

  end







end
