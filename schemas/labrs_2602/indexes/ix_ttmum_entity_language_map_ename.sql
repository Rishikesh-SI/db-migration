-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labrs_2602.labrs_entity_language_map USING btree (entity_name);


--
