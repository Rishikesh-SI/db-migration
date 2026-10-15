-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labtkrold.labtkr_entity_role_map USING btree (entity_master_id);


--
