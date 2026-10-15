-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_client_league_map_cid
-- Type: INDEX

-- Name: ix_gpn_client_league_map_cid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_client_league_map_cid ON gpn.gpn_client_league_map USING btree (client_id);


--
