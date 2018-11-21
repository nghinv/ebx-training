<%@page import="com.orchestranetworks.service.ServiceContext"%>
<%@page import="com.onwbp.base.text.UserMessage"%>
<%@page import="com.orchestranetworks.ui.UIServiceComponentWriter"%>
<%@page import="com.orchestranetworks.ui.UIFormSpec"%>
<%@page import="com.orchestranetworks.ui.UIButtonSpecSubmit"%>
<%@page import="com.orchestranetworks.ui.UIFormLabelSpec"%>
<%@page import="com.orchestranetworks.ui.form.UIFormRow"%>

<%

final ServiceContext serviceContext = ServiceContext.getServiceContext(request);
serviceContext.setTitle(UserMessage.createInfo("myTitle"));

serviceContext.addMessage(UserMessage.createInfo("a message"));

final UIServiceComponentWriter ebxWriter = serviceContext.getUIComponentWriter();
final UIFormSpec form = new UIFormSpec();
form.setURLForAction(null); // same page
ebxWriter.startForm(form);
ebxWriter.add("some text. ");
ebxWriter.addSafeInnerHTML(request.getParameter("dummyField1"));
ebxWriter.add(" <b>html-injection-test1</b>");
ebxWriter.addSafeInnerHTML(" <b>html-injection-test2</b>");

final UIFormLabelSpec dummyField1_label = new UIFormLabelSpec("dummy field 1");
final UIFormRow dummyField1_uiformrow = ebxWriter.newFormRow();
dummyField1_uiformrow.setLabel(dummyField1_label);
ebxWriter.startFormRow(dummyField1_uiformrow);
ebxWriter.add("<input name='dummyField1' value='' />");
ebxWriter.endFormRow();

final UIButtonSpecSubmit submit = new UIButtonSpecSubmit(UserMessage.createInfo("submit"), "submitName", "submitValue");
ebxWriter.addButtonSubmit(submit);

//ebxWriter.addsub
ebxWriter.endForm();

%>