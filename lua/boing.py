for boing in [
    "tpope/vim-abolish",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "junegunn/vim-easy-align",
]:
    name = boing.split("/")[1]
    with open(f"./user/{name}.lua", "w") as f:
        f.write( \
f"""
local M = {{
    "{boing}",
}}

return M
""" \
)
