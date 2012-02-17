Yack
===

Yack is a library to create simple callbacks for loading your Yaml files. It is especially useful when loading config files. Instead of pulling the values out of the config file you simply add callbacks and when the attributes exist in the file a code block is run.

Installation
------------

    gem install yack

Usage
-----
Consider you have the following YAML File

    ---
    :parent:
      :child: "TestString"

Simply create a new callback object

    yack = Yack::Callback.new

then simply add some callbacks

    yack.parent.child do |value|
      puts value
    end

and start the processing

    yack.process_yaml(YAML_STRING)

Your Code block will be called with the value of the attribute which in the last example would be "TestString".

License
-------

Copyright (c) 2012 Florian Motlik.

Released under the MIT license. See `LICENSE` for details.
