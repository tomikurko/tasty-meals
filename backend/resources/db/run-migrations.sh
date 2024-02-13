#!/bin/sh

psql -U postgres -f /db/migration/V1_0__initial.sql tastymeals
