-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_mum_entity_language_map_ename; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_entity_language_map_ename ON tmm.tmm_entity_language_map USING btree (entity_name);


--
