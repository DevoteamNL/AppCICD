package provider

import (
	"context"
	"go/types"

	"github.com/hashicorp/terraform-plugin-framework/datasource"
	"github.com/hashicorp/terraform-plugin-framework/path"
	"github.com/hashicorp/terraform-plugin-framework/provider"
	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/provider/schema"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

var (
	_ provider.Provider = &gns3Provider{}
)

func New(version string) func() provider.Provider {
	return func() provider.Provider {
		return &gns3Provider{
			version: version,
		}
	}
}

type gns3Provider struct {
	// version is set to the provider version on release, "dev" when the
	// provider is built and ran locally, and "test" when running acceptance
	// testing.
	version string
}

type gns3ProviderModel struct {
	Address types.String `tfsdk:"address"`
	Username types.String `tfsdk:"username"`
	Password types.String `tfsdk:"password"`
}

func (p *gns3Provider) Schema(ctx context.Context, req provider.SchemaRequest, resp *provider.SchemaResponse) {
	resp.Schema = schema.Schema{
		Attributes: map[string]schema.Attribute{
			"address": schema.StringAttribute{
				Required: true,
			},
			"username": schema.StringAttribute{
				Optional: true,	
			},
			"password": schema.StringAttribute{
				Optional: true,
				Sensitive: true,
			},
		},
	}
}

func (p *gns3Provider) Configure(ctx context.Context, req provider.ConfigureRequest, resp *provider.ConfigureResponse) {
	var config gns3ProviderModel
	diags := req.Config.Get(ctx, &config)
	resp.Diagnostics.Append(diags...)
	if resp.Diagnostics.HasError() {
		return
	}	

	if config.Address.IsUnknown() {
		resp.Diagnostics.AddAttributeError(
			path.Root("address"),
			"address is required",
			"The provider cannot create the GNS3 API client as there is no address provided."+
				"Either target a specific address or use the GNS3_API_ADDRESS environment variable.",
		)
	}

	if config.Username.IsUnknown() {
		resp.Diagnostics.AddAttributeError(
			path.Root("username"),
			"Unknown GNS3 API Username",
			"The provider cannot create the GNS3 API client as there is an unknown configuration value for the GNS3 API username. "+
				"Either target apply the source of the value first, set the value statically in the configuration, or use the GNS3_API_USERNAME environment variable.",
		)
	}

	if config.Password.IsUnknown() {
		resp.Diagnostics.AddAttributeError(
			path.Root("password"),
			"Unknown GNS3 API Password",
			"The provider cannot create the Gns3 API client as there is an unknown configuration value for the GNS3 API password. "+
				"Either target apply the source of the value first, set the value statically in the configuration, or use the GNS3_API_PASSWORD environment variable.",
		)
	}

	if resp.Diagnostics.HasError() {	
		return
	}

	//Default values to environment variables, but override with config values if provided

	address := os.Getenv("GNS3_API_ADDRESS")
	username := os.Getenv("GNS3_API_USERNAME")
	password := os.Getenv("GNS3_API_PASSWORD")

	if !config.Address.IsNull() {
		address = config.Address.ValueString()
	}

	if !config.Username.IsNull() {
		username = config.Username.ValueString()
	}

	if !config.Password.IsNull() {
		password = config.Password.ValueString()
	}

	// If any of the expected configurations are missing, return
	// errors with provider-specific guidance.

	if address == "" {
		resp.Diagnostics.AddAttributeError(
			path.Root("address"),
			"Missing GNS3 API address",
			"The provider cannot create the GNS3 API client as there is a missing or empty value for the GNS3 API address. "+
				"Set the address value in the configuration or use the GNS3_API_ADDRESS environment variable. "+
				"If either is already set, ensure the value is not empty.",
		)
	}

	if username == "" {
		resp.Diagnostics.AddAttributeError(
			path.Root("username"),
			"Missing GNS3 API Username",
			"The provider cannot create the GNS3 API client as there is a missing or empty value for the GNS3 API username. "+
				"Set the username value in the configuration or use the GNS3_API_USERNAME environment variable. "+
				"If either is already set, ensure the value is not empty.",
		)
	}

	if password == "" {
		resp.Diagnostics.AddAttributeError(
			path.Root("password"),
			"Missing GNS3 API Password",
			"The provider cannot create the GNS3 API client as there is a missing or empty value for the GNS3 API password. "+
				"Set the password value in the configuration or use the GNS3_API_PASSWORD environment variable. "+
				"If either is already set, ensure the value is not empty.",
		)
	}

	if resp.Diagnostics.HasError() {
		return
	}

	ctx = tflog.SetField(ctx, "gns3_address", address)
	ctx = tflog.SetField(ctx, "gns3_username", username)
	ctx = tflog.SetField(ctx, "gns3_password", password)
	ctx = tflog.MaskFieldValuesWithFieldKeys(ctx, "gns3_password")

	tflog.Debug(ctx, "Creating GNS3 client")

	// Create a new GNS3_API_PASSWORD client using the configuration values
	client, err := gns3.NewClient(&address, &username, &password)
	if err != nil {
		resp.Diagnostics.AddError(
			"Unable to Create GNS3 API Client",
			"An unexpected error occurred when creating the GNS3 API client. "+
				"If the error is not clear, please contact the provider developers.\n\n"+
				"GNS3 Client Error: "+err.Error(),
		)
		return
	}

	// Make the GNS3 client available during DataSource and Resource
	// type Configure methods.
	resp.DataSourceData = client
	resp.ResourceData = client

	tflog.Info(ctx, "Configured GNS3 client", map[string]any{"success": true})
}

func (p *gns3Provider) Metadata(ctx context.Context, req provider.MetadataRequest, resp *provider.MetadataResponse) {
	resp.TypeName = "gns3"
}

func (p *gns3Provider) DataSources(ctx context.Context) []func() datasource.DataSource {
	return []func() datasource.DataSource{}
}

func (p *gns3Provider) Resources(ctx context.Context) []func() resource.Resource {
	return []func() resource.Resource{}
}
