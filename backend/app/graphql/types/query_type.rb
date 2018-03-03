QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema. See available queries."

  field :currentUser, UserType do
    description 'Fetch the current user'
    resolve ->(object, args, ctx){
      ctx[:current_user]
    }
  end
end