-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_entity_role_map_emid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_emid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_emid ON labisp.labisp_entity_role_map USING btree (entity_master_id);


--
