# hash_walker

[![Build
Status](https://secure.travis-ci.org/lloydmeta/hash_walker.png)](http://travis-ci.org/lloydmeta/hash_walker)

A simple gem that allows you to traverse/walk a Hash according to a set of keys (also a hash), passing in a block to perform actions on. This method will yield your block with each value found and the Hash 'path' of the value as arguments

## Installing

Add to your `Gemfile`:

```ruby
    gem 'hash_walker'
```

Where you want to use the method on your hashes:

```ruby
    require 'hash_walker'
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