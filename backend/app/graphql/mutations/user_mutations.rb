module UserMutations
  SignIn = GraphQL::Relay::Mutation.define do
    name "SignIn"
    description "Allow access user"

    input_field :email, types.String

    return_field :token, types.String

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.find_by(email: args[:email])
        user.generate_access_token! if user.present?

      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  SingOut = GraphQL::Relay::Mutation.define do
    name "SingOut"
    description "Remove token access user"

    return_type types.Boolean

    resolve ->(_obj, args, _ctx) {
      begin
        return true if User.find(args[:email]).update(access_token: nil)
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  Create = GraphQL::Relay::Mutation.define do
    name "CreateUser "
    description "Allow create new user"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.new(
          name: args[:name],
          email: args[:email],
          company: nil
        )
        user.generate_access_token!
        return user
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    name "UpdatUser "
    description "Allow update a user exist"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.find_by(email: args[:email])
        return user if user.update(name: args[:name], email: args[:email])
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name "DestroyUser"
    description "Remove user via destroy"

    return_type types.Boolean

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.find_by(email: args[:email])
        return true if user.destroy
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end
end