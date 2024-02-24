extends Node

const ICONS = [
	{
		"extensions": ["rs"],
		"icon": "",
		"color": "#f74c00"
	},
	{
		"extensions": ["py"],
		"icon": "",
		"color": "#f74c00"
	},
	{
		"extensions": ["js"],
		"icon": "",
		"color": "#f7df1e"
	},
	{
		"extensions": ["html"],
		"icon": "",
		"color": "#e34c26"
	},
	{
		"extensions": ["css"],
		"icon": "",
		"color": "#2965f1"
	},
	{
		"extensions": ["go"],
		"icon": "",
		"color": "#00aeda"
	},
	{
		"extensions": ["java"],
		"icon": "",
		"color": "#f89820"
	},
	{
		"extensions": ["c"],
		"icon": "",
		"color": "#659bd3"
	},
	{
		"extensions": ["cpp"],
		"icon": "",
		"color": "#659bd3"
	},
	{
		"extensions": ["rb"],
		"icon": "",
		"color": "#cc341f"
	},
	{
		"extensions": ["php"],
		"icon": "",
		"color": "#787cb4"
	},
	{
		"extensions": ["swift"],
		"icon": "",
		"color": "#f05035"
	},
	{
		"extensions": ["dart"],
		"icon": "",
		"color": "#2cb7f6"
	},
	{
		"extensions": ["scala"],
		"icon": "",
		"color": "#df311e"
	},
	{
		"extensions": ["lua"],
		"icon": "",
		"color": "#000081"
	},
	{
		"extensions": ["ts", "tsx"],
		"icon": "",
		"color": "#2d79c7"
	},
	{
		"extensions": ["bash", "sh", "zsh", "fish"],
		"icon": "",
		"color": "#3e474a"
	},
	{
		"extensions": ["cs"],
		"icon": "",
		"color": "#a27add"
	},
	{
		"extensions": ["hs"],
		"icon": "",
		"color": "#5e4f87"
	},
	{
		"extensions": ["clj"],
		"icon": "",
		"color": "#92dd45"
	},
	{
		"extensions": ["ex"],
		"icon": "",
		"color": "#553366"
	},
	{
		"extensions": ["erl"],
		"icon": "",
		"color": "#a90533"
	},
	{
		"extensions": ["coffee"],
		"icon": "",
		"color": "#29334c"
	},
	{
		"extensions": ["jsx", "react"],
		"icon": "",
		"color": "#087ea4"
	},
	{
		"extensions": ["vue"],
		"icon": "",
		"color": "#3fb984"
	},
	{
		"extensions": ["ng"],
		"icon": "",
		"color": "#de002d"
	},
	{
		"extensions": ["svelte"],
		"icon": "",
		"color": "#ff3e00"
	},
	{
		"extensions": ["docker"],
		"icon": "",
		"color": "#1d63ed"
	},
	{
		"extensions": ["tf"],
		"icon": "",
		"color": "#31a8ff"
	},
	{
		"extensions": ["json"],
		"icon": "",
		"color": "#f7df1e"
	},
	{
		"extensions": ["xml"],
		"icon": "󰗀",
		"color": "#f29c1f"
	},
	{
		"extensions": ["md"],
		"icon": "",
		"color": "#435761"
	},
	{
		"extensions": ["ini", "cfg", "toml", "bat", "cmd", "vbs", "vba", "reg", "yml", "yaml", "log"],
		"icon": "",
		"color": "#575757"
	},
	{
		"extensions": ["sql", "sqlite", "mysql", "psql", "mongo", "redis", "cassandra", "hbase", "oracle", "db2", "sybase", "informix", "teradata", "netezza", "greenplum", "vertica", "redshift", "snowflake", "bigquery"],
		"icon": "",
		"color": "#d47131"
	},
	{
		"extensions": ["lock"],
		"icon": "",
		"color": "#575757"
	}
]

func get_icon_data(extension: String) -> Dictionary:
	for icon in ICONS:
		if extension in icon["extensions"]:
			return icon
	return { "extensions": ["*"], "icon": "󰈔", "color": "#ffffff" }
