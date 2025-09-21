/**
 * @id mcp-server-grinder/python
 * @name Custom Taint Tracking
 * @description Tracks taint from custom source to custom sink
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
        .getMember("customSource")
        .getACall()
    }

    predicate isSink(DataFlow::Node sink) {
      exists(DataFlow::CallCfgNode call |
        call = API::moduleImport("mcp_grinder_server")
          .getMember("sink_mod")
          .getMember("customSink")
          .getACall() and
        sink = call.getArg(0)
      )
  }
}

module CustomTaintTrackingConfigurationFlow = TaintTracking::Global<CustomTaintTrackingConfiguration>;

import CustomTaintTrackingConfigurationFlow::PathGraph

from CustomTaintTrackingConfigurationFlow::PathNode source, CustomTaintTrackingConfigurationFlow::PathNode sink
where CustomTaintTrackingConfigurationFlow::flowPath(source, sink) 
select sink.getNode(), source, sink, "This $@ was reached.", source.getNode(), "custom taint flow"
