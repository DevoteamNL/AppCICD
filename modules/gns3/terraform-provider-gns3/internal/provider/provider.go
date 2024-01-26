package provider

import (
	"context"

	"github.com/hashicorp/terraform-plugin-framework/datasource"
	"github.com/hashicorp/terraform-plugin-framework/provider"
	"github.com/hashicorp/terraform-plugin-framework/resource"
)

var _ provider.Provider = (*gns3Provider)(nil)

func New() func() provider.Provider {
	return func() provider.Provider {
		return &gns3Provider{}
	}
}

type gns3Provider struct{}

func (p *gns3Provider) Schema(ctx context.Context, req provider.SchemaRequest, resp *provider.SchemaResponse) {

}

func (p *gns3Provider) Configure(ctx context.Context, req provider.ConfigureRequest, resp *provider.ConfigureResponse) {

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
