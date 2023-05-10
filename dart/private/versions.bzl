"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
TOOL_VERSIONS = {
    "1.14.2": {
        "x86_64-apple-darwin": "sha384-ws4+rANvv0YxM1SgIBUXSG9jT8dKw83nls6R5qYkEKzPUB+viBIEozSsyq2e6i+f",
        "aarch64-apple-darwin": "sha384-HcvJbxoJtGSavkGu0e7CyD00cBlmDb0TBWJ4JSaNa70zuU3N7XlMOYm3bbQcAv2U",
        "x86_64-pc-windows-msvc": "sha384-35YN6TKpT0L9qyRBmq48NucvyXEtHnkeC+txf2YZmmJTmOzrAKREA74BA0EZvpar",
        "x86_64-unknown-linux-gnu": "sha384-QgGOwTaetxY0h5HWCKc/3ZtBs4N/fgaaORthn7UcEv++Idm9W+ntCCZRwvBdwHPD",
    },
    # TODO: allow users to specify their own sha
    "1.19.0": {
        "x86_64-apple-darwin": "sha384-el4SwcRXIVST+BkkrYVwRPY4WaJ+amEk0DifTWZKVEppdtTPTdoXdzUWK+2lLFeB",
        "aarch64-apple-darwin": "sha384-OR0UtTdWHjgbfxoRh3OzI0+XB4WhCmsFo3mkFIJshRYWJJaaBgsnIWC15Yabdvmm",
        "x86_64-pc-windows-msvc": "sha384-rkYgR+tL6l3A9Deknjfms5H1SoZac0SxDfLXpYOP7Kdp4bhqSsnmZc3CQPPVncIA",
        "x86_64-unknown-linux-gnu": "sha384-P1YR/T4Ndwlu5BKkQWyUX3q6oTfISo3FresToOpnFSiqIylZ+IRKSCfYICryVcNY",
    },
}
