module UserMutations
  @@current_user = nil

  # mutation {
  #   SignInUser(input: {
  #      email: "abreu@gmail.com"
  #    })
  #  }
  SignIn = GraphQL::Relay::Mutation.define do
    name "SignIn"
    description "Allow access user"

    input_field :email, types.String

    return_type types.Boolean

    resolve ->(_obj, args, ctx) {
      begin
        user = User.find_by(email: args[:email])
        if user.present? && user.auth_token.blank?
          user.generate_access_token!
          @@current_user = user

          true
        elsif @@current_user && user.auth_token.present?
          true
        else
          false
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  # mutation {
  #  SignOutUser (input: {})
  # }
  SignOut = GraphQL::Relay::Mutation.define do
    name "SignOut"
    description "Remove token access user"

    return_type types.Boolean

    resolve ->(_obj, _args, ctx) {
      begin
        @@current_user.auth_token
        if @@current_user.update(auth_token: nil)
          true
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  
  #  mutation {
  #    CreateUser(input: {
  #      name: "Abreu dos", 
  #      email: "abreu@gmail.com"
  #    }) {
  #      name
  #      email
  #      auth_token
  #    }
  #  }
  Create = GraphQL::Relay::Mutation.define do
    name "CreateUser "
    description "Allow create new user"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(_obj, args, _ctx) {
      begin
        # Check email exitis
        existsUser = User.find_by(email: args[:email])
        if existsUser.blank?
        
          user = User.new(
            name: args[:name],
            email: args[:email],
            auth_token: nil
          )
        
          user if user.save
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  # mutation {
  #  UpdateUser(input: {
  #    name: "Abreu dos", 
  #    email: "abreu@gmail.com"
  #  }) {
  #    name
  #    email
  #    auth_token
  #  }
  # }
  Update = GraphQL::Relay::Mutation.define do
    name "UpdatUser "
    description "Allow update a user exist"

    input_field :name, types.String
    input_field :email, types.String

    return_type Types::UserType

    resolve ->(_obj, args, ctx) {
      begin
        user = @@current_user
        user if user.update(name: args[:name], email: args[:email])
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end

  # mutation {
  #   DestroyUser(input: {
  #     email: "abreu@gmail.com"
  #   })
  # }
  Destroy = GraphQL::Relay::Mutation.define do
    name "DestroyUser"
    description "Remove user via destroy"

    input_field :email, types.String

    return_type types.Boolean
    
    resolve ->(_obj, args, _ctx) {
      begin
        user = @@current_user
        true if user.present? && user.destroy
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{user.errors.full_messages.join(", ")}")
      end
    }
  end
end