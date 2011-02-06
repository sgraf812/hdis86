#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 path/to/udis86-1.x/" >&2
  exit 1
fi

cat <<EOF
{-# LANGUAGE
    DeriveDataTypeable #-}
module Udis86.Instructions where
-- generated by geninst.bash, do not exit

import Data.Typeable ( Typeable )
import Data.Data ( Data )

EOF

echo "data Opcode"

PFX=" ="
grep '^  UD_' $1/libudis86/itab.h | sed 's/^  UD_//; s/,//' | \
  while read inst; do
    echo "$PFX $inst"
    PFX=" |"
  done

echo " deriving (Eq, Ord, Show, Read, Enum, Bounded, Typeable, Data)"