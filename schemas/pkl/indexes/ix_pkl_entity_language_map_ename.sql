-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_language_map_ename
-- Type: INDEX

-- Name: ix_pkl_entity_language_map_ename; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_language_map_ename ON pkl.pkl_entity_language_map USING btree (entity_name);


--
