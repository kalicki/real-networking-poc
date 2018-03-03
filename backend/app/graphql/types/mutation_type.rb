MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signInUser, field UserMutations::SignIn.field
  field :singOutUser, field UserMutations::SignOut.field
  field :CreateUser, field: UserMutations::Create.field
  field :UpdateUser, field: UserMutations::Update.field
  field :DestroyUser, field: UserMutations::Destroy.field

  field :CreateCompany, field: CompanyMutations::Create.field
  field :UpdateCompany, field: CompanyMutations::Update.field
  field :DestroyCompany, field: CompanyMutations::Destroy.field
end