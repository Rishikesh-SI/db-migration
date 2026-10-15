-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_fan_wall_teamid
-- Type: INDEX

-- Name: ix_isl_fan_wall_teamid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_fan_wall_teamid ON isl.isl_fan_wall USING btree (team_id);


--
