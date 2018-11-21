package com.on.ps.mdm.training;

import javax.servlet.http.HttpServletRequest;

import com.onwbp.base.text.UserMessage;
import com.orchestranetworks.module.ModuleContextOnRepositoryStartup;
import com.orchestranetworks.module.ModuleRegistrationServlet;
import com.orchestranetworks.service.OperationException;
import com.orchestranetworks.service.ServiceContext;
import com.orchestranetworks.ui.UIButtonSpecSubmit;
import com.orchestranetworks.ui.UIFormLabelSpec;
import com.orchestranetworks.ui.UIFormSpec;
import com.orchestranetworks.ui.UIServiceComponentWriter;
import com.orchestranetworks.ui.form.UIFormRow;

public class RegisterServlet extends ModuleRegistrationServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void handleRepositoryStartup(ModuleContextOnRepositoryStartup arg0) throws OperationException {
		
	}
	
	public void abc() {
		HttpServletRequest req = null;
		req.getParameter("");
		
		
		final ServiceContext serviceContext = ServiceContext.getServiceContext(null);
		serviceContext.setTitle(UserMessage.createInfo("myTitle"));
		
		serviceContext.addMessage(UserMessage.createInfo("a message"));
		
		final UIServiceComponentWriter ebxWriter = serviceContext.getUIComponentWriter();
		final UIFormSpec form = new UIFormSpec();
		//form.setURLForAction("");
		ebxWriter.startForm(form);
		ebxWriter.add("some text.");
		//ebxWriter.add(request.getParameter("dummyField1"));

		final UIFormLabelSpec dummyField1_label = new UIFormLabelSpec("dummy field 1");
		final UIFormRow dummyField1_uiformrow = ebxWriter.newFormRow();
		dummyField1_uiformrow.setLabel(dummyField1_label);
		ebxWriter.startFormRow(dummyField1_uiformrow);
		
		ebxWriter.add("<input name='dummyField1' value='' />");
		//ebxWriter.addSafeAttribute("name", "dummyField1")
		//ebxWriter.addSafeAttribute("value", "")
		//ebxWriter.addSafeInnerHTML("<b>html injection test</b>");
		
		ebxWriter.endFormRow();
		
		final UIButtonSpecSubmit submit = new UIButtonSpecSubmit(UserMessage.createInfo("submit"), "submitName", "submitValue");
		ebxWriter.addButtonSubmit(submit);
//		ebxWriter.addsub
		ebxWriter.endForm();
	}

}
