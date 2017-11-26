module Eneroth::RandomSelection

  @@initial_selection = []
  @@percentage = 1.0
  @@dialog = nil

  def self.set_percentage(percentage)
    @@percentage = percentage
  end

  def self.get_percentage
    @@percentage
  end

  def self.read_initial_selection
    model = Sketchup.active_model
    @@initial_selection =
      model.selection.empty? ? model.active_entities.to_a : model.selection.to_a

    shuffle

    nil
  end

  def self.shuffle
    @@initial_selection.shuffle!

    nil
  end

  def self.make_selection
    # Active context may have changed since intial selection was last read,
    # rendering it invalid.
    ensure_valid_initial_selection

    selection = Sketchup.active_model.selection
    selection.clear
    qty = (@@initial_selection.size*@@percentage).round
    selection.add(@@initial_selection[0..qty-1]) unless qty == 0

    selection.size
  end

  def self.valid_initial_selection?
    return false if @@initial_selection.empty?
    return false unless Sketchup.active_model.active_entities.include?(@@initial_selection.first)

    true
  end

  def self.ensure_valid_initial_selection
    read_initial_selection unless valid_initial_selection?

    nil
  end

  def self.create_dialog
    dialog = UI::HtmlDialog.new(
      dialog_title: EXTENSION.name,
      preferences_key: PLUGIN_ID,
      style: UI::HtmlDialog::STYLE_DIALOG
    )
    dialog.set_url(File.join(PLUGIN_DIR, "dialog.html"))
    dialog.center

    dialog
  end

  def self.display_dialog
    read_initial_selection
    @@percentage = 1.0
    make_selection

    if @@dialog && @@dialog.visible?
      @@dialog.bring_to_front
    else
      @@dialog ||= create_dialog
      @@dialog.add_action_callback("shuffle") { |_|
        shuffle
        make_selection
      }
      @@dialog.add_action_callback("set_percentage") { |_, percentage|
        set_percentage(percentage.to_f)
        make_selection
      }
      @@dialog.show
    end

    # TODO: Set values in web dialog fields.

    nil
  end

  unless(file_loaded?(__FILE__))
    file_loaded(__FILE__)
    menu = UI.menu("Plugins")
    menu.add_item(EXTENSION.name) { display_dialog }
  end

end
