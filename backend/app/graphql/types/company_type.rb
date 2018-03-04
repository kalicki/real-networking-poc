Types::CompanyType = GraphQL::ObjectType.define do
  name 'Company'
  description 'A company of the user'

  field :id, !types.ID
  field :name, types.String
  field :segment, types.String
  field :created_at, types.String
  field :users do
    type types[Types::UserType]
    resolve ->(obj, _args, _ctx) {
      obj.users
    }
  end
end