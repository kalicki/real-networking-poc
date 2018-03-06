module CompanyMutations
  #mutation {
  #  CreateCompany(input: {
  #    email: "abreu@gmail.com", 
  #    name: "Test S/A"
  #    segment: "Hardware"
  #  }) {
  #    id
  #    name
  #    segment
  #  }
  #}
  Create = GraphQL::Relay::Mutation.define do
    name "CreateCompany "
    description "create new Company"

    input_field :email, types.String
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
          user.update(company_id: new_company.id)
          new_company
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
  
  #mutation {
  #  UpdateCompany(input: {
  #    id: 5, 
  #    name: "Abacate S/A",
  #    segment: "Alimentos"
  #  }) {
  #    id
  #    name
  #    segment
  #  }
  #}
  Update = GraphQL::Relay::Mutation.define do
    name "UpdateCompany "
    description "Allow update a Company exist"

    input_field :id, types.ID
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

          company
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
  
  # mutation {
  #  DestroyCompany(input: {
  #    id: 4
  #  })
  # }
  Destroy = GraphQL::Relay::Mutation.define do
    name "DestroyCompany"
    description "Remove Company via destroy"

    input_field :id, types.ID

    return_type types.Boolean

    resolve ->(_obj, args, _ctx) {
      begin
        company = Company.find(args[:id])

        if company.present?
          # Change company for current user
          User.where(company_id: args[:id]).find_each do |user|
            user.update(company_id: nil)
          end
          
          # Destroy company
          company.destroy
          true
        end
      rescue ActiveRecord::RecordInvalid => err
        GraphQL::ExecutionError.new("#{company.errors.full_messages.join(", ")}")
      end
    }
  end
end