module CompanyMutations
    Create = GraphQL::Relay::Mutation.define do
      name "Create Company "
      description "create new Company"
  
      input_field :name, types.String
      input_field :segment, types.String
  
      return_type Types::CompanyType
  
      resolve ->(obj, args, ctx) {
        current_user = ctx[:current_user]
        new_company = Company.new(
          name: args[:name],
          segment: args[:segment]
        )

        if new_company.save
          # Change company for current user
          current_user.update(company: ctx[:current_user])

          return new_company
        else
          return GraphQL::ExecutionError.new("Invalid input: #{Company.errors.full_messages.join(', ')}")
        end
      }
    end
  
    Update = GraphQL::Relay::Mutation.define do
      name "Update Company "
      description "Allow update a Company exist"
  
      input_field :name, types.String
      input_field :segment, types.String
  
      return_type Types::CompanyType
  
      resolve ->(obj, args, ctx) {
        company_selected = Company.find(args[:id])

        if company_selected.present?
          company_selected.update(name: args[:name], segment: args[:segment])

          return company_selected
        else
          return GraphQL::ExecutionError.new("Invalid input: #{Company.errors.full_messages.join(', ')}")
        end
      }
    end
  
    Destroy = GraphQL::Relay::Mutation.define do
      name "Destroy Company"
      description "Remove Company via destroy"
  
      return_type types.Boolean
  
      resolve ->(obj, args, ctx) {
        current_user = ctx[:current_user]
        company_selected = Company.find(args[:id])

        if company_selected.destroy
          # Change company for current user
          current_user.update(company: nil)

          return true
        end
      }
    end
  end