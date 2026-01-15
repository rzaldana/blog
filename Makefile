.PHONY: test

.image_tags: ./test/Dockerfile SUPPORTED_BASH_VERSIONS
	@./scripts/build_test_containers

blog.bash: ./src/core.bash ./src/interface.bash
	@./submodules/blink/blink ./src/interface.bash blog.bash

test: .image_tags blog.bash
	@./scripts/test
