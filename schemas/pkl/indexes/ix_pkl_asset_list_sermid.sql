-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_asset_list_sermid
-- Type: INDEX

-- Name: ix_pkl_asset_list_sermid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_sermid ON pkl.pkl_asset_list USING btree (secondary_entity_role_map_id);


--
