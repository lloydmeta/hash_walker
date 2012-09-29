module HashWalker
    module CoreExtensions
        module Hash
            def each_primitive_value_at(keys, path = [], &block)
                keys.each do |key|
                    if key.is_a?(Hash)
                        # iterate for each key, value in this hash
                        key.each do |k, v|
                            node_key_value = self["#{k.to_s}"]
                            if node_key_value.is_a?(Array)
                                node_key_value.each_with_index do |value, i|
                                    #new_path = path + %Q~["#{k.to_s}"][#{i}]~
                                    new_path = path + ["#{k.to_s}"] + [i]
                                    value.each_primitive_value_at(v, new_path, &block)
                                end
                            else
                                #new_path = path + %Q~["#{k.to_s}"]~
                                new_path = path + ["#{k.to_s}"]
                                node_key_value.each_primitive_value_at(v, new_path, &block)
                            end
                        end
                    else
                        node_key_value = self["#{key.to_s}"]
                        if node_key_value.is_a?(Array)
                            node_key_value.each_with_index do |value, i|
                                #new_path = path + %Q~["#{key.to_s}"][#{i}]~
                                new_path = path + ["#{key.to_s}"] + [i]
                                if block_given?
                                    yield value, new_path
                                else
                                    [value, new_path]
                                end
                            end
                        elsif [String, TrueClass, FalseClass, Integer, Float].any?{|x| node_key_value.is_a?(x)}
                            #new_path = path + %Q~["#{key.to_s}"]~
                            new_path = path + ["#{key.to_s}"]
                            if block_given?
                                yield node_key_value, new_path
                            else
                                [node_key_value, new_path]
                            end
                        end
                    end
                end
            end
        end
    end
end

class Hash
    include HashWalker::CoreExtensions::Hash
end