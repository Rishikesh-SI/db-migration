-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_role_map_erid
-- Type: INDEX

-- Name: ix_pkl_entity_role_map_erid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_map_erid ON pkl.pkl_entity_role_map USING btree (entity_role_id);


--
