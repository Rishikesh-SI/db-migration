-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_role_map_emid
-- Type: INDEX

-- Name: ix_stn_entity_role_map_emid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_role_map_emid ON stn.stn_entity_role_map USING btree (entity_master_id);


--
