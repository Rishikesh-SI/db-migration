-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labukk.labukk_entity_language_map USING btree (entity_name);


--
