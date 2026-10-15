-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labdd_v1.labdd_v1_entity_language_map USING btree (entity_name);


--
