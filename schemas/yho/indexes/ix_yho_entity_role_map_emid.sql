-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_entity_role_map_emid
-- Type: INDEX

-- Name: ix_yho_entity_role_map_emid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_entity_role_map_emid ON yho.yho_entity_role_map USING btree (entity_master_id);


--
