-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_entity_role_map_emid
-- Type: INDEX

-- Name: ix_dd_entity_role_map_emid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_entity_role_map_emid ON dd_30_04_24.dd_entity_role_map USING btree (entity_master_id);


--
