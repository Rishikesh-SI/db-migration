-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_labisl_v1_entity_role_map_emid
-- Type: INDEX

-- Name: ix_labisl_v1_entity_role_map_emid; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_labisl_v1_entity_role_map_emid ON labisl_v1.labisl_v1_entity_role_map USING btree (entity_master_id);


--
