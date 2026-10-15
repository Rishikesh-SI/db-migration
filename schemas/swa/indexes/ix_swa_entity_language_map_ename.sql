-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_entity_language_map_ename
-- Type: INDEX

-- Name: ix_swa_entity_language_map_ename; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_entity_language_map_ename ON swa.swa_entity_language_map_newbk USING btree (entity_name);


--
