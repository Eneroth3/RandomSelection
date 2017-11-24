#-------------------------------------------------------------------------------
#
#    Author: Julia Christina Eneroth (eneroth3@gmail.com)
# Copyright: Copyright (c) 2017
#   License: MIT
#
#-------------------------------------------------------------------------------

require "sketchup.rb"
require "extensions.rb"

module Eneroth
  module RandomSelection

    PLUGIN_ID = File.basename(__FILE__, ".rb")
    PLUGIN_DIR = File.join(File.dirname(__FILE__), PLUGIN_ID)

    EXTENSION = SketchupExtension.new(
      "Eneroth Random",
      File.join(PLUGIN_DIR, "main")
    )
    EXTENSION.creator     = "Julia Christina Eneroth"
    EXTENSION.description =
      "Randomly shrink selection to given percentage."\
      "Can be used to introduce variety in model."
    EXTENSION.version     = "1.0.0"
    EXTENSION.copyright   = "#{EXTENSION.creator} 2017"
    Sketchup.register_extension(EXTENSION, true)

  end
end
