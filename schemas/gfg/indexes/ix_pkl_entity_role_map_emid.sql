-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_entity_role_map_emid
-- Type: INDEX

-- Name: ix_pkl_entity_role_map_emid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_entity_role_map_emid ON gfg.gfg_entity_role_map USING btree (entity_master_id);


--
