-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: ix_ttmum_entity_role_map_erid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_map_erid; Type: INDEX; Schema: labbr; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_map_erid ON labbr.labbr_entity_role_map USING btree (entity_role_id);


--
