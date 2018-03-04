module CompanyMutations
  Create = GraphQL::Relay::Mutation.define do
    name "CreateCompany "
    description "create new Company"

    input_field :name, types.String
    input_field :segment, types.String

    return_type Types::CompanyType

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.find_by(email: args[:email])
        new_company = Company.new(
          name: args[:name],
          segment: args[:segment]
        )
        if new_company.save
          user.update(company: new_company.id)
          return new_company
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
  
  Update = GraphQL::Relay::Mutation.define do
    name "UpdateCompany "
    description "Allow update a Company exist"

    input_field :name, types.String
    input_field :segment, types.String

    return_type Types::CompanyType

    resolve ->(obj, args, ctx) {
      begin
        # Find comapny by ID
        company = Company.find(args[:id])
        if company.present?
          # Update data
          company.update(
            name: args[:name], 
            segment: args[:segment]
          )

          return company
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
  
  Destroy = GraphQL::Relay::Mutation.define do
    name "DestroyCompany"
    description "Remove Company via destroy"

    return_type types.Boolean

    resolve ->(_obj, args, _ctx) {
      begin
        user = User.find_by(email: args[:email])
        company = Company.find(args[:id])

        if company.destroy
          # Change company for current user
          user.update(company: nil)

          return true
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
end