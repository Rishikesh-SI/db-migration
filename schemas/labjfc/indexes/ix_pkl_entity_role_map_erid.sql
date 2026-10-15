-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_entity_role_map_erid
-- Type: INDEX

-- Name: ix_pkl_entity_role_map_erid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_entity_role_map_erid ON labjfc.labjfc_entity_role_map USING btree (entity_role_id);


--
