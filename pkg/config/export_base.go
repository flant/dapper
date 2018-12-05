package config

type ExportBase struct {
	Add          string
	To           string
	IncludePaths []string
	ExcludePaths []string
	Owner        string
	Group        string

	raw *rawExportBase
}

func (c *ExportBase) validate() error {
	if c.Add == "" || !isAbsolutePath(c.Add) {
		return newDetailedConfigError("`add: PATH` absolute path required for import!", c.raw.rawOrigin.configSection(), c.raw.rawOrigin.doc())
	} else if c.To == "" || !isAbsolutePath(c.To) {
		return newDetailedConfigError("`to: PATH` absolute path required for import!", c.raw.rawOrigin.configSection(), c.raw.rawOrigin.doc())
	} else if !allRelativePaths(c.IncludePaths) {
		return newDetailedConfigError("`includePaths: [PATH, ...]|PATH` should be relative paths!", c.raw.rawOrigin.configSection(), c.raw.rawOrigin.doc())
	} else if !allRelativePaths(c.ExcludePaths) {
		return newDetailedConfigError("`excludePaths: [PATH, ...]|PATH` should be relative paths!", c.raw.rawOrigin.configSection(), c.raw.rawOrigin.doc())
	}
	return nil
}
