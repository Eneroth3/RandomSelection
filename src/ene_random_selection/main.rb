module Eneroth::RandomSelection

  @@initial_selection = []

  def self.read_initial_selection
    model = Sketchup.active_model
    @@initial_selection =
      model.selection.empty? ? model.active_entities.to_a : model.selection.to_a

    nil
  end

  def self.shuffle
    @@initial_selection.shuffle!

    nil
  end

  def self.make_selection(percentage = 0.5)
    # Active context may have changed since intial selection was last read,
    # rendering it invalid.
    ensure_valid_initial_selection

    selection = Sketchup.active_model.selection
    selection.clear
    end_index = ((@@initial_selection.size-1)*percentage).round
    selection.add(@@initial_selection[0..end_index])

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

  # For now call methods from console.

end
