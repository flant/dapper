package stage

import "github.com/flant/dapp/pkg/image"

func NewGALatestPatchStage(baseStageOptions *NewBaseStageOptions) *GALatestPatchStage {
	s := &GALatestPatchStage{}
	s.GAPatchStage = newGAPatchStage(baseStageOptions)
	return s
}

type GALatestPatchStage struct {
	*GAPatchStage
}

func (s *GALatestPatchStage) Name() StageName {
	return GALatestPatch
}

func (s *GALatestPatchStage) IsEmpty(_ Conveyor, prevBuiltImage image.Image) (bool, error) {
	if s.willLatestCommitBeBuiltOnGAArchiveStage(prevBuiltImage) {
		return true, nil
	}

	isEmpty := true
	for _, ga := range s.gitArtifacts {
		if empty, err := ga.IsPatchEmpty(prevBuiltImage); err != nil {
			return false, err
		} else if !empty {
			isEmpty = false
			break
		}
	}

	return isEmpty, nil
}
