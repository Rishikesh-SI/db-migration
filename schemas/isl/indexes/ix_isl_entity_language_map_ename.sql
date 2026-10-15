-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_isl_entity_language_map_ename; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_language_map_ename ON isl.isl_entity_language_map USING btree (entity_name);


--
