public with sharing class ModalFlowAttachment{

    //requires a flow named attachmentFlow
    public Flow.Interview.attachmentFlow myflow {get;set;}
    public String varAttachmentParentId;

    public ModalFlowAttachment(){
        myflow  = new Flow.Interview.attachmentFlow(
            new map<String, object>{
                'varAttachmentParentId'=> ''
            }
        );
    }
    public String getVarAttachmentParentId() {
        if(varAttachmentParentId == null){
            varAttachmentParentId = '';
            return '';
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
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    public PageReference upload() {

        attachment.OwnerId = UserInfo.getUserId();
        attachment.ParentId = getVarAttachmentParentId();

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
        }

        ApexPages.addMessage(
            new ApexPages.message(
                ApexPages.severity.INFO,'Attachment uploaded successfully'
            )
        );

        varAttachmentParentId = null;
        return null;
    }
}
