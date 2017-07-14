name 'rs_azure_sql'
type 'plugin'
rs_ca_ver 20161221
short_description "Azure SQL Plugin"
package "plugins/rs_azure_sql"
import "sys_log"

plugin "rs_azure_sql" do
  endpoint do
    default_scheme "https"
    query do {
      "api-version" => "2014-04-01"
    } end
  end

  type "server" do
    href_templates "/subscriptions/$subscription_id/resourceGroups/$resource_group_name/providers/Microsoft.Sql/servers/$server_name?api-version=2014-04-01"
    provision "provision_resource"
    delete    "delete_resource"

    field "server_name" do
      alias_for "serverName"
      type      "string"
      location  "path"
      required true
    end

    field "resource_group_name" do
      alias_for "resourceGroupName"
      type      "string"
      location  "path"
      required true
    end

    field "subscription_id" do
      alias_for "subscriptionId"
      type      "string"
      location  "path"
      required true
    end

    field "property_version" do
      alias_for "parameters.parameters.properties.version"
      type "string"
      location "body"
    end

    field "administrator_login" do
      alias_for "parameters.parameters.properties.administratorLogin"
      type "string"
      location "body"
    end

    field "administrator_login_password" do
      alias_for "parameters.parameters.properties.administratorLoginPassword"
      type "string"
      location "body"
    end

    field "location" do
      alias_for "parameters.parameters.location"
      type "string"
      location "body"
    end

    provision "provision_resource"
    delete "delete_resource"
  end
end

resource_pool "rs_azure_sql" do
  plugin $rs_azure_sql
  host "management.core.windows.net"
  auth "my_azure_auth", type: "oauth2" do
    token_url "https://login.microsoftonline.com/" + TENANT_ID + "/oauth2/token"
    grant type: "client_credentials" do
      # for authorization by form data parameters.
      client_id cred("CLIENT_ID")
      client_secret cred("CLIENT_SECRET")
      # alternative to id+secret for authorization services requiring Basic authentication.
      # these are similar to our grant_type=refresh_token parameters.
      client_user cred("CLIENT_USER")
      client_password cred("CLIENT_PASSWORD")
      # not required for Azure but perhaps for other authorization services.
      additional_headers do {
        "Extra" => "header value"
      } end
      # example of specifying "resource" as an additional parameter for Azure.
      # allows passing additional form data parameters in the authorization request.
      additional_params do {
        "resource" => "https://management.azure.com/"
      } end
  end
end
end

define create_stack(@declaration) return @resource do
  sub on_error: stop_debugging() do
    call start_debugging()
    $object = to_object(@declaration)
    $fields = $object["fields"]
    $tags = $fields["tags"]
    call sys_log.set_task_target(@@deployment)
    call sys_log.detail($object)
    @resource = @operation.get()
    call sys_log.detail(to_object(@resource))
    call stop_debugging()
  end
end

define delete_stack(@declaration) do
  call start_debugging()
  @declaration.destroy()
  call stop_debugging()
end

define start_debugging() do
  if $$debugging == false || logic_and($$debugging != false, $$debugging != true)
    initiate_debug_report()
    $$debugging = true
  end
end

define stop_debugging() do
  if $$debugging == true
    $debug_report = complete_debug_report()
    call sys_log.detail($debug_report)
    $$debugging = false
  end
end


resource "sql_server" type "rs_azure_sql.server" do
end