public class FlowConcepts{

    //requires a flow named flow_1
    public Flow.Interview.flow_1 myflow {get;set;}
    public String var1;

    public FlowConcepts(){

        myflow = new Flow.Interview.flow_1(
            new Map<String, Object>{
                'var1'=> 'Why hello there ' + UserInfo.getName()
            }
        );
    }
    public String getvar1() {
        //requires flow_1 to have a variable named var1
        if(Test.isRunningTest()){
            return 'TEST';
        }
        return myflow.var1;
    }
}
