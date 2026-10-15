-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_player_fan_polltid
-- Type: INDEX

-- Name: ix_isl_player_fan_polltid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_player_fan_polltid ON isl.isl_player_fan_poll USING btree (team_id);


--
