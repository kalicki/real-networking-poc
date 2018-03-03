Types::CompanyType = GraphQL::ObjectType.define do                                                                                                                                                                                              
  name 'CompanyType'
  description 'A company of the user'

  field :id, !types.ID, hash_key: :uuid
  field :name, types.String "The name of this company"
  field :segment, types.String "The segment of this company"
  field :user, types[Types::UserType] "The name of this user"
  field :created_at, types.String, "The time at value created"
end