#!/bin/bash

# CPU usage (average over 1 second)
cpu=$(mpstat 1 1 | awk '/Average:/ {printf "%.0f", 100 - $12}')

# Memory usage (percentage)
mem=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# GPU usage and temp (amdgpu_top, needs root for full info, but --json works for user)
gpu_stats=$(amdgpu_top --json -d 1 2>/dev/null | tail -n 1)
gpu_usage=$(echo "$gpu_stats" | jq '.[] | .gpu_activity' | head -n 1)
gpu_temp=$(echo "$gpu_stats" | jq '.[] | .temperature' | head -n 1)

# Fallback if amdgpu_top fails
if [[ -z "$gpu_usage" || "$gpu_usage" == "null" ]]; then
  gpu_usage="?"
fi
if [[ -z "$gpu_temp" || "$gpu_temp" == "null" ]]; then
  # Try sensors as fallback
  gpu_temp=$(sensors | grep -m 1 -A 0 'edge:' | awk '{print int($2)}')
  [[ -z "$gpu_temp" ]] && gpu_temp="?"
fi

# Output for Waybar
echo "{\"text\":\" $cpu% |  $gpu_usage% |  $mem% |  $gpu_temp°C\"}"
