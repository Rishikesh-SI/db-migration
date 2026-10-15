-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_player_fan_pollmid
-- Type: INDEX

-- Name: ix_scup_player_fan_pollmid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_player_fan_pollmid ON u17wc.u17wc_player_fan_poll USING btree (match_id);


--
