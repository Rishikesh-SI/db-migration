-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_entity_language_map_ename
-- Type: INDEX

-- Name: ix_tsk_entity_language_map_ename; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_entity_language_map_ename ON labtcs.labtcs_entity_language_map USING btree (entity_name);


--
