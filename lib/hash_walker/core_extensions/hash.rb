module HashWalker
    module CoreExtensions
        module Hash

            PRIMITIVE_CLASSES_TO_RETURN_VALUES_FOR = [
                String,
                TrueClass,
                FalseClass,
                Integer,
                Float
            ]

            def each_primitive_value_at(keys, path = [], &block)
                keys.each do |key|
                    if key.is_a?(Hash)
                        # iterate for each key, value in this hash
                        key.each do |k, v|
                            node_key_value = self["#{k.to_s}"]
                            if node_key_value.is_a?(Array)
                                node_key_value.each_with_index do |value, i|
                                    value.each_primitive_value_at(v, path + ["#{k.to_s}"] + [i], &block)
                                end
                            else
                                node_key_value.each_primitive_value_at(v, path + ["#{k.to_s}"], &block) unless node_key_value.nil?
                            end
                        end
                    else
                        node_key_value = self["#{key.to_s}"]
                        if node_key_value.is_a?(Array)
                            node_key_value.each_with_index do |value, i|
                                yield value, path + ["#{key.to_s}"] + [i] if block_given?
                            end
                        elsif PRIMITIVE_CLASSES_TO_RETURN_VALUES_FOR.any?{|x| node_key_value.is_a?(x)}
                            yield node_key_value, path + ["#{key.to_s}"] if block_given?
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