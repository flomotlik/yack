Yack ![Railsonfire Status for flomotlik/yack](https://railsonfire-dev.heroku.com/projects/48d5cb30-3ba5-012f-d8f0-123139181d2d/status)
===

Yack (Yet another callback kit) is a library to create simple callbacks for your Hashes. It is especially useful when loading config files. Instead of pulling the values out of the config file you simply add callbacks and when the attributes exist in the Hash a code block is run.

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
      //value is "TestString"
    end

and start the processing

    yack.process(YAML.load(YOUR_YAML_FILE))

Your Code block will be called with the value of the attribute which in the last example would be "TestString".

As it processes Hashes directly you can use JSON, Yaml or any other format that can be represented by a Hash. Currently only on callback can be registered for a specific point in the hash.

If you want your code block to handle a child hash this is also possible by only adding a callback for the parent

    yack.parent do |value|
      //value is {:test => "TestString"}
    end

Will be called with {:test => "TestString"} considering the example before.

If you want to add callbacks for several child attributes simply add several callbacks

        ---
    :parent:
      :child1: 1
      :child2: 2

The following code blocks will be called with the correct attributes:

    yack.parent.child1 do |value|
      //value is 1
    end

    yack.parent.child2 do |value|
      //value is 2
    end

License
-------

Copyright (c) 2012 Florian Motlik.

Released under the MIT license. See `LICENSE` for details.
