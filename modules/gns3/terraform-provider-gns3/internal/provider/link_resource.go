package provider

import (
	"context"
	"terraform-provider-gns3/internal/resource_link"

	"github.com/hashicorp/terraform-plugin-framework/diag"
	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/resource/schema"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

var _ resource.Resource = (*linkResource)(nil)

func NewLinkResource() resource.Resource {
	return &linkResource{}
}

type linkResource struct{}

func (r *linkResource) Metadata(ctx context.Context, req resource.MetadataRequest, resp *resource.MetadataResponse) {
	resp.TypeName = req.ProviderTypeName + "_link"
}

func (r *linkResource) Schema(ctx context.Context, req resource.SchemaRequest, resp *resource.SchemaResponse) {
	resp.Schema = schema.Schema{
		Attributes: map[string]schema.Attribute{
			"id": schema.StringAttribute{
				Computed: true,
			},
		},
	}
}

func (r *linkResource) Create(ctx context.Context, req resource.CreateRequest, resp *resource.CreateResponse) {
	var data resource_link.LinkModel

	// Read Terraform plan data into the model
	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)

	if resp.Diagnostics.HasError() {
		return
	}

	// Create API call logic

	// Example data value setting
	data.Id = types.StringValue("example-id")

	// Save data into Terraform state
	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *linkResource) Read(ctx context.Context, req resource.ReadRequest, resp *resource.ReadResponse) {
	var data resource_link.LinkModel

	// Read Terraform prior state data into the model
	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)

	if resp.Diagnostics.HasError() {
		return
	}

	// Read API call logic

	// Save updated data into Terraform state
	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *linkResource) Update(ctx context.Context, req resource.UpdateRequest, resp *resource.UpdateResponse) {
	var data resource_link.LinkModel

	// Read Terraform plan data into the model
	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)

	if resp.Diagnostics.HasError() {
		return
	}

	// Update API call logic

	// Save updated data into Terraform state
	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *linkResource) Delete(ctx context.Context, req resource.DeleteRequest, resp *resource.DeleteResponse) {
	var data resource_link.LinkModel

	// Read Terraform prior state data into the model
	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)

	if resp.Diagnostics.HasError() {
		return
	}

	// Delete API call logic
}

// Typically this method would contain logic that makes an HTTP call to a remote API, and then stores
// computed results back to the data model. For example purposes, this function just sets all unknown
// Link values to null to avoid data consistency errors.
// Based uon the schema for links in the GNS3 API, we need to fix the function CallLinkAPI that collects all fields in the schema and sets them to null if they are unknown,
// to avoid data consistency errors.


func CallLinkAPI(ctx context.Context, link *resource_link.LinkModel) diag.Diagnostics {

	if link.CaptureComputeId.IsUnknown() {
		link.CaptureComputeId = types.StringNull()
	}

	if link.CaptureFileName.IsUnknown() {
		link.CaptureFileName = types.StringNull()
	}

	if link.CaptureFilePath.IsUnknown() {
		link.CaptureFilePath = types.StringNull()
	}

	if link.Capturing.IsUnknown() {
		link.Capturing = types.BoolNull()
	}

	// if link.Filters.IsUnknown() {
	// 	link.Filters = resource_link.FiltersValue{}.Type(ctx)
	// }

	if link.Id.IsUnknown() {
		link.Id = types.StringNull()
	}

	// if link.LinkId.IsUnknown() {
	// 	link.LinkId = types.StringNull()()
	// }

	// if link.LinkStyle.IsUnknown() {
	// 	link.LinkStyle = resource_link.LinkStyleValue{}.Type(ctx)
	// }

	if link.LinkType.IsUnknown() {
		link.LinkType = types.StringNull()
	}

	// if link.Nodes.IsUnknown() {
	// 	link.Nodes = types.ListNull(resource_link.NodeValue{}.Type(ctx))
	// } else if !link.Nodes.IsNull() {
	// 	var nodes []resource_link.NodeValue
	// 	diags := link.Nodes.ElementsAs(ctx, &nodes, false)
	// 	if diags.HasError() {
	// 		return diags
	// 	}

	// 	for i := range nodes {
	// 		if nodes[i].Name.IsUnknown() {
	// 			nodes[i].Name = types.StringNull()
	// 		}

	// 		if nodes[i].Value.IsUnknown() {
	// 			nodes[i].Value = types.StringNull()
	// 		}
	// 	}

	// 	link.Nodes, diags = types.ListValueFrom(ctx, resource_link.NodeValue{}.Type(ctx), nodes)
	// 	if diags.HasError() {
	// 		return diags
	// 	}
	// }
	return nil
}
