return {
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedImport = false,
                    reportExplicitAny = false,
                    reportAny = false,
                    reportUnknownMemberType = false,
                    reportMissingTypeStubs = false,
                },
            },
        },
    },
}
