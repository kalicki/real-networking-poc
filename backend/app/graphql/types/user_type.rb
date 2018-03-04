Types::UserType = GraphQL::ObjectType.define do                                                                                                                                                                                              
  name 'User'
  description 'A user account in API'

  field :id, !types.ID
  field :name, types.String
  field :email, !types.String
  field :company, types.ID
  field :auth_token, types.String
end