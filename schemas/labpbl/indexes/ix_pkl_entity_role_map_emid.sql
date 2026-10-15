-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_entity_role_map_emid
-- Type: INDEX

-- Name: ix_pkl_entity_role_map_emid; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_map_emid ON labpbl.labpbl_entity_role_map USING btree (entity_master_id);


--
