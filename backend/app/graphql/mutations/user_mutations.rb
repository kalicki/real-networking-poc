module UserMutations
  SignIn = GraphQL::Relay::Mutation.define do
    name "Sign In"
    description "Allow access user"
    
    input_field :email, types.String

    return_field :token, types.String

    resolve ->(obj, args, ctx) {
      user = User.find_by(email: args[:email])
      if user.present?
        user.generate_access_token!
      end
    }
  end 

  SingOut = GraphQL::Relay::Mutation.define do
    name "Sing Out"
    description "Remove token access user"

    return_type types.Boolean

    resolve ->(obj, args, ctx) {
      if ctx[:current_user].update(access_token: nil)
        return true
      end
    }
  end

  Create = GraphQL::Relay::Mutation.define do
    name "Create user "
    description "Allow create new user"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(obj, args, ctx) {
      user = User.new(
        name: args[:name],
        email: args[:email],
        company: nil,
      )

      if user.save
        user.generate_access_token!
        return user
      else
        return GraphQL::ExecutionError.new("Invalid input: #{user.errors.full_messages.join(', ')}")
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    name "Update user "
    description "Allow update a user exist"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(obj, args, ctx) {
      current_user = ctx[:current_user]
     
      if current_user.update(name: args[:name], email: args[:email])
        return user
      else
        return GraphQL::ExecutionError.new("Invalid input: #{user.errors.full_messages.join(', ')}")
      end
    }

  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "Destroy user"
    description "Remove user via destroy"

    return_type types.Boolean

    resolve ->(obj, args, ctx) {
      if ctx[:current_user].destroy
        return true
      end
    }
  end
end