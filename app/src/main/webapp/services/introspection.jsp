<%@page import="com.orchestranetworks.service.ServiceContext"%>
<%@page import="com.onwbp.base.text.UserMessage"%>
<%@page import="com.orchestranetworks.ui.UIServiceComponentWriter"%>
<%@page import="com.orchestranetworks.schema.SchemaNode"%>

<%@page import="com.onwbp.adaptation.AdaptationTable"%>
<%@page import="com.onwbp.adaptation.AdaptationName"%>
<%@page import="com.orchestranetworks.instance.HomeKey"%>

<%@page import="com.orchestranetworks.schema.Path"%>
<%@page import="com.onwbp.adaptation.Adaptation"%>

<%

final ServiceContext serviceContext = ServiceContext.getServiceContext(request);
serviceContext.setTitle(UserMessage.createInfo("Data Model introspection"));

final UIServiceComponentWriter writer = serviceContext.getUIComponentWriter();

writer.addSafeInnerHTML(serviceContext.getCurrentNode().getPathInSchema().format());
writer.add("<br>");
writer.add("<br>");

final SchemaNode[] fields = serviceContext.getCurrentNode().getTableOccurrenceRootNode().getNodeChildren();
if(fields!=null) {
	for (final SchemaNode field : fields) {
		writer.addSafeInnerHTML("field ");
		writer.addSafeInnerHTML(field.getPathInAdaptation().format());
		writer.add("<br>");

		if(field.getRelationship()!=null) {
			writer.addSafeInnerHTML("relationship to ");

			if(field.getRelationship().getContainerHome()!=null) {
				writer.addSafeInnerHTML("dataspace=");
				writer.addSafeInnerHTML(field.getRelationship().getContainerHome().format());
			}

			final String tableNodePathInSchema = field.getRelationship().getTableNode().getPathInSchema().format();
			writer.addSafeInnerHTML(tableNodePathInSchema);
			writer.add("<br>");
		}

		writer.add("<br>");
	}
}

writer.add("<br>");
writer.add("<br>");

writer.add("<div>");
writer.add("<b>ebx-directory introspection</b><br>");


		final AdaptationTable users = serviceContext.getCurrentHome().getRepository().lookupHome(HomeKey.parse("Bebx-directory"))
		.findAdaptationOrNull(AdaptationName.forName("ebx-directory"))
		.getTable(Path.parse("/directory/users"));
		final SchemaNode[] fields1 = users.getTableOccurrenceRootNode().getNodeChildren();
		for (SchemaNode field : fields1) {
			writer.addSafeInnerHTML("field to ");
			writer.addSafeInnerHTML(field.getPathInAdaptation().format());
			writer.add("<br>");
			if(field.getRelationship()!=null) {
				writer.addSafeInnerHTML("relationship to ");
				
				if(field.getRelationship().getContainerHome()!=null) {
					writer.addSafeInnerHTML("dataspace=");
					writer.addSafeInnerHTML(field.getRelationship().getContainerHome().format());
				}
				
				final String tableNodePathInSchema = field.getRelationship().getTableNode().getPathInSchema().format();
				writer.addSafeInnerHTML(tableNodePathInSchema);
				writer.add("<br>");
			}
			writer.add("<br>");
		}

writer.add("</div>");

%>
