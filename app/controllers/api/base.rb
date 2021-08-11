module Api
  class Base < Grape::API
    mount V1::Blogs
    add_swagger_documentation(
      info: {
        title: "GrapeRailsTemplate API Documentation",
        contact_email: 'service@eggman.tv'
      },
      mount_path: '/api/v1/doc/swagger',
      doc_version: '0.1.0'
    )
  end
end