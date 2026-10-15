-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_entity_role_map_emid
-- Type: INDEX

-- Name: ix_spz_entity_role_map_emid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_entity_role_map_emid ON spz.spz_entity_role_map USING btree (entity_master_id);


--
