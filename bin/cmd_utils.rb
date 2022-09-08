require "open3"
require "pathname"

PROJECT_ROOT = Pathname.new(File.dirname(__FILE__)).join("..")

def stream_output(io_in:, io_out:)
  Thread.new do
    until (char = io_in.getc).nil?
      io_out.print char
      io_out.flush
    end
  end
end

def run_command(cmd)
  exit_status = nil # scope hack
  Open3.popen3(cmd) { |stdin, stdout, stderr, wait_thread|
    threads = [wait_thread]
    threads << stream_output( io_in: stdout, io_out: $stdout )
    threads << stream_output( io_in: stderr, io_out: $stderr )

    threads.each(&:join)

    exit_status = wait_thread.value
  }
  return exit_status.success?
end

