# hash_walker

[![Build
Status](https://secure.travis-ci.org/lloydmeta/hash_walker.png)](http://travis-ci.org/lloydmeta/hash_walker)

A simple gem that allows you to traverse/walk a Hash (perhaps obtained from doing JSON::parse on a JSON string) according to a set of keys (also a hash), passing in a block to perform actions. This method will yield your block with each value found and the Hash 'path' of the value (as an array) as arguments.

__Note__ This gem was built on Ruby 1.9.3, but Travis testing tells me its 1.9.2 compatible as well. Your mileage may vary...

## Installing

Add to your `Gemfile`:

```ruby
    gem 'hash_walker'
```

Where you want to use the method on your hashes:

```ruby
    require 'hash_walker'
```

## Usage

```ruby
    require 'hash_walker'

    my_hash = {
        "a_array" => [1,2,3,4,5],
        "b_hash" => {
            "b_value_string" => 'b value as string',
            "b_value_int" => 420,
            "b_value_bool" => true,
            "b_value_float" => 4.20,
            "b_inner_array" => [
                {
                    "content" => 'b_inner_array content 1',
                    "b_inner_array_unneeded" => "don't read me!"
                },
                {
                    "content" => 'b_inner_array content 2',
                    "b_inner_array_unneeded" => "don't read me! 2"
                },
                {
                    "content" => 'b_inner_array content 3',
                    "b_inner_array_unneeded" => "don't read me! 3"
                },
                {
                    "content" => 'b_inner_array content 4',
                    "b_inner_array_unneeded" => "don't read me! 3",
                    "b_inner_array_inner_hash" => {
                        "content" => "really, really hidden...",
                        "inner_array" => [3.14159,  2.71828]
                    }
                }
            ]
        }
    }

    keys_to_read = [
        "a_array",
        "b_hash" => [
            "b_value_string",
            "b_value_int",
            "b_value_bool",
            "b_value_float",
            {"b_inner_array" => [
                "content",
                {"b_inner_array_inner_hash" => [
                    "content",
                    "inner_array"
                ]}
            ]}
        ]
    ]

    my_hash.each_primitive_value_at(keys_to_read){|value,path|
        puts value, path
    }
```


## License

Copyright (c) 2012 by Lloyd Chan

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.