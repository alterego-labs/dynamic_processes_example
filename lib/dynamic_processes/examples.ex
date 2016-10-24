defmodule DynamicProcesses.Examples do
  alias DynamicProcesses.{SomeSupervisor, SomeWorker}

  import Supervisor.Spec

  def add_single_supervisor(id \\ "1") do
    {:ok, supervisor_spec} = build_supervisor_spec(SomeSupervisor, [], id)
    Supervisor.start_child(DynamicProcesses.Supervisor, supervisor_spec)
  end

  def add_supervisor_with_workers do
    {:ok, supervisor_pid} = add_single_supervisor
    {:ok, worker_spec1} = build_worker_spec(SomeWorker, [], "1")
    {:ok, worker_spec2} = build_worker_spec(SomeWorker, [], "2")
    Supervisor.start_child(supervisor_pid, worker_spec1)
    Supervisor.start_child(supervisor_pid, worker_spec2)
  end

  defp build_supervisor_spec(module, args, id) do
    supervisor_spec = supervisor(module, args, [id: "supervisor" <> id])
    {:ok, supervisor_spec}
  end

  defp build_worker_spec(module, args, id) do
    worker_spec = worker(module, args, [id: "worker" <> id])
    {:ok, worker_spec}
  end
end
