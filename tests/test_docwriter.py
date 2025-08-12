import jaseci.jsorc.live_actions as lact
from jaseci.jsorc.jsorc import JsOrc
import pytest

# Load the core jaseci actions
lact.load_local_actions("jaseci_ai_kit/jac_misc.py")

@pytest.fixture(scope="module")
def jaseci_services():
    """Starts up Jaseci and loads the project"""
    # Create a Master instance
    master = JsOrc.master()
    # Load the main Jac file of your project
    master.sentinel_register(name="codebase_genius", code=open("main.jac").read())
    return {"master": master}


def test_doc_generation(jaseci_services):
    """
    Test the full documentation generation flow.
    NOTE: This test will make a real call to the OpenAI API and may incur costs.
    """
    master = jaseci_services["master"]

    # 1. Manually create a mock graph for testing
    # This simulates what Member 1's agents would do.
    master.graph_create()
    master.master_call('walker_run', 'graph_node_set', [master.active_graph_id, 'root', {'name': 'root_node'}])
    
    # Add a mock function node that needs documentation
    code_snippet = "def hello_world():\n    print('Hello, World!')"
    node_data = {'name': 'hello_world', 'type': 'function', 'code': code_snippet}
    master.master_call('graph_node_set', [master.active_graph_id, 'urn:uuid:1', node_data])
    
    # 2. Run the `init` walker from main.jac to spawn agents
    master.walker_run(name='init', gph=master.active_graph_id)

    # 3. Call the doc writer agent's ability
    payload = {"snt": master.active_snt_id, "name": "generate_docs", "gph": master.active_graph_id}
    res = master.sentinel_call(snt_id=master.active_snt_id, name='walker_run', ctx=payload)
    
    # 4. Check the result
    # Retrieve the node we created and check if it has a 'summary'
    graph_dump = master.graph_get(gph=master.active_graph_id, mode='dot') # Getting graph is easier to inspect
    print(graph_dump) # Print the graph to see the result
    
    assert "summary" in graph_dump
    assert "Hello, World" in graph_dump