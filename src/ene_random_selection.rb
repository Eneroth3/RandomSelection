require "sketchup.rb"
require "extensions.rb"

module Eneroth
  module RandomSelection

    PLUGIN_ID = File.basename(__FILE__, ".rb")
    PLUGIN_DIR = File.join(File.dirname(__FILE__), PLUGIN_ID)

    EXTENSION = SketchupExtension.new(
      "Eneroth Random Selection",
      File.join(PLUGIN_DIR, "main")
    )
    EXTENSION.creator     = "Julia Christina Eneroth"
    EXTENSION.description =
      "Randomly select objects. Can be used to create variety."
    EXTENSION.version     = "1.0.1"
    EXTENSION.copyright   = "#{EXTENSION.creator} 2020"
    Sketchup.register_extension(EXTENSION, true)

  end
end
