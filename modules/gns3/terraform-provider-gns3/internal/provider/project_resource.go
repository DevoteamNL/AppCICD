package provider

import (
	"context"
	"terraform-provider-gns3/internal/resource_project"

	"github.com/hashicorp/terraform-plugin-framework/diag"
	"github.com/hashicorp/terraform-plugin-framework/resource"
	"github.com/hashicorp/terraform-plugin-framework/types"
)

var _ resource.Resource = (*projectResource)(nil)

func NewProjectResource() resource.Resource {
	return &projectResource{}
}

type projectResource struct{}

func (r *projectResource) Metadata(ctx context.Context, req resource.MetadataRequest, resp *resource.MetadataResponse) {
	resp.TypeName = req.ProviderTypeName + "_project"
}

func (r *projectResource) Schema(ctx context.Context, req resource.SchemaRequest, resp *resource.SchemaResponse) {
	resp.Schema = resource_project.ProjectResourceSchema(ctx)
}

func (r *projectResource) Create(ctx context.Context, req resource.CreateRequest, resp *resource.CreateResponse) {
	var data resource_project.ProjectModel

	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.Diagnostics.Append(CallProjectAPI(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *projectResource) Read(ctx context.Context, req resource.ReadRequest, resp *resource.ReadResponse) {
	var data resource_project.ProjectModel

	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *projectResource) Update(ctx context.Context, req resource.UpdateRequest, resp *resource.UpdateResponse) {
	var data resource_project.ProjectModel

	resp.Diagnostics.Append(req.Plan.Get(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.Diagnostics.Append(CallProjectAPI(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}

	resp.Diagnostics.Append(resp.State.Set(ctx, &data)...)
}

func (r *projectResource) Delete(ctx context.Context, req resource.DeleteRequest, resp *resource.DeleteResponse) {
	var data resource_project.ProjectModel

	resp.Diagnostics.Append(req.State.Get(ctx, &data)...)
	if resp.Diagnostics.HasError() {
		return
	}
}

// Typically this method would contain logic that makes an HTTP call to a remote API, and then stores
// computed results back to the data model. For example purposes, this function just sets all unknown
// Project values to null to avoid data consistency errors.
// Based uon the schema for projects in the GNS3 API, we need to fix the function CallProjectAPI that collects all fields in the schema and sets them to null if they are unknown,
// to avoid data consistency errors.

func CallProjectAPI(ctx context.Context, project *resource_project.ProjectModel) diag.Diagnostics {
	if project.Name.IsUnknown() {
		project.Name = types.StringNull()
	}

	if project.Id.IsUnknown() {
		project.Id = types.StringNull()
	}

	if project.Path.IsUnknown() {
		project.Path = types.StringNull()
	}

	if project.AutoClose.IsUnknown() {
		project.AutoClose = types.BoolNull()
	}

	if project.AutoOpen.IsUnknown() {
		project.AutoOpen = types.BoolNull()
	}

	if project.AutoStart.IsUnknown() {
		project.AutoStart = types.BoolNull()
	}

	if project.SceneHeight.IsUnknown() {
		project.SceneHeight = types.Int64Null()
	}

	if project.SceneWidth.IsUnknown() {
		project.SceneWidth = types.Int64Null()
	}

	if project.Zoom.IsUnknown() {
		project.Zoom = types.Int64Null()
	}

	if project.ShowLayers.IsUnknown() {
		project.ShowLayers = types.BoolNull()
	}

	if project.SnapToGrid.IsUnknown() {
		project.SnapToGrid = types.BoolNull()
	}

	if project.ShowGrid.IsUnknown() {
		project.ShowGrid = types.BoolNull()
	}

	if project.GridSize.IsUnknown() {
		project.GridSize = types.Int64Null()
	}

	if project.DrawingGridSize.IsUnknown() {
		project.DrawingGridSize = types.Int64Null()
	}

	if project.ShowInterfaceLabels.IsUnknown() {
		project.ShowInterfaceLabels = types.BoolNull()
	}

	// if project.Supplier.IsUnknown() {
	// 	project.Supplier = resource_project.SupplierValue{}.Type(ctx)
	// }

	// if project.Variables.IsUnknown() {
	// 	project.Variables = types.ListNull(resource_project.VariableValue{}.Type(ctx))
	// } else if !project.Variables.IsNull() {
	// 	var variables []resource_project.VariableValue
	// 	diags := project.Variables.ElementsAs(ctx, &variables, false)
	// 	if diags.HasError() {
	// 		return diags
	// 	}

	// 	for i := range variables {
	// 		if variables[i].Name.IsUnknown() {
	// 			variables[i].Name = types.StringNull()
	// 		}

	// 		if variables[i].Value.IsUnknown() {
	// 			variables[i].Value = types.StringNull()
	// 		}
	// 	}

	// 	project.Variables, diags = types.ListValueFrom(ctx, resource_project.VariableValue{}.Type(ctx), variables)
	// 	if diags.HasError() {
	// 		return diags
	// 	}
	// }

	// if project.Status.IsUnknown() {
	// 	project.Status = resource_project.ProjectStatusValue{}.Type(ctx)
	// }

	if project.Filename.IsUnknown() {
		project.Filename = types.StringNull()
	}

	return nil
}
