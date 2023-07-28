module Helpers
  module PortableTmpdir
    TMPDIR_PATH = File.join(__dir__, "..", "..", "tmp")

    def local_tmp_dir
      if File.exist?(TMPDIR_PATH)
        clear_local_tmp_dir
      else
        FileUtils.mkdir(TMPDIR_PATH)
      end

      yield TMPDIR_PATH
    end

    private

    def clear_local_tmp_dir
      Dir.children("tmp") { |file| FileUtils.rm(File.join(TMPDIR_PATH, file)) }
    end
  end
end