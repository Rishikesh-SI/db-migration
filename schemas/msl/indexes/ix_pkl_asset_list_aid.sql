-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_asset_list_aid
-- Type: INDEX

-- Name: ix_pkl_asset_list_aid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_asset_list_aid ON msl.msl_asset_list USING btree (asset_id);


--
