module TabletopSimulator
  module Importers
    module SavedObjectsManipulator
      def initialize_directory_pointers(saved_objects_folder, base_directory)
        @saved_objects_folder = saved_objects_folder
        @base_directory = base_directory
      end

      def save_file(filename, content, folders)
        dir_path = path_in_saved_objects(folders)
        FileUtils.mkdir_p(dir_path)

        path = File.join(dir_path, filename)
        File.write(path, content)
      end

      def clear_saved_objects(folders)
        dir_path = path_in_saved_objects(folders)
        FileUtils.rm(Dir.glob("#{dir_path}/*"))
      end

      private

      def path_in_saved_objects(folders)
        File.join(@saved_objects_folder, @base_directory, folders)
      end
    end
  end
end
