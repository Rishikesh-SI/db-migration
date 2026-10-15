-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labhkind.labhkind_entity_language_map USING btree (entity_name);


--
