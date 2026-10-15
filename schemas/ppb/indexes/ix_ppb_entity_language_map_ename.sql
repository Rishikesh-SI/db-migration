-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ppb_entity_language_map_ename; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_entity_language_map_ename ON ppb.ppb_entity_language_map USING btree (entity_name);


--
