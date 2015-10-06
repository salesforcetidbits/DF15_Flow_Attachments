public with sharing class InlineFlowAttachment{

    //requires a flow named attachmentFlow
    public Flow.Interview.attachmentFlow myflow {get;set;}
    public String varAttachmentParentId;

    public InlineFlowAttachment(){
        myflow = new Flow.Interview.attachmentFlow(
            new map<String, object>()
        );
    }

    public String getVarAttachmentParentId(){

        if(varAttachmentParentId == null){
            varAttachmentParentId = '';
            return varAttachmentParentId;
        }

        //Workaround for more info see
        //http://salesforce.stackexchange.com/questions/562/test-class-for-visual-workflow
        if(Test.isRunningTest()){
            return [select id from case limit 1].id;
        }

        //requires attachmentFlow to have a variable named varAttachmentParentId
        return myflow.varAttachmentParentId;
    }

    public Attachment attachment {
        get {
            if(attachment == null)
            attachment = new Attachment();
            return attachment;
        }
        set;
    }
    public PageReference upload() {

        attachment.OwnerId = UserInfo.getUserId();
        attachment.parentId = getVarAttachmentParentId();

        try {
            insert attachment;
        }
        catch (DMLException e) {
            ApexPages.addMessage(
                new ApexPages.message(
                    ApexPages.severity.ERROR,'Error uploading attachment'
                )
            );
            return null;
        }
        finally {
            attachment = new Attachment();
            ApexPages.currentPage().getParameters().put('pid', '');
        }

        ApexPages.addMessage(
            new ApexPages.message(
                ApexPages.severity.INFO,'Attachment uploaded successfully'
            )
        );

        varAttachmentParentId = '';
        return null;
    }
}
