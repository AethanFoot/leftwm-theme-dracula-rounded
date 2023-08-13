#!/bin/sh

export SCRIPTPATH
SCRIPTPATH="$( cd "$(dirname "$0")" || exit; pwd -P )"

pkill polybar
index=0
leftwm-state -q -n -t "$SCRIPTPATH"/sizes.liquid | sed -r '/^\s*$/d' | while read -r width
do
  barname="mainbar$index"
  monitor="$(polybar -m | tac | awk -v i="$(( index + 1 ))" 'NR==i{print}' | sed s/:.*// | tr -d '\n')"
  echo "$monitor"
  monitor=$monitor width=$(( width - 16 )) polybar -c "$SCRIPTPATH"/polybar.config $barname &
  index=$((index+1))
done
