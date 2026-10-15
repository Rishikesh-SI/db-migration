-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_asset_list_sermid
-- Type: INDEX

-- Name: ix_pkl_asset_list_sermid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_asset_list_sermid ON labjfc.labjfc_asset_list USING btree (secondary_entity_role_map_id);


--
