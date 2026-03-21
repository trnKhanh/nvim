return {
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
            organizeImports = true,
            lineLength = 100,
            lint = {
                select = { "I", "E", "F" },
                unfixable = { "F401" },
            },
        },
    },
}
