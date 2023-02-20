#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

SPACE_ICONS=("" " " " " " " "" "" "" " " " " "10")

separator=(
	icon=
	icon.font="Liga SFMono Nerd Font:Regular:16.0"
	background.padding_left=17
	background.padding_right=10
	label.drawing=off
	associated_display=active
	click_script='yabai -m space --create
                                            sketchybar --trigger space_change'
	icon.color="$TEXT"
)

space=(
	icon.font="Liga SFMono Nerd Font:Bold:16.0"
	icon.padding_left=10
	icon.padding_right=15
	background.padding_left=2
	background.padding_right=2
	label.padding_right=20
	label.font="sketchybar-app-font:Regular:16.0"
	label.background.height=26
	label.background.drawing=on
	label.background.color="$SURFACE1"
	label.background.corner_radius=8
	label.drawing=off
	script="$PLUGIN_DIR/space.sh"
)

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))

	sketchybar 	--add space space.$sid left 								\
							--set space.$sid associated_space=$sid 			\
							icon="${SPACE_ICONS[i]}" 										\
							icon.highlight_color="$(getRandomCatColor)" \
							"${space[@]}" 															\
							--subscribe space.$sid mouse.clicked
done

sketchybar 	--add bracket spaces '/space\..*/' 				\
						--set spaces background.color="$SURFACE0" \
						background.border_color="$SURFACE1" 			\
						background.border_width=2 								\
						background.drawing=on

sketchybar 	--add item separator left 								\
						--set separator "${separator[@]}"
