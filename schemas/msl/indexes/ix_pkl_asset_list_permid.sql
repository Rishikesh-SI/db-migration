-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_asset_list_permid
-- Type: INDEX

-- Name: ix_pkl_asset_list_permid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_permid ON msl.msl_asset_list USING btree (primary_entity_role_map_id);


--
