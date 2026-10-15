-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_pbl_entity_language_map_ename; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_entity_language_map_ename ON pbl.pbl_entity_language_map USING btree (entity_name);


--
