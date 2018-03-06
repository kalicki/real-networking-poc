Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end

  field :me, Types::UserType do
    description "The current user"
    resolve -> (obj, args, ctx) {
      ctx[:current_user]
    }
  end

  field :allUsers, Types::UserType do
    description "List with all users"
    resolve ->(obj, args, ctx) {
      User.all
    }
  end
end