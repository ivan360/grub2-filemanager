# Grub2-FileManager
# Copyright (C) 2017  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.

function hidden_menu {
	set theme=${prefix}/themes/slack/theme.txt; export theme;
	hiddenentry "Settings" --hotkey=s {
		configfile $prefix/settings.sh;
	}
	hiddenentry "Lua" --hotkey=l {
		lua;
	}
	hiddenentry "Boot" --hotkey=b {
		action="osdetect"; export action;
		configfile $prefix/clean.sh;
	}
	hiddenentry "Reboot" --hotkey=r {
		reboot;
	}
	hiddenentry "Halt" --hotkey=h {
		halt;
	}
}
if [ "$action" = "open" ]; then
	hidden_menu;
	lua $prefix/open.lua;
elif [ "$action" = "osdetect" ]; then
	lua $prefix/osdetect.lua;
elif [ "$action" = "text" ]; then
	set theme=${prefix}/themes/slack/text.txt;
	hiddenentry " " --hotkey=n{
		if [ "$encoding" = "gbk" ]; then
			encoding="utf8";
		else
			encoding="gbk";
		fi
		export encoding;
		configfile $prefix/clean.sh;
	}
	hiddenentry " " --hotkey=q{
		action="open"; export action;
		configfile $prefix/clean.sh;
	}
	lua $prefix/text.lua;
elif [ "$action" = "hex" ]; then
	set theme=${prefix}/themes/slack/hex.txt;
	hiddenentry " " --hotkey=q{
		action="open"; export action;
		configfile $prefix/clean.sh;
	}
	lua $prefix/hex.lua;
else
	hidden_menu;
	lua $prefix/main.lua;
fi;