require 'spec_helper'

describe Hash do
    subject do
        {
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
    end

    before(:all) do

        @keys_to_read_a_array = [
            "a_array"
        ]

        @keys_to_read_b_hash_primitives = [
            "b_hash" => [
                "b_value_string",
                "b_value_int",
                "b_value_bool",
                "b_value_float",
            ]
        ]

        @keys_to_read_complete = [
            "a_array",
            "b_hash" => [
                "b_value_string",
                "b_value_int",
                "b_value_bool",
                "b_value_float",
                {"b_inner_array" => ["content"]}
            ]
        ]

        @keys_to_read_REALLY_complete = [
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
    end

    it 'should have the each_primitive_value_at method' do
        subject.should respond_to(:each_primitive_value_at)
    end

    it 'should find 5 values for @keys_to_read_a_array key array' do
        values_found = []
        subject.each_primitive_value_at(@keys_to_read_a_array){|value,path|
            values_found << value
            subject['a_array'].should include(value)
            path.should include('a_array')
            path[1].class.should eq(Fixnum)
        }
        values_found.size.should eq(5)
    end

    it 'should find 5 values for @keys_to_read_b_hash_primitives key array' do
        values_found = []
        b_hash_primitives = [
            'b value as string',
            420,
            true,
            4.2
        ]
        subject.each_primitive_value_at(@keys_to_read_b_hash_primitives){|value,path|
            values_found << value
            b_hash_primitives.should include(value)
            path.should include('b_hash')
            @keys_to_read_b_hash_primitives[0]['b_hash'].should include(path[1])
        }
        values_found.size.should eq(4)
    end

    it 'should find 12 values in total for @keys_to_read_complete' do
        values_found = []
        paths_found = []
        subject.each_primitive_value_at(@keys_to_read_complete){|value,path|
            values_found << value
            paths_found << path
        }
        values_found.size.should eq(13)
        paths_found.size.should eq(13)
    end

    it 'should find 16 values in total for @keys_to_read_REALLY_complete' do
        values_found = []
        paths_found = []
        subject.each_primitive_value_at(@keys_to_read_REALLY_complete){|value,path|
            values_found << value
            paths_found << path
        }
        values_found.size.should eq(16)
        paths_found.size.should eq(16)
    end

end