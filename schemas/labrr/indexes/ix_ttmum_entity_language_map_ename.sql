-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labrr.labrr_entity_language_map USING btree (entity_name);


--
