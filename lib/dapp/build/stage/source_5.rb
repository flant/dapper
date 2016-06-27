module Dapp
  module Build
    module Stage
      class Source5 < SourceBase
        def initialize(build)
          @prev_stage = Source4.new(build, self)
          @build = build
        end

        def prev_source_stage
          prev_stage
        end

        def next_source_stage
          nil
        end

        def image
          super do |image|
            image.add_expose(build.conf[:exposes]) unless build.conf[:exposes].nil?
          end
        end

        protected

        def layer_commit_write!(_git_artifact)
          nil
        end
      end # Source5
    end # Stage
  end # Build
end # Dapp
