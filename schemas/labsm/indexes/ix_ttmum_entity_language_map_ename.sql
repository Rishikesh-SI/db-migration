-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labsm; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labsm.labsm_entity_language_map USING btree (entity_name);


--
