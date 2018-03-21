#!/usr/bin/env bash

# shellcheck shell=bash

# ``````````````````````````````````````````````````````````````````````````````
# Function name: port_scan()
#
# Description:
#   Sample module.
#
# Usage:
#   port_scan
#
# Examples:
#   port_scan
#

function port_scan() {

  # shellcheck disable=SC2034
  local _FUNCTION_ID="port_scan"
  local _STATE=0

  # User variables:
  # - module_name: store module name
  # - module_args: store module arguments

  _module_show=
  _module_help=

  # shellcheck disable=SC2034
  _module_variables=()

  # shellcheck disable=SC2034
  author="trimstray"
  contact="contact@nslab.at"
  version="1.0"
  category="ports"

  # shellcheck disable=SC2034,SC2154
  _module_cfg="${_modules}/${module_name}.cfg"

  touch "$_module_cfg"

  # shellcheck disable=SC2034,SC2154
  _module_show=$(printf "%s" "
    Module: ${module_name}
    Author: ${author}
   Contact: ${contact}
   Version: ${version}
  Category: ${category}
")

  # shellcheck disable=SC2034,SC2154
  _module_help=$(printf "%s" "
  Module: ${module_name}

    Description
    -----------

      Zenmap predefined commands.

    Commands
    --------

      list                          display scanning list commands
      init     <value>              run predefined scanning command

      Options:

        <key>                       key value

    Examples
    --------

      init tcp_conn                 run TCP connect profile
")

  # shellcheck disable=SC2034
  export _module_opts=(\
  "$_module_show" \
  "$_module_help")

  # shellcheck disable=SC2154
  if [[ "$_mstate" -eq 0 ]] ; then

    if [[ -e "$_module_cfg" ]] && [[ -s "$_module_cfg" ]] ; then

      # shellcheck disable=SC1090
      source "$_module_cfg"

    else

      # shellcheck disable=SC2034
      _module_variables=()

      if [[ "${#_module_variables[@]}" -ne 0 ]] ; then

        printf "_module_variables=(\"%s\")\n" "${_module_variables[@]}" > "$_module_cfg"

      fi

      _mstate=1

    fi

  else

    # shellcheck disable=SC1090
    source "$_module_cfg"

  fi

  # shellcheck disable=SC2034
  _module_commands=(\
  "TCP connect;'';tcp_conn;-sT $dst" \
  "TCP SYN scan;'';tcp_syn;-sS $dst" \
  "UDP ports scan;'';udp;-sU $dst" \
  "Ports and ignore discovery;'';ports_not_disc;-Pn -F $dst" \
  )

  return $_STATE

}
