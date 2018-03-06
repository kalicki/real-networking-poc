Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :SignInUser, field: UserMutations::SignIn.field
  field :SignOutUser, field: UserMutations::SignOut.field
  field :CreateUser, field: UserMutations::Create.field
  field :UpdateUser, field: UserMutations::Update.field
  field :DestroyUser, field: UserMutations::Destroy.field

  field :CreateCompany, field: CompanyMutations::Create.field
  field :UpdateCompany, field: CompanyMutations::Update.field
  field :DestroyCompany, field: CompanyMutations::Destroy.field
end