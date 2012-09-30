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

            # Walks/traveres the current Hash object according to a set of
            # keys (itself also an array/hash)
            # Params:
            # +keys+:: +Array+ An array of keys (which themselves can be hashes and further arrays) to look for
            # +&block+:: +Block+ object that gets yielded and passed each value and each path (array) respectively as arguments
            def each_primitive_value_at(keys, path = [], &block)
                keys.each do |key|
                    if key.is_a?(Hash)
                        # iterate for each key, value in this hash
                        key.each do |k, v|
                            node_key_value = self[k]
                            if node_key_value.is_a?(Array)
                                node_key_value.each_with_index do |value, i|
                                    value.each_primitive_value_at(v, path + [k] + [i], &block)
                                end
                            else
                                node_key_value.each_primitive_value_at(v, path + [k], &block) unless node_key_value.nil?
                            end
                        end
                    else
                        node_key_value = self[key]
                        if node_key_value.is_a?(Array)
                            node_key_value.each_with_index do |value, i|
                                yield value, path + [key] + [i] if block_given?
                            end
                        elsif PRIMITIVE_CLASSES_TO_RETURN_VALUES_FOR.any?{|x| node_key_value.is_a?(x)}
                            yield node_key_value, path + [key] if block_given?
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