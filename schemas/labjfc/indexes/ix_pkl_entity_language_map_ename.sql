-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_pkl_entity_language_map_ename; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_entity_language_map_ename ON labjfc.labjfc_entity_language_map USING btree (entity_name);


--
