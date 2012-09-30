require 'spec_helper'

describe Hash do
    context 'Simple Example' do
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

    context 'complicated example' do
        subject do
            {
                "_confidence_factor"=>90,
                "_backup_level"=>4,
                "_id"=>"www.something_here.com",
                "_last_studio_import"=>"2012-04-03T18:19:03.139000",
                "_last_updated"=>"2012-09-19T18:45:55.288000",
                "_manual_article_popular_search"=>[
                    {
                        "cached_ids"=>[
                            {
                                "_id"=>"aaaa",
                                "summary"=>"aaa ..."
                            },
                            {
                                "_id"=>"bbbb",
                                "summary"=>"bbbb...."
                            }
                        ],
                        "start_time"=>"2011-01-01T00:00:00"
                    }
                ],
                "_type"=>"document",
                "article_type_id"=>"Professional",
                "asset_meta"=>{
                    "count"=>{
                        "reference"=>0,
                        "reference_link"=>0,
                        "resource"=>2,
                        "warning"=>0,
                        "word_detail"=>955,
                        "word_summary"=>224
                    }
                },
                "byline"=>"Contributor",
                "children"=>[

                ],
                "content_rating"=>4,
                "content_type"=>"Features",
                "culture"=>"en-US",
                "dart_zone"=>"holidays",
                "description"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                "documents"=>[

                ],
                "image"=>{
                    "credit"=>"sjlocke/iStockphoto.com",
                    "height"=>565,
                    "thumbheight"=>"67",
                    "width"=>849
                },
                "introduction"=>{
                    "steps"=>[
                        {
                            "image"=>{
                                "credit"=>"sjlocke/iStockphoto.com",
                                "height"=>565,
                                "thumbheight"=>"67",
                                "width"=>849
                            },
                            "paragraph"=>[
                                {
                                    "content"=>"jklas jfklsj afkl;sj flk;asd."
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                }
                            ],
                            "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                        }
                    ]
                },
                "is_ugc"=>false,
                "keywords"=>[
                    (0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                    (0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                    (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                ],
                "last_pub_date"=>"2011-04-08T10:57:56",
                "last_published_date"=>"2012-04-03T16:03:00",
                "last_rcp_import"=>"2012-09-24T00:04:06.116000",
                "level"=>4,
                "pub_date"=>"2011-07-13T00:00:00",
                "publisher_id"=>7447502,
                "quote"=>{
                    "steps"=>[
                        {
                            "paragraph"=>[
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                }
                            ],
                            "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                        },
                        {
                            "paragraph"=>[
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                }
                            ],
                            "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                        }
                    ],
                    "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                },
                "references"=>[

                ],
                "resources"=>[
                    {
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                        "url"=>"http://www.aap.org/advocacy/releases/octhalloween.cfm"
                    },
                    {
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                        "url"=>"http://www.cdc.gov/family/halloween/"
                    }
                ],
                "sections"=>[
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    },
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    },
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    },
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    },
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    },
                    {
                        "steps"=>[
                            {
                                "paragraph"=>[
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    },
                                    {
                                        "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                    }
                                ]
                            }
                        ],
                        "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                    }
                ],
                "sidebar"=>{
                    "steps"=>[
                        {
                            "paragraph"=>[
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                },
                                {
                                    "content"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                                }
                            ],
                            "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                        }
                    ],
                    "title"=>"Sidebar"
                },
                "subtitle"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                "summary"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                "summary_history"=>[
                    (0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                    (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
                ],
                "summary_is_first_section"=>true,
                "things_needed"=>[

                ],
                "tips"=>[

                ],
                "title"=>(0...50).map{ ('a'..'z').to_a[rand(26)] }.join,
                "title_id"=>6031231226583,
                "title_source_name"=>"ADMIN_SUGGESTED",
                "type"=>"Article",
                "warnings"=>[

                ],
                "who_can_help"=>nil,
                "writer"=>"www.demandstudios.com/contributor/c77ecbad-49ea-4afc-95be-3978c8033035"
            }
        end

        describe 'validations' do
            before(:all) do
                @keys_to_read = keys_to_read = [
                    "content",
                    "description",
                    "ingredients",
                    "keywords",
                    {"image" => ["caption"]},
                    {"introduction" => [
                        "steps" => [
                            {"image" => ["caption"]},
                            {"paragraph" => ["content"]},
                            "title"
                        ]
                    ]},
                    {"quote" => [
                        "steps" => [
                            {"image" => ["caption"]},
                            {"paragraph" => ["content"]},
                            "title"
                        ]
                    ]},
                    {"references" => ["title"]},
                    {"sections" => [
                        "steps" => [
                            {"paragraph" => ["content"]},
                            {"image" => ["caption"]},
                            "title"
                        ]
                    ]},
                    "subtitle",
                    "summary",
                    "things_needed",
                    "tips",
                    "title",
                    "warnings"
                ]
            end

            it "should traverse without problems" do
                lambda do
                    subject.each_primitive_value_at(@keys_to_read)
                end.should_not raise_error
            end

            it 'should return me values with proper paths' do
                values_and_paths_found = []

                subject.each_primitive_value_at(@keys_to_read){|value, path_array|
                    path_as_string = path_array.reduce('') {|path_so_far, path_array_element|
                        if path_array_element.is_a?(String)
                            path_so_far += %Q~["#{path_array_element}"]~
                        elsif path_array_element.is_a?(Integer)
                            path_so_far += %Q~[#{path_array_element.to_s}]~
                        end
                        path_so_far
                    }
                    values_and_paths_found << [value, path_array]
                }
                values_and_paths_found.size.should eq(47)
                values_and_paths_found.each do |value_and_path|
                    subject_value_at_path = value_and_path[1].reduce(subject){|value_so_far, step|
                        value_so_far = value_so_far[step]
                    }
                    subject_value_at_path.should eq(value_and_path[0])
                end
            end
        end
    end

end