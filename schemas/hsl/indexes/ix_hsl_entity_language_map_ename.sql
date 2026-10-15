-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_hsl_entity_language_map_ename; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_language_map_ename ON hsl.hsl_entity_language_map USING btree (entity_name);


--
