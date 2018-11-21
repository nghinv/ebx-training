package com.on.ps.mdm.training;

import javax.servlet.http.HttpServletRequest;

import com.onwbp.adaptation.Adaptation;
import com.onwbp.adaptation.AdaptationName;
import com.onwbp.adaptation.AdaptationTable;
import com.onwbp.base.text.UserMessage;
import com.orchestranetworks.instance.HomeKey;
import com.orchestranetworks.schema.Path;
import com.orchestranetworks.schema.SchemaNode;
import com.orchestranetworks.schema.relationships.RelationshipsHelper;
import com.orchestranetworks.service.ServiceContext;
import com.orchestranetworks.ui.UIServiceComponentWriter;

public final class IntrospectionService {

	private IntrospectionService() {
		// TODO Auto-generated constructor stub
	}
	
	public final static void execute(final HttpServletRequest req) {
		final ServiceContext serviceContext = ServiceContext.getServiceContext(req);
		serviceContext.setTitle(UserMessage.createInfo("Data Model introspection"));		
		
		final UIServiceComponentWriter writer = serviceContext.getUIComponentWriter();
		
		writer.addSafeInnerHTML(serviceContext.getCurrentNode().getPathInSchema().format());
		
		final SchemaNode[] fields = serviceContext.getCurrentNode().getTableOccurrenceRootNode().getNodeChildren();
		if(fields!=null) {
			for (final SchemaNode field : fields) {
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
				}
			}
		}
		
		////
		final AdaptationTable users = serviceContext.getCurrentHome().getRepository().lookupHome(HomeKey.parse("Bebx-directory"))
		.findAdaptationOrNull(AdaptationName.forName("ebx-directory"))
		.getTable(Path.parse("/directory/users"));
		
		final Adaptation userRecord = (Adaptation)users.selectOccurrences(null).get(0);
		
		//RelationshipsHelper.getIntraDatasetReferringRecords(userRecord, aReferringNode, aSession)
		//users.getTableOccurrenceRootNode().getNode(aPath)
		
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
				
				field.getRelationship().
				
				writer.addSafeInnerHTML(tableNodePathInSchema);
			}
		}
	}

}
