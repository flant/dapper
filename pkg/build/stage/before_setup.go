package stage

import (
	"github.com/flant/dapp/pkg/build/builder"
	"github.com/flant/dapp/pkg/config"
	"github.com/flant/dapp/pkg/util"
)

func GenerateBeforeSetupStage(dimgConfig config.DimgInterface, extra *builder.Extra) Interface {
	b := getBuilder(dimgConfig, extra)
	if b != nil && !b.IsBeforeSetupEmpty() {
		return newBeforeSetupStage(b)
	}

	return nil
}

func newBeforeSetupStage(builder builder.Builder) *BeforeSetupStage {
	s := &BeforeSetupStage{}
	s.UserStage = newUserStage(builder)
	return s
}

type BeforeSetupStage struct {
	*UserStage
}

func (s *BeforeSetupStage) Name() StageName {
	return BeforeSetup
}

func (s *BeforeSetupStage) GetContext(_ Cache) string {
	return util.Sha256Hash(
		s.builder.BeforeSetupChecksum(),
		s.GetStageDependenciesChecksum(BeforeSetup),
	)
}
