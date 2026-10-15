-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labacko.labacko_entity_role_map USING btree (entity_master_id);


--
