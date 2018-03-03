Types::UserType = GraphQL::ObjectType.define do                                                                                                                                                                                              
  name 'UserType'
  description 'A user account in API'

  field :id, !types.ID, hash_key: :uuid
  field :name, types.String, "The name of this user"
  field :email, !types.String,  "The email of this user"
  field :company, Types::CompanyType, "The company of this user"
  field :created_at, Types::DateTimeType, property: :created_at, "The date this user created an account"
  field :token, types.String, "Access token" do
    resolve ->(user, args, ctx) {
      user.auth_token
    }
  end
end