####DF15 Taking Flow to the Next Level with Just Enough Code.

To see the code in action please install this managed version https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1a000000MyG0

The modal page doesn't work with some browsers (it does work in chrome).

Each class and page references a flow.  You will need to create the flows or have the classes and pages point to an existing flow.  Inside the flow, you will need to create a variable named **varAttachmentParentId**.  

The Visualforce page has a conditionally rendered output panel that contains the attachment upload components.  The condition is checking that the **varAttachmentParentId** variable has a value.  So in your flow you will need to assign and unassign that variable to meet your needs.  



