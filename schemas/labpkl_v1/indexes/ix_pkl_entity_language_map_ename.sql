-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_pkl_entity_language_map_ename; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_entity_language_map_ename ON labpkl_v1.labpkl_v1_entity_language_map USING btree (entity_name);


--
