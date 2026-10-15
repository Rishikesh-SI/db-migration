-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labetpl.labetpl_entity_language_map USING btree (entity_name);


--
