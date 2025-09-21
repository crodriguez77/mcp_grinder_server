/**
 * @id mcp-server-grinder/python
 * @name Some name
 * @description Some description
 * @tags security
 * @kind path-problem
 * @severity error
 */

import python
import semmle.python.dataflow.new.TaintTracking
import semmle.python.dataflow.new.DataFlow
import semmle.python.ApiGraphs 
import semmle.python.Concepts

module CustomTaintTrackingConfiguration implements DataFlow::ConfigSig {
    predicate isSource(DataFlow::Node source) {
      source = API::moduleImport("mcp_grinder_server")
        .getMember("source_mod")
        .getMember("getSensitiveData")
        .getACall()
    }

    predicate isSink(DataFlow::Node sink) {
      exists(DataFlow::CallCfgNode call |
        call = API::moduleImport("mcp_grinder_server")
          .getMember("sink_mod")
          .getMember("writeToExternalStorage")
          .getACall() and
        sink = call.getArg(0)
      )
  }
}

module CustomTaintTrackingConfigurationFlow = TaintTracking::Global<CustomTaintTrackingConfiguration>;

import CustomTaintTrackingConfigurationFlow::PathGraph

from CustomTaintTrackingConfigurationFlow::PathNode source, CustomTaintTrackingConfigurationFlow::PathNode sink
where CustomTaintTrackingConfigurationFlow::flowPath(source, sink) 
select sink.getNode(), source, sink, "This $@ is written to a log file.", source.getNode(), "potentially sensitive information"
