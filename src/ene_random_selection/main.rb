module Eneroth::RandomSelection

  @@original_selection = []

  def self.read_selection
    model = Sketchup.active_model
    @@original_selection =
      model.selection.empty? ? model.active_entities.to_a : model.selection.to_a

    nil
  end

  def self.shuffle
    @@original_selection.shuffle!

    nil
  end

  def self.make_selection(percentage = 0.5)
    selection = Sketchup.active_model.selection
    selection.clear
    end_index = ((@@original_selection.size-1)*percentage).round
    selection.add(@@original_selection[0..end_index])

    selection.size
  end

  # For now call methods from console.

end
